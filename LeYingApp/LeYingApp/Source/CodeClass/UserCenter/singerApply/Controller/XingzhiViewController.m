//
//  XingzhiViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/5/4.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "XingzhiViewController.h"

@interface XingzhiViewController ()

@end

@implementation XingzhiViewController

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
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    
    self.txtFieldName = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, KScreenW, 40)];
    self.txtFieldName.placeholder = @"请输入性质";
    self.txtFieldName.backgroundColor = [UIColor colorWithRed:212 / 255.0 green:209 / 255.0 blue:194 / 255.0 alpha:0.6];
    [self.view addSubview:_txtFieldName];
    
    
    
    self.navigationItem.title = @"性质";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
    self.txtFieldName.text = _strXingzhi;
}

/// 保存
-(void)rightBarButtonAction
{
    
    if ([self.txtFieldName.text isEqualToString:@""])
    {
        [AlertShow alertShowWithContent:@"性质不能为空" Seconds:3];
    }
    else
    {
        // 保存 反向传值
        self.mBlock(self.txtFieldName.text);
        // 返回
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
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
