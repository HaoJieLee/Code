//
//  ArtistSexViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/21.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtistSexViewController.h"

@interface ArtistSexViewController ()

@end

@implementation ArtistSexViewController
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
    // Do any additional setup after loading the view.
    
    // 背景
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    
    [self p_settingupView];
    
    // 显示
    if ([_strSex isEqualToString:@"男"]) {
        // 男
        self.imgMan.hidden = NO;
        self.imgWoman.hidden = YES;
    }
    else
    {
        // 女
        self.imgMan.hidden = YES;
        self.imgWoman.hidden = NO;
    }
    
    
    self.navigationItem.title = @"性别";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
}

/// 保存
-(void)rightBarButtonAction
{
    
    
    // 保存 反向传值
    NSString *sex = @"男";
    if (self.imgMan.hidden == YES) {
        sex = @"女";
    }
    else if (self.imgWoman.hidden == YES)
    {
        sex = @"男";
    }
    else
    {
        
    }
    [self.delegate passSex:sex];
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)p_settingupView
{
    self.manView = [[UIView alloc] initWithFrame:CGRectMake(0, 74, KScreenW, 40)];
    self.manView.backgroundColor = [UIColor colorWithRed:212 / 255.0 green:209 / 255.0 blue:194 / 255.0 alpha:0.6];
    self.manView.userInteractionEnabled = YES;
    // 添加点击事件------------
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo1:)];
    [self.manView addGestureRecognizer:tapGesture1];
    
    [self.view addSubview:_manView];
    
    self.lblManSex = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 40)];
    self.lblManSex.text = @"男";
    [self.manView addSubview:_lblManSex];
    
    self.imgMan = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.manView.frame) - 30, CGRectGetMinY(self.lblManSex.frame) + 10, 20, 20)];
    self.imgMan.image = [UIImage imageNamed:@"gou.png"];
    [self.manView addSubview:_imgMan];
    
    
    self.womanView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.manView.frame) + 4, CGRectGetWidth(self.manView.frame), CGRectGetHeight(self.manView.frame))];
    self.womanView.userInteractionEnabled = YES;
    // 添加点击事件--------------
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo2:)];
    [self.womanView addGestureRecognizer:tapGesture2];
    
    
    self.womanView.backgroundColor = [UIColor colorWithRed:212 / 255.0 green:209 / 255.0 blue:194 / 255.0 alpha:0.6];
    [self.view addSubview:_womanView];
    
    self.lblWomanSex = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblManSex.frame), 5, CGRectGetWidth(self.lblManSex.frame), CGRectGetHeight(self.lblManSex.frame))];
    self.lblWomanSex.text = @"女";
    [self.womanView addSubview:_lblWomanSex];
    
    self.imgWoman = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imgMan.frame), CGRectGetMinY(self.lblWomanSex.frame) + 10, CGRectGetWidth(self.imgMan.frame), CGRectGetHeight(self.imgMan.frame))];
    self.imgWoman.image = [UIImage imageNamed:@"gou.png"];
    //self.imgWoman.hidden = YES;
    [self.womanView addSubview:_imgWoman];
}


-(void)Actiondo1:(id)sender
{
    self.imgMan.hidden = NO;
    self.imgWoman.hidden = YES;
}

-(void)Actiondo2:(id)sender
{
    self.imgWoman.hidden = NO;
    self.imgMan.hidden = YES;
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
