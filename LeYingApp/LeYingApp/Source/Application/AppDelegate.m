//
//  AppDelegate.m
//  Leyiing
//
//  Created by sks on 15/12/9.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "RootTarBarController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlertShow.h"
#import "KSGuideManager.h"
#import "LaunchDemo.h"
#import "AFNetworkReachabilityManager.h"
#import <RongIMKit/RongIMKit.h>
#import <IQKeyboardManager.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"


#define kRongYunAppKey  @"e0x9wycfxfvmq"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface AppDelegate ()<RCIMUserInfoDataSource>
@property (nonatomic,strong)NSString *publicToken;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 没有网
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:_window];
        
    }
    // 有网
    else
    {
        //微信
        [WXApi registerApp:@"wx4b972a10aa811d6a"];
        
        AFNetworkReachabilityManager * manger = [AFNetworkReachabilityManager sharedManager];
        [manger startMonitoring];
        
        
        self.window  = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        //    [NSThread sleepForTimeInterval:5.0];
        RootTarBarController *rootView = [[RootTarBarController alloc]init];
        self.window.rootViewController = rootView;
        
        //启动图
        //  UIImage *myImg = [self getPic];
        
       // NSString *myStrPic = [self getPic];
        
//        NSMutableString *mystr1 = [NSMutableString stringWithFormat:@"%@",myurl];
//        NSString *mystr2 = myStrPic;
//        NSString *mystr3 = [mystr1 stringByAppendingString:mystr2];
        
        [self showBackGround:@"qidong1.png"];
        
        //登录缓存
        [self loadCookies];//登录缓存
        
        [self setNav];
        
        //引导图
        NSMutableArray *paths = [NSMutableArray new];
        
        [paths addObject:[[NSBundle mainBundle] pathForResource:@"7" ofType:@"jpg"]];
        [paths addObject:[[NSBundle mainBundle] pathForResource:@"8" ofType:@"jpg"]];
        [paths addObject:[[NSBundle mainBundle] pathForResource:@"9" ofType:@"jpg"]];
        
        [[KSGuideManager shared] showGuideViewWithImages:paths];
        
        //融云
        // 改变信息的形状
        [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
        
        [[RCIM sharedRCIM] initWithAppKey:kRongYunAppKey];
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
        
        // [RCIMClient sharedRCIMClient].currentUserInfo这个方法是在每次app重启后都会成为nil，因此在每次app就行重启后都需要设置该项，在可以需要的地方进行打印
        NSLog(@"用户ID%@,用户名字%@,用户头像%@", [RCIMClient sharedRCIMClient].currentUserInfo.userId, [RCIMClient sharedRCIMClient].currentUserInfo.name, [RCIMClient sharedRCIMClient].currentUserInfo.portraitUri);
        
        // 添加消息接收的通知
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification1:) name:RCKitDispatchMessageNotification object:nil];
        
        
        //键盘管理
        
        IQKeyboardManager *manage = [IQKeyboardManager sharedManager];
        manage.enable = YES;
        manage.shouldResignOnTouchOutside = YES;
        manage.shouldToolbarUsesTextFieldTintColor = YES;
        manage.enableAutoToolbar = NO;
        
        
        
        
        
        //融云相关
//        self.publicToken = [self getToken];
        [self setJoin];
        
    }

    
#pragma mark --- 第三方登录
    
    [ShareSDK registerApp:@"14c21a4871e40"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 //一天 appkey已填 (等
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"942612135"
                                           appSecret:@"c2099286fc118d4b227d41be9f4ea3b5"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
                 //
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxa1446c468016eabb"
                                       appSecret:@"92233c357039087d5a0202f9f8c4520f"];
                 break;
                 //
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105512196"
                                      appKey:@"LuIJZBN0CNNZVJCS"
                                    authType:SSDKAuthTypeBoth];
                 break;
                default:
                 break;
         }
     }];
    
    return YES;
}

#pragma mark  私聊登录
- (void)setJoin
{
    
    [[RCIM sharedRCIM] connectWithToken:[self getToken] success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        
        
       // [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
}
#pragma mark 请求token
- (NSString *)getToken
{
    NSString *SHA1String = [Factory SHA1HexDigest:[NSString stringWithFormat:@"ly%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"password"]]];
    NSDictionary *loginDic = [[getDataHand shareHandLineData] getPhone:[[NSUserDefaults standardUserDefaults]valueForKey:@"phone"] getPassword:SHA1String];
    loginModel *login = [loginModel grobleLoginModel];
    [login setValuesForKeysWithDictionary:[loginDic objectForKey:@"data"]];
    
    NSString *string = [Factory randomlyString];
    NSString *timeString = [Factory TimeToDataString];
    NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
    
    NSDictionary *dic = [[getDataHand shareHandLineData]getRongCloudTokenWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string];
    return [[dic objectForKey:@"data"]objectForKey:@"rongCloudToken"];
}



#pragma mark 显示用户图像和昵称

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    
    // 没有网
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:_window];
        
    }
    // 有网
    else
    {
        
//        NSUserDefaults *mypublicId = [NSUserDefaults standardUserDefaults];
//        NSString *mypuId = [mypublicId objectForKey:@"selfMyId"];
//        
//        NSUserDefaults *myOtherID = [NSUserDefaults standardUserDefaults];
//        NSString *myOtID = [myOtherID  objectForKey:@"selfotherID"];
//        if ([userId isEqual:mypuId])
//        {
//            RCUserInfo *user = [[RCUserInfo alloc] init];
//            user.userId = mypuId;
//            user.name = @"我";
//            user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
//            return completion(user);
//        }
//        else
//        {
//            NSDictionary *myDic = [self getNameWithId:userId];
//            NSString *myYiming = [[[myDic objectForKey:@"datas"]objectForKey:@"info"]objectForKey:@"yiming"];
//            NSString *myPic = [[[myDic objectForKey:@"datas"]objectForKey:@"info"]objectForKey:@"avatar"];
//            NSString *myId = [[[myDic objectForKey:@"datas"]objectForKey:@"info"]objectForKey:@"memberid"];
//            
//            
//            
//            NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
//            NSString *str2 = myPic;
//            NSString *str3 = [str1 stringByAppendingString:str2];
//            
//            
//            RCUserInfo *user = [[RCUserInfo alloc] init];
//            user.userId = myId;
//            user.name = myYiming;
//            
//            user.portraitUri = str3;
//            NSLog(@"%@",user.portraitUri);
//            
//            
//            return completion(user);
//        }
//        return completion(nil);
  //***********************************************
//        //此处为了演示写了一个用户信息
//        if ([@"df301335018a4a9e9ad17134023d9754" isEqual:userId]) {
//            RCUserInfo *user = [[RCUserInfo alloc]init];
//            user.userId = @"df301335018a4a9e9ad17134023d9754";
//            
//            return completion(user);
//        }else if([@"9cbb69f24146bef78b5d871f76c20a5e" isEqual:userId]) {
//            RCUserInfo *user = [[RCUserInfo alloc]init];
//            user.userId = @"9cbb69f24146bef78b5d871f76c20a5e";
//            return completion(user);
//        }

    }
   
}

