//
//  MyCollectViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MineLeYingTableViewController.h"
#import "MineArtistCollectionViewController.h"

@interface MyCollectViewController ()<UIScrollViewDelegate,LGtitleBarViewDelegate>


@property(nonatomic,strong)UIScrollView *BackView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) LGtitleBarView *titleBar;



@property (nonatomic,strong)MineLeYingTableViewController *mineVC;
@property (nonatomic,strong)MineArtistCollectionViewController *mineArtVC;;


@end

@implementation MyCollectViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.view.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    self.titles = @[@"我的乐影", @"我的艺人"];
    
    
    
    
    self.titleBar.titles = _titles;
    self.titleBar.delegate = self;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    [self.view addSubview:_titleBar];
    
     self.BackView.delegate =self;
    [self interfaceHandle];

}



-(void)interfaceHandle
{
    self.BackView = [[UIScrollView alloc]init];
    self.BackView.frame = CGRectMake(0, 44, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    self.BackView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)*2, CGRectGetHeight([UIScreen mainScreen].bounds));
    self.BackView.backgroundColor = [UIColor colorWithRed:131/255.0f green:150/255.0f  blue:153/255.0f alpha:1.0];
   // self.BackView.delegate =self;
    [self.view addSubview:_BackView];
    self.BackView.pagingEnabled = YES;
    
    
  
    
    self.mineVC = [[MineLeYingTableViewController alloc]init];
    self.mineVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-155 + 64);
    [self addChildViewController:_mineVC];
    [self.BackView addSubview:_mineVC.tableView];
    
    
//
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 3 - 6, 145);
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.minimumLineSpacing = 3;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置整体四周边距  上、左、下、右
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 15, 5);
    MineArtistCollectionViewController *categoryVC = [[MineArtistCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    
    categoryVC.view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0, self.view.frame.size.width, CGRectGetHeight(self.view.frame) - 155 + 64);
    [self addChildViewController:categoryVC];
    [self.BackView addSubview:categoryVC.view];

    
    

    
    
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
