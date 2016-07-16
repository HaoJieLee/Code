//
//  changNameViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "changNameViewController.h"
#import "getDataHand.h"
#import "AlertShow.h"

@interface changNameViewController ()

@end

@implementation changNameViewController
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
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame),50)];
    self.nameTextField.text= self.myNameStr;
    self.nameTextField .backgroundColor = [UIColor whiteColor];
    self.nameTextField.font = [UIFont systemFontOfSize:15];
    self.nameTextField .alpha = 0.4;
    //self.nameTextField.keyboardType = UIKeyboardTypeDefault;
    self.nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nameTextField];
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style: UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    
}
//修改昵称
-(void)rightAction
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if ([[getDataHand shareHandLineData]editUserMarket:self.nameTextField.text])
        {
            
            // 写入一个文件
            NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            NSString *filePath2 = [documentPath stringByAppendingString:@"/name.txt"];
            
            NSString *aviStr = self.nameTextField.text;
            //写入
            [aviStr writeToFile:filePath2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
            [AlertShow alertShowWithContent:@"修改成功" Seconds:1];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"请检查网络" message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            
        }
    }
    
    
}




- (void)didReceiveMemoryWarning
{
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
