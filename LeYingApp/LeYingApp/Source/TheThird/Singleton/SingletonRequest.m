//
//  SingletonRequest.m
//  hlJXT
//
//  Created by Jier on 16/3/21.
//  Copyright © 2016年 Jier. All rights reserved.
//

#import "SingletonRequest.h"
@implementation SingletonRequest
+(SingletonRequest*)singleton{
    static SingletonRequest *only;
    if (only==nil) {
        only=[[SingletonRequest alloc]init];
    }
    return only;
}


+(NSURLRequest*)requestwithURl:(NSString*)urlstr
                      withBody:(NSString*)body
             withRequestMethod:(NSString *)method
{
    NSURL *url=[NSURL URLWithString:urlstr];
    NSMutableURLRequest *mutablerequest=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [mutablerequest setHTTPMethod:method];
    [mutablerequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request=[mutablerequest copy];
    return request;
}

+(NSURLSession*)session
{
    NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest=10.0f;
    configuration.allowsCellularAccess=YES;
    NSURLSession *urlsession=[NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    return urlsession;
}



+(id)returnedDataWithRequest:(NSURLRequest*)request    //简单的请求封装 返回数据为字典类 如果数据为空 返回空
{
    __block id returnedData;
     dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *Task=[[self session] dataTaskWithRequest:request completionHandler:(id)^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            //如果返回数据为空的话
            returnedData = NULL;
            //发出已完成的信号
            dispatch_semaphore_signal(semaphore);
        }
        else
        {
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            returnedData  = dic;

            //发出已完成的信号
            dispatch_semaphore_signal(semaphore);
        }
    }];
    [Task resume];

    //等待执行，不会占用资源

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    return returnedData;  //返回数据
}








@end
