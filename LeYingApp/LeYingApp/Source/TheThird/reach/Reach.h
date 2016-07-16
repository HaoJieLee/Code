//
//  Reachability.h
//  UseAFNetworking
//
//  Created by 夜狼安防 on 16/4/29.
//  Copyright © 2016年 夜狼安防. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,LYReachability)
{
    UNKNOW_NET = -1,
    NO_NET              =  0,//无网
    G_NET                 =  1,//手机
    WIFI_NET                      =  2,//WiFi
};
@interface Reach : NSObject
+(void)reachability:(void(^)(LYReachability status))block;
@end
