//
//  MineLeYingTableViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/16.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MineLeYingTableViewController.h"
#import "MineLeYingTableViewCell.h"
#import "getAboutArtistData.h"
#import "userMessage.h"
#import "UNfinishDetailViewController.h"
@interface MineLeYingTableViewController ()
@property (nonatomic,strong)NSMutableArray *leyingArr;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)NSMutableArray *leyArr;
@property (nonatomic,strong)NSDictionary *myDic;

@end

@implementation MineLeYingTableViewController


-(void)viewWillAppear:(BOOL)animated
{
    //加载乐影
//    [self getArtcollectWithpage:@"1" Type:@"1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    self.leyArr = [NSMutableArray array];
    self.myDic = [NSDictionary dictionary];
    [self.tableView registerClass:[MineLeYingTableViewCell class] forCellReuseIdentifier:@"MineLeYingTableViewCell"];
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        //加载乐影
        [self getArtcollectWithpage:@"1" Type:@"1"];
        [self p_setupRefresh];
        [self.tableView reloadData];
        self.index = 1;

//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            //加载乐影
//            [self getArtcollectWithpage:@"1" Type:@"1"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                 [self p_setupRefresh];
//                [self.tableView reloadData];
//                
//            });
//        });
//        
       
    }
  
    
    
}


#pragma mark - 上拉加载 下拉刷新
/////////////////////////////////////////////////////
-(void)p_setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.tableView.headerPullToRefreshText = @"下拉";
//    self.tableView.headerReleaseToRefreshText = @"松开刷新";
//    self.tableView.headerRefreshingText = @"玩命加载中...";
//    
//    self.tableView.footerPullToRefreshText = @"上拉";
//    self.tableView.footerReleaseToRefreshText = @"松开加载";
//    self.tableView.footerRefreshingText = @"玩命加载中...";
}

// 开始进入刷新状态
- (void)headerRereshing
{
    self.index = 1;
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        self.leyArr = [NSMutableArray array];
        [self getArtcollectWithpage:@"1" Type:@"1"];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            self.leyArr = [NSMutableArray array];
//            [self getArtcollectWithpage:@"1" Type:@"1"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//                [self.tableView headerEndRefreshing];
//            });
//        });
    }
    
}

// 开始进入加载状态
- (void)footerRereshing
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 1.加载更多数据
        
        [self getArtcollectWithpage:[NSString stringWithFormat:@"%ld",(long)++self.index] Type:@"1"];
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self getArtcollectWithpage:[NSString stringWithFormat:@"%ld",(long)++self.index] Type:@"1"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//                [self.tableView footerEndRefreshing];
//            });
//        });
    }
    
    
    
}
-(BOOL)getDelcollectWithId:(NSString *)myId Type:(NSString *)mytype
{
  
    

    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/delshoucang.html"];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        [request setHTTPMethod:@"POST"];
        
        // 准备参数
        NSString *argument = [NSString stringWithFormat:@"id=%@&type=%@",myId,mytype];
        NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
        //设置URl参数
        [request setHTTPBody:argDada];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.myDic = dict;
        
        
    }
    if ( [[NSString stringWithFormat:@"%@",[[self.myDic objectForKey:@"datas"] objectForKey:@"success"]] isEqualToString:@"1"])
    {
        // 删除成功
        return YES;
    }
    else
    {
        // 删除失败
        return NO;
    }
  
}
-(void)getArtcollectWithpage:(NSString *)myPage Type:(NSString *)mytype
{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/shoucanglist.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"page=%@&type=%@",myPage,mytype];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [[dict objectForKey:@"datas"]objectForKey:@"list"];
    
    self.leyingArr = [NSMutableArray array];
    if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"login"]] isEqualToString:@"0"])
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
       
        [alView show];
    }
    else
    {
      
   
        if (![[NSString stringWithFormat:@"%@",[[dict objectForKey:@"datas"]objectForKey:@"list"]] isEqualToString:@"0"])
        {
            
            for (NSDictionary * dict in arr)
            {
                userMessage * m = [[userMessage alloc] init];
                [m setValuesForKeysWithDictionary:dict];
                [self.leyingArr addObject:m];
            }
            
            if ([myPage isEqualToString:@"1"])
            {
                self.leyArr = _leyingArr;
            }
            else
            {
                // 赋值
                for (int i = 0; i < _leyingArr.count; i++)
                {
                    [_leyArr addObject:_leyingArr[i]];
                }
            }

        }
        else
        {
            // list没有值的时候，还要判断当前的leyarr.count是否为0
            if (self.leyArr.count != 1)
            {
                // 是上拉加载page没有请求到数据
                
            }
            else
            {
                [self.leyArr removeAllObjects];
            }
        }
  
    }

    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.leyArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineLeYingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineLeYingTableViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f blue:222/255.0f alpha:1.0];
    userMessage *u = self.leyArr[indexPath.row];
     NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
    if ([u.titlepic isEqualToString:@""])
    {
        cell.imgShows.image = [UIImage imageNamed:@"yiren2"];
    }
    else
    {
        NSString *str2 = u.titlepic;
        [cell.imgShows sd_setImageWithURL:[NSURL URLWithString:[str1 stringByAppendingString:str2]]];
        
    }
    cell.lblTitle.text = u.title;
    //cell.imgDelet  = [UIImage imageNamed:@"huishou"];
    [cell.imgDelete setImage:[UIImage imageNamed:@"huishou1.png"] forState:UIControlStateNormal];
    cell.imgDelete.tag = [u.Id integerValue];
    [cell.imgDelete addTarget:self action:@selector(delImageClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
    // Configure the cell...
    
    return cell;
}
//删除收藏
//删除收藏
-(void)delImageClick:(UIButton *)sender
{
    if ([self getDelcollectWithId: [NSString stringWithFormat:@"%ld",(long)sender.tag] Type:@"1"]) {
        // 删除成功  弹出对话框提示
        //        [self getArtcollectWithpage:@"1" Type:@"1"];
        //        [self.tableView reloadData];
    }
    else
    {
        // 删除失败  弹出对话框提示
    }
    
    if (self.leyArr.count == 1) {
        [self.leyArr removeAllObjects];
        [self.tableView reloadData];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getArtcollectWithpage:@"1" Type:@"1"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 232;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    userMessage *u = self.leyArr[indexPath.row];
    UNfinishDetailViewController *unVC = [[UNfinishDetailViewController alloc]init];
    unVC.index = u.Id;
    [self.navigationController pushViewController:unVC animated:YES];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
