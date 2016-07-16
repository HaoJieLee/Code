//
//  FinishTableViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "FinishTableViewController.h"
#import "FinishTableViewCell.h"
#import "getProjectData.h"
#import "completeModel.h"
#import "VideoViewController.h"
#import "GroupPhotoViewController.h"
#import "VideoWebViewController.h"

#import "UNfinishDetailViewController.h"

@interface FinishTableViewController ()
@property (nonatomic,strong)NSMutableArray *myArr;//活动数组
@property (nonatomic)int pageNo;//加载页
@property (nonatomic)int pageSize;//每页多少条

@end

@implementation FinishTableViewController

- (void)getPagenoAndPageSize{
    self.pageNo = 1;
    self.pageSize = 10;
    self.myArr = [NSMutableArray array];
}
- (void)getDataSource{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 子线程中加载数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 请求数据
            [self.myArr addObjectsFromArray: [[getProjectData shareProjectData] getCompleteWithPageNo:self.pageNo AddPageSize:self.pageSize Type:@"finished" ]];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
            });
        });
        
    }
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    [self.tableView registerClass:[FinishTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    [self getPagenoAndPageSize];
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

// 开始进入刷新状态
- (void)headerRereshing
{
    self.pageNo = 1;
    [self.myArr removeAllObjects];
    [self getDataSource];
    
}

#pragma mark 开始进入加载状态
- (void)footerRereshing
{
    self.pageNo++;
    [self getDataSource];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.myArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   FinishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    completeModel *c = self.myArr[indexPath.row];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        
        completeModel *p = self.myArr[indexPath.row];
        UNfinishDetailViewController *unVC = [[UNfinishDetailViewController alloc]init];
        unVC.index = p.Id;
        unVC.type = 1;
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
