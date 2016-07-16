//
//  BuyMyselfTableViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "BuyMyselfTableViewController.h"
#import "BuyMyselfTableViewCell.h"
#import "NSString+ZHMNSStringExt.h"
#import "TestModel.h"
#import "orderModer.h"

@interface BuyMyselfTableViewController ()

@property (nonatomic,strong)NSMutableArray *myOrderArr;
@property (nonatomic,strong)NSString *contentStr;
@property (nonatomic,strong)NSMutableArray *leyArr;
@property (nonatomic,assign)NSInteger index;


@end

@implementation BuyMyselfTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数组
    self.myOrderArr = [NSMutableArray array];
    self.leyArr = [NSMutableArray array];
    
    //设置背景
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    // tableview注册
    [self.tableView registerClass:[BuyMyselfTableViewCell class] forCellReuseIdentifier:@"BuyMyselfTableViewCell"];
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 请求数据
            [self getArtcollectWithState:@""Page:@"1"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
        
    }
    
   
    
    self.index = 2;
    [self p_setupRefresh];
    
}


#pragma mark - 上拉加载 下拉刷新
/////////////////////////////////////////////////////
-(void)p_setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    
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
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.leyArr = [NSMutableArray array];
            [self getArtcollectWithState:@""Page:@"1"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
            });
        });
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
        // 1.加载更多数据[self getArtcollectWithState:@""Page:@"1"]
        
       
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self getArtcollectWithState:@""Page:[NSString stringWithFormat:@"%ld",(long)self.index++]];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新表格
                [self.tableView reloadData];
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [self.tableView footerEndRefreshing];
            });
        });
        
        
    }
    
    
}

-(void)getArtcollectWithState:(NSString *)mystate Page:(NSString *)mypage
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/orderlist.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"status=%@&page=%@",mystate,mypage];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [[dict objectForKey:@"datas"]objectForKey:@"list"];
     self.myOrderArr = [NSMutableArray array];
    if ([[NSString stringWithFormat:@"%@",arr] isEqualToString:@"0"])
    {
        
    }
    else
    {
        for (NSDictionary * dict in arr)
        {
            orderModer * m = [[orderModer alloc] init];
            [m setValuesForKeysWithDictionary:dict];
            [self.myOrderArr addObject:m];
        }
    }

    if ([mypage isEqualToString:@"1"]) {
        // 首次请求数据
        if (self.myOrderArr.count > 0) {
            _leyArr = _myOrderArr;
        }
    }
    else
    {
        if (self.myOrderArr.count > 0)
        {
            
            for (int i = 0; i < _myOrderArr.count; i++)
            {
                [_leyArr addObject:_myOrderArr[i]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.leyArr.count == 0)
    {
        return 1;
    }
    else
    {
       return self.leyArr.count;
    }

    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuyMyselfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyMyselfTableViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f blue:222/255.0f alpha:0.5];
    if (self.leyArr.count == 0)
    {
        
    }
    else
    {
        orderModer *p = self.leyArr[indexPath.row];
        
        
        
        cell.lblState.text = @"状态:";
        cell.lblAdministrator.text = @"管理员备注:";
        TestModel *model = [[TestModel alloc] init];
        model.imgShows = [UIImage imageNamed:@"haibao2"];
        model.details = p.buyactivitietitle;
        self.contentStr = p.buyactivitietitle;
        NSMutableString *str1 = [NSMutableString stringWithFormat:@"http://leying.hivipplus.com"];
        NSString *str2 = p.buyactivitietitlepic;
        model.imgShows = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[str1 stringByAppendingString:str2]]]];
        if ([[NSString stringWithFormat:@"%@",p.orderstatus] isEqualToString:@"1"])
        {
            model.state = @"进行中";
        }
        if ([[NSString stringWithFormat:@"%@",p.orderstatus] isEqualToString:@"2"])
        {
            model.state = @"已完成";
        }
        
        
        model.admin = p.beizhu;
        //  cell.newSize = [NSString sizeWithText:model.details maxSize:CGSizeMake(KScreenW - 20, 10000) font:[UIFont systemFontOfSize:14]];
        cell.model = model;
        
        // Configure the cell...
    }

   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 260 + [self heightForString:self.contentStr];
}
-(CGFloat)heightForString:(NSString *)aString
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0] };
    
    
    // 把传进来的字符串放在一个矩形中
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.tableView.frame) - 20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
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
