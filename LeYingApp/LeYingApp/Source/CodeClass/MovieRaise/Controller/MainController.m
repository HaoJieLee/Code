//
//  MainController.m
//  Leyiing
//
//  Created by sks on 15/12/9.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "MainController.h"
#import "UnfinishedTableViewController.h"
#import "FinishTableViewController.h"
#import "projectList.h"
#import "payBackModel.h"
#import "KSGuideManager.h"

@interface MainController ()<UIScrollViewDelegate,LGtitleBarViewDelegate>


@property(nonatomic,strong)UIScrollView *BackView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) LGtitleBarView *titleBar;


@property (nonatomic,strong)UnfinishedTableViewController *unfinishVC;
@property (nonatomic,strong)FinishTableViewController *finVC;

@property (nonatomic,strong)NSArray *backArr;
@property (nonatomic,strong)NSArray *collectArr;
@end

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //设置标题
    self.navigationItem.title = @"小镇直购";
    //设置背景颜色
    NSString *navBackgroundBarImage = [[NSBundle mainBundle] pathForResource:@"sytopd"ofType:@"png"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:navBackgroundBarImage] forBarMetrics:UIBarMetricsDefault];

    
    
   
    
    self.backArr = [NSArray array];
    self.collectArr = [NSArray array];
    
  
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 39)];
   
    self.titles = @[@"进行中", @"已完成"];
    
    self.titleBar.titles = _titles;
    self.titleBar.delegate = self;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    [self.view addSubview:_titleBar];
    
    
     [self interfaceHandle];


}

#pragma mark 添加切换
-(void)interfaceHandle
{
    self.BackView = [[UIScrollView alloc]init];
    self.BackView.frame = CGRectMake(0, 39, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.BackView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)*2, CGRectGetHeight([UIScreen mainScreen].bounds));
    self.BackView.backgroundColor = [UIColor colorWithRed:131/255.0f green:150/255.0f  blue:153/255.0f alpha:1.0];
    self.BackView.delegate =self;
    [self.view addSubview:_BackView];
    self.BackView.pagingEnabled = YES;
    
    
    self.finVC = [[FinishTableViewController alloc]init];
    self.finVC.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height-155);
    [self addChildViewController:_finVC];
    [self.BackView addSubview:_finVC.tableView];
    
    self.unfinishVC = [[UnfinishedTableViewController alloc]init];
    self.unfinishVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-155);
    [self addChildViewController:_unfinishVC];
    [self.BackView addSubview:_unfinishVC.tableView];
    
//    self.recommendedVC = [[RecommendedViewController alloc]init];
//    self.recommendedVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-155);
//    [self addChildViewController:_recommendedVC];
//    [self.BackView addSubview:self.recommendedVC.view];
    
    
    
    
}
#pragma mark 切换的代理事件
-(void)LGtitleBarView:(LGtitleBarView *)titleBarView didSelectedItem:(int)index
{
    CGFloat x = index * self.BackView.bounds.size.width;
    [self.BackView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}




#pragma mark 滑动减速时候的代理事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger integer = self.BackView.contentOffset.x/CGRectGetWidth(self.view.frame);
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:integer inSection:0];
    
    LGcollectionCell * cell =(LGcollectionCell *) [self.titleBar.collection cellForItemAtIndexPath:indexPath];
    
    [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition: UICollectionViewScrollPositionCenteredHorizontally];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleBar.bottomView.frame = CGRectMake(cell.frame.origin.x, cell.frame.size.height-2, cell.frame.size.width - 4, 2);
        
        
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
