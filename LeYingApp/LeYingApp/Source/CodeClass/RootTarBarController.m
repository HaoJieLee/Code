//
//  RootTarBarController.m
//  LeYingApp
//
//  Created by sks on 15/12/10.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "RootTarBarController.h"
#import "MainController.h"
#import "UsersTableViewController.h"
#import "ArtistTableViewController.h"
#import "JoinViewController.h"
#import "getDataHand.h"
#import "MeViewController.h"

@interface RootTarBarController ()

@end

@implementation RootTarBarController

- (void)viewDidLoad
{
    self.tabBar.tintColor=[UIColor whiteColor];
    [super viewDidLoad];
   

#pragma 小镇直购
    MainController *mainController = [[MainController alloc]init];
    UINavigationController *mainVC = [[UINavigationController alloc]initWithRootViewController:mainController];
    //读取图片信息
    UIImage *MainNormalImage = [UIImage imageNamed:@"bot1.png"];
    UIImage * MainSelectImage = [UIImage imageNamed:@"both1.png"];
    //渲染
    mainVC.tabBarItem.image = [MainNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainVC.tabBarItem.selectedImage = [MainSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainVC.tabBarItem.title = @"小镇直购";

    
    
    
    
    //设置tabbar字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor colorWithRed:72/255.0f green:232/255.0f blue:223/255.0f alpha:1];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    //设置tabbar的背景图片
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, CGRectGetWidth(self.view.frame), 49)];
    backView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"sydibu.jpg"] ];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    
    
    
    
#pragma 我的
    MeViewController *userController = [[MeViewController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *userVC = [[UINavigationController alloc]initWithRootViewController:userController];
    
    [userController.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:252/255.0 green:82/255.0 blue:117/255.0 alpha:1.0]];
    //我的粉色
    
    //读取图片信息
    UIImage * normalImage = [UIImage imageNamed:@"bot3.png"];
    UIImage * selectImage = [UIImage imageNamed:@"both3.png"];
    //渲染
    userVC.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    userVC.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userVC.tabBarItem.title = @"我的";
    
   

#pragma 艺人社区
    ArtistTableViewController *artistController = [[ArtistTableViewController alloc]init];
    UINavigationController *artistVC = [[UINavigationController alloc]initWithRootViewController:artistController];
    
    //读取图片信息
    UIImage * ArtistNormalImage = [UIImage imageNamed:@"bot2.png"];
    UIImage * ArtistSelectImage = [UIImage imageNamed:@"both2.png"];
    //渲染
    artistVC.tabBarItem.image = [ArtistNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    artistVC.tabBarItem.selectedImage = [ArtistSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    artistVC.tabBarItem.title = @"艺人社区";

    self.viewControllers = @[artistVC,mainVC,userVC];
    
    
    
    
}

//控制屏幕旋转

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation

{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)shouldAutorotate

{
    
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
    
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
