//
//  SingletonRequest.h
//  hlJXT
//
//  Created by Jier on 16/3/21.
//  Copyright © 2016年 Jier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonRequest : NSObject
//全局网络请求封装
+(SingletonRequest*)singleton;    
+(NSURLRequest*)requestwithURl:(NSString*)urlstr
                      withBody:(NSString*)body
             withRequestMethod:(NSString *)method;     //返回网络请求
+(NSURLSession*)session;                               //返回全局会话

+(id)returnedDataWithRequest:(NSURLRequest*)request;   //返回网络请求返回数据


////异步弹出隐藏警示框
//+(void)hideMBProgress;
//+(void)showSuccessMBProgressWithString:(NSString*)success;
//+(void)showErrorMBProgressWithString:(NSString*)error;
//
@end
