//
//  forgetViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/4/6.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "forgetViewController.h"
#import "forgetView.h"
#import "AlertShow.h"
@interface forgetViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)forgetView *rv;


@end

@implementation forgetViewController

-(void)loadView
{
    self.rv = [[forgetView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
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
    
    [self.rv.getNumberButton1 addTarget:self action:@selector(getNumberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rv.registerButton1 addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}


#pragma mark 获取验证码的点击事件
-(void)getNumberButtonAction:(UIButton *)sender
{
            if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
        {
            [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
        }
        else
        {
            if ((![self isPureInt:_rv.phoneNumber1.text])&&(self.rv.phoneNumber1.text.length != 11)) {
                [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
            }
            else
            {
                [[getDataHand shareHandLineData]getPhoneNumber:self.rv.phoneNumber1.text Type:2];
            }
        }
    
   
    
}

#pragma mark 点击事件
-(void)registerButtonAction:(UIButton *)sender
{
    NSString *sha1String = [Factory SHA1HexDigest:[NSString stringWithFormat:@"ly%@",self.rv.password1.text]];
    
    if ([self.rv.password1.text isEqualToString:self.rv.twoPassword1.text])
    {
        
        if (![self isPureInt:_rv.phoneNumber1.text]) {
            [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
        }
        else
        {
            if (self.rv.phoneNumber1.text.length != 11) {
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
                    
                    if ([[getDataHand shareHandLineData]editPhoneNumber:self.rv.phoneNumber1.text getSMS:self.rv.number1.text getPassWord:sha1String])
                    {
                        // 修改成功
                        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [alView show];
                        
                    }
                    else
                    {
                        //修改失败
                        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        alView.delegate = self;
                        [alView show];
                        
                    }
                    
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

// 判断数字
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}






// 基本数据的设置
-(void)setData
{
    
    
    self.navigationItem.title = @"修改密码";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    
    self.rv.twoPassword1.tag = 101;
    
    self.rv.password1.delegate = self;
    
    self.rv.twoPassword1.delegate = self;
}

//// textField的代理事件
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField.tag == 101) {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.view.frame = CGRectMake(0 , -64, self.view.frame.size.width, self.view.frame.size.height);
//        }];
//    }
//}
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
