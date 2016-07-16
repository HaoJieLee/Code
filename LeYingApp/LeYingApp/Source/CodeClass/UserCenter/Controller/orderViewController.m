//
//  orderViewController.m
//  LeYingApp
//
//  Created by sks on 15/12/30.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "orderViewController.h"
#import "MySupportTableController.h"
#import "MySbmitTableViewController.h"
#import "MyPayTableViewController.h"
#import "MySendTableViewController.h"
#import "BuyMyselfTableViewController.h"
#import "Buy2MyselfTableViewController.h"
#import "Buy3TableViewController.h"

@interface orderViewController ()<UIScrollViewDelegate,LGtitleBarViewDelegate>


@property(nonatomic,strong)UIScrollView *BackView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) LGtitleBarView *titleBar;
@property (nonatomic,strong)NSArray *backArr;
@property (nonatomic,strong)NSArray *collectArr;
@property (nonatomic,strong)BuyMyselfTableViewController *buyVC;
@property (nonatomic,strong)Buy2MyselfTableViewController *buyVC2;
@property (nonatomic,strong)Buy3TableViewController *buyVC3;


@end

@implementation orderViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backArr = [NSArray array];
    self.collectArr = [NSArray array];
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    //self.titleBar.backgroundColor = [UIColor blackColor];
    self.titles = @[@"全部", @"进行中",@"已完成"];
    
    self.titleBar.titles = _titles;
    self.titleBar.delegate = self;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    [self.view addSubview:_titleBar];
    [self interfaceHandle];
}


-(void)interfaceHandle
{
    self.BackView = [[UIScrollView alloc]init];
    self.BackView.frame = CGRectMake(0, 44, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.BackView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)*3, CGRectGetHeight([UIScreen mainScreen].bounds));
    self.BackView.backgroundColor = [UIColor blueColor];
    self.BackView.delegate = self;
    [self.view addSubview:_BackView];
    self.BackView.pagingEnabled = YES;
    
    
    self.buyVC = [[BuyMyselfTableViewController alloc]init];
    self.buyVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-155 + 64);
    [self addChildViewController:_buyVC];
    [self.BackView addSubview:_buyVC.tableView];
    
    self.buyVC2 = [[Buy2MyselfTableViewController alloc]init];
    self.buyVC2.view.frame = CGRectMake(CGRectGetMaxX(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height-155 + 64);
    [self addChildViewController:_buyVC2];
    [self.BackView addSubview:_buyVC2.tableView];
//
//    
    self.buyVC3 = [[Buy3TableViewController alloc]init];
    self.buyVC3.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, self.view.frame.size.width, self.view.frame.size.height-155 + 64);
    [self addChildViewController:_buyVC3];
    [self.BackView addSubview:_buyVC3.tableView];
    
    
}

-(void)LGtitleBarView:(LGtitleBarView *)titleBarView didSelectedItem:(int)index
{
  
    CGFloat x = index * self.BackView.bounds.size.width;
    [self.BackView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}





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
