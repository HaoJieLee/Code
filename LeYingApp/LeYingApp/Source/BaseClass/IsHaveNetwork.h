//
//  IsHaveNetwork.h
//  SeeWorld
//
//  Created by LZZ on 15/10/26.
//  Copyright (c) 2015年 LZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IsHaveNetwork : NSObject

+(instancetype) shareIsHaveNetwork;


-(BOOL) isConnectionAvailable;

-(void) alertViewForNetworkWithBase:(UIView *)baseView;

+ (void)requestData:(NSString *)urlString HTTPMethod:(NSString *)method params:(NSMutableDictionary *)params completionHandle:(void (^)(id))completionblock errorHandle:(void (^)(NSError *))errorblock;

@end
