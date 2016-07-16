//
//  ChangePassWordViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "getDataHand.h"
#import "JoinViewController.h"
@interface ChangePassWordViewController ()<UIAlertViewDelegate>

@end

#define sWidth self.view.frame.size.width
#define sHeight self.view.frame.size.height
@implementation ChangePassWordViewController
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
    
    [self p_setupView];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style: UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    
}
//修改密码点击事件
-(void)rightAction
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if (![self isPureInt:self.phoneNumber.text])
        {
            [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
        }
        else
        {
            if (self.phoneNumber.text.length != 11) {
                [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
            }
            else
            {
                if (  [[getDataHand shareHandLineData] editUserPasswordWithPhone:self.phoneNumber.text Code:self.number.text password:self.password.text])
                {
                    [self removeCookie];
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    alView.delegate = self;
                    [alView show];
                }
                
                else
                {
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alView show];
                }
            }

        
        
        }
        
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        [self outLogin];
        [self removeCookie];
        JoinViewController *joVC = [[JoinViewController alloc]init];
        [self.navigationController pushViewController:joVC animated:YES];
        
    }
}
-(void)removeCookie
{
    //移除登录
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:lsUserCookie];
}
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(void)outLogin
{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/outlogin.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //    // 准备参数
    //    NSString *argument = [NSString stringWithFormat:@"id=%@",artistId];
    //    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //    //设置URl参数
    //    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    
    //self.myIntro = [[dict objectForKey:@"datas"] objectForKey:@"info"];
    
    
}
-(void)p_setupView
{
    
    // 电话号码textField初始化
    self.phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(sWidth / 4, 64, sWidth * 3 / 4,sWidth /9)];
    self.phoneNumber.text = self.myPhone;
    self.phoneNumber.userInteractionEnabled = NO;
    
    self.phoneNumber.backgroundColor = [UIColor whiteColor];
    self.phoneNumber.alpha = 0.4;
    
    [self mytextField:self.phoneNumber myLabelText:@"手机号" myTextFieldColor:[UIColor whiteColor]];
    
    // 验证码textField初始化
    self.number = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.phoneNumber.frame), CGRectGetMaxY(self.phoneNumber.frame)+0.3, CGRectGetWidth(self.phoneNumber.frame), CGRectGetHeight(self.phoneNumber.frame))];
    
    self.number.keyboardType = UIKeyboardTypeNumberPad;
    self.number.backgroundColor = [UIColor whiteColor];
    self.number.alpha = 0.4;
    [self mytextField:self.number myLabelText:@"验证码" myTextFieldColor:[UIColor whiteColor]];
    
    self.pImage = [[UIImageView alloc]initWithFrame:CGRectMake(sWidth*3/4  + 20, self.number.frame.size.height/8 + CGRectGetMinY(self.phoneNumber.frame) + 5, (sWidth/4 - 10)/5*2 -10, self.number.frame.size.height * 3/4 - 10)];
    self.pImage.image = [UIImage imageNamed:@"fasong.png"];
    
    [self.view addSubview:_pImage];
    
    // 获取验证码button初始化
    self.getNumberButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.getNumberButton.frame = CGRectMake(sWidth*3/4 + 40, self.number.frame.size.height/8 + CGRectGetMinY(self.phoneNumber.frame) , (sWidth/4 - 5)/2, self.number.frame.size.height * 3/4);
    
    self.getNumberButton.backgroundColor = [UIColor clearColor];
    self.getNumberButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.getNumberButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.getNumberButton setTitleColor:[UIColor colorWithRed:104/255.0f green:108/255.0f  blue:108/255.0f  alpha:1.0] forState:UIControlStateNormal];
    [self.getNumberButton addTarget:self action:@selector(getNUmBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.getNumberButton setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:_getNumberButton];
    
    // 密码textField初始化
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.number.frame), CGRectGetMaxY(self.number.frame)+0.3, CGRectGetWidth(self.number.frame), CGRectGetHeight(self.number.frame))];
    
    self.password.returnKeyType = UIReturnKeyDefault;
    self.password.backgroundColor = [UIColor whiteColor];
    self.password.font = [UIFont systemFontOfSize:15];
    self.password.alpha = 0.4;
    [self mytextField:self.password myLabelText:@"新密码" myTextFieldColor:[UIColor whiteColor]];
    
    self.password.secureTextEntry = YES;
    
    
    
    
}

//发送验证码
-(void)getNUmBtn:(UIButton *)sender
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if (![self isPureInt:self.phoneNumber.text])
        {
            [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
        }
        else
        {
            if (self.phoneNumber.text.length != 11) {
                [AlertShow alertShowWithContent:@"请输入正确的手机号" Seconds:2];
            }
            else
            {
                [[getDataHand shareHandLineData] editGetNumber:self.phoneNumber.text];
            }
        }
        
    }
    
}

// 封装的 textField 和 label结合的私有方法
-(void)mytextField:(UITextField *)textField myLabelText:(NSString *)labelText myTextFieldColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(textField.frame), sWidth/4, textField.frame.size.height)];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.alpha = 0.6;
    label.text = labelText;
    
    textField.backgroundColor = color;
    
    label.backgroundColor = color;
    
    [self.view addSubview:textField];
    
    [self.view addSubview:label];
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
