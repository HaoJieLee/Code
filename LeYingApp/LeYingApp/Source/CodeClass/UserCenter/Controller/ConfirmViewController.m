//
//  ConfirmViewController.m
//  乐影
//
//  Created by zhaoHm on 16/4/27.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ConfirmViewController.h"
#import "ConfirmView.h"
#import "MineCenterViewController.h"
#import "strangerTableViewController.h"

@interface ConfirmViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) ConfirmView *backV;

@end

@implementation ConfirmViewController

-(void)loadView
{
    _backV = [[ConfirmView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = _backV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局加载
    [self p_setupUI];
    
}

#pragma mark 布局设置
-(void) p_setupUI
{
    UITapGestureRecognizer *PeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne1)];
    self.backV.imgArtist.userInteractionEnabled = YES;
    [self.backV.imgArtist addGestureRecognizer:PeTap1];
    
    UITapGestureRecognizer *PeTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne2)];
    self.backV.imgMoviePart.userInteractionEnabled = YES;
    [self.backV.imgMoviePart addGestureRecognizer:PeTap2];
    
    UITapGestureRecognizer *PeTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne3)];
    self.backV.imgActive.userInteractionEnabled = YES;
    [self.backV.imgActive addGestureRecognizer:PeTap3];
    UITapGestureRecognizer *PeTap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne4)];
    self.backV.imgPasserBy.userInteractionEnabled = YES;
    [self.backV.imgPasserBy addGestureRecognizer:PeTap4];
    
    
}
//艺人
-(void)imageActionOne1
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"角色一经选择不可修改，请谨慎!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    view.tag = 1001;
    view.delegate = self;
    
    [view show];
}
//影视机构
-(void)imageActionOne2
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"角色一经选择不可修改，请谨慎!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    view.tag = 1002;
    view.delegate = self;
    view.backgroundColor = [UIColor clearColor];
    
    [view show];
}
//活动方
-(void)imageActionOne3
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"角色一经选择不可修改，请谨慎!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    view.tag = 1003;
    view.delegate = self;
    view.backgroundColor = [UIColor clearColor];
    
    [view show];
}
-(void)imageActionOne4
{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"角色一经选择不可修改，请谨慎!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    view.tag = 1004;
    view.delegate = self;
    view.backgroundColor = [UIColor clearColor];
    
    [view show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        
//        if (![[loginModel grobleLoginModel].identity isEqualToString:@""]) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你已选择过身份" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"", nil];
//            [alert show];
//        }
//        
       if (buttonIndex == 1)
        {
  
            if (alertView.tag == 1001)
            {
                MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
                mineVC.myindsx =1;
                
                [self saveIdentity:@"yiren"];
                mineVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mineVC animated:YES];
            }
            else if (alertView.tag == 1002)
            {
                MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
                mineVC.myindsx =2;
                [self saveIdentity:@"sheying"];
                mineVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mineVC animated:YES];
            }
            else if (alertView.tag == 1003)
            {
                MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
                mineVC.myindsx =3;
                [self saveIdentity:@"huodongfang"];
                mineVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:mineVC animated:YES];
            }
            else if (alertView.tag == 1004)
            {
                strangerTableViewController *strVC = [[strangerTableViewController alloc]init];
                [self saveIdentity:@"putong"];
                strVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:strVC animated:YES];
            }
            [self saveCookie];
            
        }

    }
    
    
    
}

-(void)saveCookie{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    //    NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesData];
    //
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject: cookiesData forKey: lsUserCookie];
    
    [defaults synchronize];
}

/**保存用户的身份信息*/
-(void)saveIdentity:(NSString *)Ident
{
    NSString *string = [Factory randomlyString];//随机字符串30个
    NSString *timeString = [Factory TimeToDataString];//当前时间戳
    NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];//加密字符串
    
    NSString *identity = [[getDataHand shareHandLineData]RefreshUsersIdentityDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Identity:Ident];
  
    NSLog(@"%@",identity);
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
