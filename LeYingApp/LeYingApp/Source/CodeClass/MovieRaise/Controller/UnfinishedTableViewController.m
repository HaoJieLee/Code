//
//  UnfinishedTableViewController.m
//  LeYingApp
//
//  Created by sks on 15/12/10.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "UnfinishedTableViewController.h"

#import "projectList.h"
#import "UNfinishDetailViewController.h"
#import "completeModel.h"

#import "FinishTableViewCell.h"

@interface UnfinishedTableViewController ()

@property (nonatomic,strong)NSMutableArray *arrAy1;//进行中的活动的数组

@property (nonatomic)int pageNo;//加载页
@property (nonatomic)int pageSize;//每页多少条

@end

@implementation UnfinishedTableViewController
//初始化基本数据
- (void)getUnfinishedInfo{
    self.pageNo   = 1;
    self.pageSize = 10;
    self.arrAy1 = [NSMutableArray array];
    
}
- (void)getUnfinishDataSource{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [DictToData showMBHUBWithContent:@"玩命加载中..." ToView:self.view];
        // 子线程中加载数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 请求数据
            [self.arrAy1 addObjectsFromArray: [[getProjectData shareProjectData] getCompleteWithPageNo:self.pageNo AddPageSize:self.pageSize Type:@"going"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
            });
        });
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getUnfinishedInfo];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;

    
     self.view.backgroundColor = [UIColor colorWithRed:131/255.0f green:150/255.0f  blue:153/255.0f alpha:1.0];
    
    [self.tableView registerClass:[FinishTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.pageNo = 1;
    [self.arrAy1 removeAllObjects];
    [self getUnfinishDataSource];
    
}

#pragma mark 开始进入加载状态
- (void)footerRereshing
{
    self.pageNo++;
    [self getUnfinishDataSource];
    
}
/////////////////////////////////////////////////////


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

#pragma mark 返回cell组数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.arrAy1.count;
    
}

#pragma mark
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FinishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    completeModel *c = self.arrAy1[indexPath.row];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [cell.showImage2 sd_setImageWithURL:[NSURL URLWithString:c.coverImgUrl]];
//        cell.playImage.image = [UIImage imageNamed:@"bofang.png"];
        cell.titLab.text = c.title;
        cell.seeImage.image = [UIImage imageNamed:@"liulan3.png"];
        cell.seeShowLab.text =c.viewTime;
        cell.endTimeLab.text = @"日期:";
        cell.endTimeShowLab.text = [Factory stringWithDataString:c.publishDate];
        cell.introLab.text = c.summary;
    }
    return cell;
}

#pragma mark 获取当前时间戳

- (NSString *)getCurrentDateString
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval delta = [zone secondsFromGMTForDate:[NSDate date]];
    NSString *string = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] + delta];
    NSString *dateString = [[string componentsSeparatedByString:@"."]objectAtIndex:0];
    return dateString;
}
#pragma mark 返回tableview 的cell 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
#pragma mark cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        
        completeModel *p = self.arrAy1[indexPath.row];
        UNfinishDetailViewController *unVC = [[UNfinishDetailViewController alloc]init];
        unVC.index = p.Id;
        unVC.type = 0;
        unVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:unVC animated:YES];
    }
    
    
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
