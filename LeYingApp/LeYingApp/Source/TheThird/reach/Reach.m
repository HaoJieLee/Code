//
//  Reachability.m
//  UseAFNetworking
//
//  Created by 夜狼安防 on 16/4/29.
//  Copyright © 2016年 夜狼安防. All rights reserved.
//

#import "Reach.h"
#import "AFNetworkReachabilityManager.h"
@implementation Reach
+(void)reachability:(void(^)(LYReachability status))block
{
    AFNetworkReachabilityManager * manger = [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                block(UNKNOW_NET);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                block(NO_NET);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                block(G_NET);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                block(WIFI_NET);
                break;
            default:
                break;
        }
    }];
}

@end
