//
//  IsHaveNetwork.m
//  SeeWorld
//
//  Created by LZZ on 15/10/26.
//  Copyright (c) 2015年 LZZ. All rights reserved.
//

#import "IsHaveNetwork.h"
#import <AFNetworking.h>
static IsHaveNetwork *isNetwork = nil;

@implementation IsHaveNetwork

+(instancetype)shareIsHaveNetwork
{
    if (isNetwork == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            isNetwork = [[IsHaveNetwork alloc] init];
        });
    }
    return isNetwork;
}

#pragma mark - 网络判断
/////////////////////////////////////////////////////

// 网络判断
-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            // 没有网
            NSLog(@"notReachable没有网");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            // wifi
            NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            // 3G
            NSLog(@"3G");
            break;
    }
    
//    if (!isExistenceNetwork) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
//        hud.removeFromSuperViewOnHide =YES;
//        //  hud.mode = MBProgressHUDModeText;
//        hud.labelText = @"当前网络不可用，请检查网络连接";  //提示的内容
//        hud.minSize = CGSizeMake(132.f, 108.0f);
//        CGFloat hudW = 315;
//        CGFloat hudH = 180;
//        hud.frame = CGRectMake((KScreenW - hudW) / 2, (KScreenH - hudH) / 2 - 50, hudW, hudH);
//        NSLog(@"%f",KScreenW);
//        NSLog(@"%f",(KScreenW - CGRectGetWidth(hud.frame)) / 2);
//        NSLog(@"%f",CGRectGetMinX(hud.frame));
//        [hud hide:YES afterDelay:2];
//        return NO;
//    }
    
    return isExistenceNetwork;
}


-(void)alertViewForNetworkWithBase:(UIView *)baseView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
    hud.removeFromSuperViewOnHide =YES;
    //  hud.mode = MBProgressHUDModeText;
    hud.labelText = @"当前网络不可用，请检查网络连接";  //提示的内容
    hud.minSize = CGSizeMake(132.f, 108.0f);
    CGFloat hudW = 325;
    CGFloat hudH = 180;
    hud.frame = CGRectMake((KScreenW - hudW) / 2, (KScreenH - hudH) / 2 - 50, hudW, hudH);
    NSLog(@"%f",KScreenW);
    NSLog(@"%f",(KScreenW - CGRectGetWidth(hud.frame)) / 2);
    NSLog(@"%f",CGRectGetMinX(hud.frame));
    [hud hide:YES afterDelay:2];
}


/////////////////////////////////////////////////////

+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock{
    
    //1.拼接URL
    NSString *requestString = [@"" stringByAppendingString:urlString];
    requestString = [requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //发送异步网络请求
    //    AppDelegate *delegate = APPDELEGATE;
    //    MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:securityPolicy];
    //GET和POST分别处理
    if ([method isEqualToString:@"GET"]) {
        [manager GET:requestString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功%@",responseObject);
            
            completionblock(responseObject);
            
            //            [_hud hide:YES afterDelay:0.5];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            _hud.labelText = @"请检查网络链接";
            //            [_hud hide:YES afterDelay:0.5];
            errorblock(error);
            NSLog(@"失败%@",error);
        }];
        
    }
    else if([method isEqualToString:@"POST"]) {
        
        [manager POST:requestString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功%@",responseObject);
            
            completionblock(responseObject);
            
            //            [_hud hide:YES afterDelay:0.5];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //            _hud.labelText = @"请检查网络链接";
            //            [_hud hide:YES afterDelay:0.5];
            errorblock(error);
            NSLog(@"失败%@",error);
        }];
        
        
    }
    
}


@end