#pragma mark 获取用户聊天列表信息
-(NSDictionary *)getNameWithId:(NSString *)useID;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/yiren/getliaotianinfo.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",useID];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
  
    return dict;

}
#pragma mark 获取启动图信息
-(NSString *)getPic
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/index/site.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"field=%@",@"yingdaopic"];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString * myYindao = [[[dict objectForKey:@"datas"]objectForKey:@"site"]objectForKey:@"yingdaopic"];
    

    return myYindao;
}

- (void)didReceiveMessageNotification1:(NSNotification *)notification
{
    
    NSLog(@"消息累加了一条");
}







- (void)setNav

{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //设置显示的颜色
    
    bar.barTintColor = [UIColor whiteColor];
    
    //设置字体颜色
    
    bar.tintColor = [UIColor whiteColor];
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //或者用这个都行
    
    
    //    [bar setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
    
    
}



//启动图代码
-(void)showBackGround:(NSString *)imageOne
{
    LaunchDemo *demo = [LaunchDemo new];
    demo.iconFrame = CGRectMake((SCREEN_WIDTH - 213) * 0.5, 80, 213, 54);
    demo.desLabelFreme = CGRectMake(0, SCREEN_HEIGHT - 34, SCREEN_WIDTH, 25);
    [demo loadLaunchImage:nil
                 iconName:nil
              appearStyle:JRApperaStyleOne
                  bgImage:imageOne
                disappear:JRDisApperaStyleLeft
           descriptionStr:nil];
    demo.desLabel.font = [UIFont systemFontOfSize:12];
    demo.desLabel.textColor = [UIColor whiteColor];
}


- (void)loadCookies
{
    
    //判断是否存在
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *cookies;
    cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [defaults objectForKey: lsUserCookie]];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies)
    {
        [cookieStorage setCookie: cookie];
    }
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    //  支付宝
    /*
     9000 订单支付成功
     8000 正在处理中
     4000 订单支付失败
     6001 用户中途取消
     6002 网络连接出错
     */
    BOOL safePay = [url.host isEqualToString:@"safepay"];
    BOOL platFormApi = [url.host isEqualToString:@"platformapi"];
    if (safePay) {
        // 这个是进程KILL掉之后也会调用，这个只是第一次授权回调，同时也会返回支付信息
        
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *str = resultDic[@"resultStatus"];
            NSLog(@"resultStatus = %@",str);
            // 返回码获取
            NSString *fanhuima = [NSString stringWithFormat:@"%@",[resultDic[@"result"] objectForKey:@"resultStatus"]];
            switch ([fanhuima integerValue]) {
                case 4000:
                    // 订单支付失败
                    [AlertShow alertShowWithContent:@"支付订单失败" Seconds:2.0];
                    NSLog(@"订单支付失败");
                    break;
                case 6001:
                    // 用户中途取消
                    [AlertShow alertShowWithContent:@"用户中途取消" Seconds:2.0];
                    NSLog(@"...用户中途取消");
                    break;
                case 6002:
                    // 网络连接出错
                    [AlertShow alertShowWithContent:@"网络连接出错" Seconds:2.0];
                    NSLog(@"网络连接出错");
                    break;
                case 8000:
                    // 正在处理中
                    [AlertShow alertShowWithContent:@"正在处理中..." Seconds:2.0];
                    NSLog(@"正在处理中...");
                    break;
                case 9000:
                    // 订单支付成功
                    [AlertShow alertShowWithContent:@"订单支付成功" Seconds:2.0];
                    NSLog(@"订单支付成功");
                    break;
                default:
                    break;
            }
        }];
        // 跳转支付宝钱包进行支付，处理支付结果，这个只是辅佐订单支付结果回调
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             
             if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"])
             {
                 NSLog(@"支付成功");
             }
             
             //NSLog(@"result = %@",resultDic);//返回的支付结果
         }];
    }
    else if (platFormApi)
    {
        // 授权返回码
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
        }];
    }
    
    // 微信
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
