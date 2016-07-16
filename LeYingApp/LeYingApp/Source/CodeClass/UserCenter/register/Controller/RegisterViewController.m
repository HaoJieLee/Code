//
//  RegisterViewController.m
//  Zhongchou
//
//  Created by 赵良育 on 15/12/10.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import "RegisterViewController.h"
#import "getDataHand.h"
#import "AlertShow.h"
#import "resingnAboutViewController.h"
#import "ConfirmViewController.h"
#import "JoinViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)RegisterView * rv;
@end

@implementation RegisterViewController
-(void)loadView
{
    self.rv = [[RegisterView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = _rv;
}
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
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijing.jpg"]];
    
    
    imgView.frame = self.view.bounds;
    
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view insertSubview:imgView atIndex:0];
    
    [self setData];
    
    [self.rv.getNumberButton addTarget:self action:@selector(getNumberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rv.registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.rv.userProtoclBtn addTarget:self action:@selector(userProtoclAction:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

#pragma mark 用户注册协议点击事件
-(void)userProtoclAction:(UIButton *)sender
{
    
    resingnAboutViewController *reg = [[resingnAboutViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
    
    
}

#pragma mark 获取验证码的点击事件
-(void)getNumberButtonAction:(UIButton *)sender
{
           if ((self.rv.phoneNumber.text.length != 11)&&(![self isPureInt:_rv.phoneNumber.text])) {
            [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
        }
        else
        {
            
            if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
            {
                [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
            }
            else
            {
                 [[getDataHand shareHandLineData]getPhoneNumber:self.rv.phoneNumber.text Type:1];
            }
           
           
        }  

}

#pragma mark 注册按钮的点击事件
-(void)registerButtonAction:(UIButton *)sender
{
    NSString *md5String = [Factory SHA1HexDigest: [NSString stringWithFormat:@"ly%@",self.rv.password.text]];
    if ([self.rv.password.text isEqualToString:self.rv.twoPassword.text])
    {
        
    if ((![self isPureInt:_rv.phoneNumber.text])&&(self.rv.phoneNumber.text.length != 11)) {
                [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
            }
            else
            {
                if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
                {
                    [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
                }
                else
                {
                    if ([[getDataHand shareHandLineData]getPhoneNumber:self.rv.phoneNumber.text getSMS:self.rv.number.text getPassWord:md5String])
                    {
                        // 注册成功
                        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alView show];
                        
                    }
                    else
                    {
                        //注册失败
                        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        alView.delegate = self;
                        [alView show];
                        
                    }
                    
                }
            }
        }
    else
    {
        
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"两次密码不一致，请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        
        [view show];

    }
    
    
   
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        JoinViewController *joinVc = [[JoinViewController alloc]init];
        [self.navigationController pushViewController:joinVc animated:YES];
   
    }
}



// 判断数字
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}





// 基本数据的设置
-(void)setData
{

    
    self.navigationItem.title = @"注册";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    
    self.rv.twoPassword.tag = 101;
    
    self.rv.password.delegate = self;
    
    self.rv.twoPassword.delegate = self;
}

// textField的代理事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
//
//// 编辑完成之后的动作
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.frame = CGRectMake(0 , 0, self.view.frame.size.width, self.view.frame.size.height);
//    }];
//}
// 点击键盘return,键盘消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
