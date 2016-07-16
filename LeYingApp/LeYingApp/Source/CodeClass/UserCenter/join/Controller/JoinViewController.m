//
//  JoinViewController.m
//  Zhongchou
//
//  Created by 赵良育 on 15/12/10.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import "JoinViewController.h"
#import "RegisterViewController.h"
#import "forgetViewController.h"
#import "AlertShow.h"
#import <RongIMKit/RongIMKit.h>
#import "UsersTableViewController.h"
#import "ConfirmViewController.h"






@interface JoinViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)JoinView * joinView;
@property (nonatomic,strong)NSString *challenge;
@end

@implementation JoinViewController
-(void)loadView
{
    self.joinView = [[JoinView alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.view = _joinView;
}
-(void)viewWillAppear:(BOOL)animated
{
    //[self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    //[self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijing.jpg"]];
    
    imgView.frame = self.view.bounds;
    
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view insertSubview:imgView atIndex:0];
    
    
    [self.joinView.joinButton addTarget:self action:@selector(joinButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.joinView.forgetPassword addTarget:self action:@selector(forgetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.joinView.registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
    self.joinView.passWord.secureTextEntry = YES;
    
}

-(void)registAction:(UIButton *)sender
{
    RegisterViewController *registVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}


// 判断数字
- (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


#pragma mark 登录的点击事件
-(void)joinButtonAction:(UIButton *)sender
{

    NSString *SHA1String = [Factory SHA1HexDigest:[NSString stringWithFormat:@"ly%@",self.joinView.passWord.text]];
    
        if ((self.joinView.phoneNumber.text.length != 11)&&(![self isPureInt:_joinView.phoneNumber.text])) {
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
                NSDictionary *loginDic = [[getDataHand shareHandLineData] getPhone:self.joinView.phoneNumber.text getPassword:SHA1String];

                if ([[loginDic objectForKey:@"message"] isEqualToString:@"成功"])
                {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setValue:[[loginDic objectForKey:@"data"]objectForKey:@"token"]  forKey:@"token"];
                    [defaults setValue:[[loginDic objectForKey:@"data"]objectForKey:@"rongCloudToken"]  forKey:@"rongCloudToken"];
                    [defaults setValue:self.joinView.phoneNumber.text forKey:@"phone"];
                    [defaults setValue:self.joinView.passWord.text forKey:@"password"];
                    loginModel *login = [loginModel grobleLoginModel];
                    [login setValuesForKeysWithDictionary:[loginDic objectForKey:@"data"]];
                                        //网络判断
    
                // isbixu 1必须进入身份选择界面
                        ConfirmViewController *confirmVC = [[ConfirmViewController alloc] init];
                        confirmVC.hidesBottomBarWhenPushed = YES;
                        confirmVC.identyDic =[NSDictionary dictionaryWithDictionary: loginDic];
                        [self.navigationController pushViewController:confirmVC animated:YES];
                    }
                else
                {
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[loginDic objectForKey:@"message"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    alView.tag = 4444;
                    [alView show];
                }
                
            }
        }

    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 4444)
    {
        // 登录失败
    }
    else
    {
        if (buttonIndex == 0)
        {
            //1.1版本
           // UsersTableViewController *myTab = [[UsersTableViewController alloc]init];
            //[self.navigationController pushViewController:myTab animated:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    
}


#pragma mark 忘记密码的点击事件
-(void)forgetPasswordAction:(UIButton *)sender
{
    forgetViewController *forVC = [[forgetViewController alloc]init];
    [self.navigationController pushViewController:forVC animated:YES];
}





-(void)setData
{
    self.navigationItem.title = @"登录";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    
    
    if ([NSUserDefaults standardUserDefaults]) {
        self.joinView.phoneNumber.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
        self.joinView.passWord.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"password"];
    }
    self.joinView.phoneNumber.delegate = self;
    
    self.joinView.passWord.delegate = self;
    self.joinView.passWord.tag = 102;
    
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
