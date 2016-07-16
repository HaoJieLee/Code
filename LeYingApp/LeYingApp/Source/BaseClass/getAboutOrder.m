//
//  getAboutOrder.m
//  LeYingApp
//
//  Created by sks on 15/12/29.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "getAboutOrder.h"
#import "orderMessageModel.h"
static getAboutOrder *gad = nil;
@implementation getAboutOrder



+(instancetype)shareDataOrder
{
    if (gad == nil)
    {
        static dispatch_once_t once_token;
        dispatch_once(&once_token,^{
            gad = [[getAboutOrder alloc]init];
            
        });
        
    }
    return gad;

}



//获取订单信息
-(void)getOrderWithPage:(NSString *)page Pagesize:(NSString *)pagesize Paybackid:(NSString *)payid Status:(NSString *)status ProjectId:(NSString *)projectid Token:(NSString *)token WithOrderValue:(OrderValue)orderValue
{
    //创建线程队列(全局)
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    // 定义子线程的内容.
    dispatch_async(globl_t, ^{
        // 在这对花括号内的所有操作都不会阻塞主线程了哦
        
        // 请求数据
        
        
        NSDictionary *user = @{
                               @"page" : page,
                               @"page_size" : pagesize,
                               @"payback_id" : payid,
                               @"status" : status,
                               @"project_id" : projectid
                               };
        if ([NSJSONSerialization isValidJSONObject:user])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            
            NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/order/get_order_by_page?token="];
            NSMutableString *str2 = [NSMutableString stringWithString:token];
            
            NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request setRequestMethod:@"POST"];
            [request setPostBody:tempJsonData];
            [request startSynchronous];
            NSError *error1 = [request error];
            self.orderMessageArr = [NSMutableArray array];
            if (!error1)
            {
                NSData *response = [request responseData];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:(NSJSONReadingAllowFragments) error:nil];
                
                
                NSLog(@"%@",dict);
                NSArray *arr1 = [NSArray array];
                arr1 = [dict objectForKey:@"orders"];
                for (NSDictionary * dict in arr1)
                {
                    orderMessageModel * m = [[orderMessageModel alloc] init];
                    [m setValuesForKeysWithDictionary:dict];
                    [self.orderMessageArr addObject:m];
                }
                
                
            }
            else
            {
                
                NSString *str = [NSString stringWithString:error1.localizedDescription];
                NSLog(@"%@", str);
            }
            
        }
        
        
        orderValue(self.orderMessageArr);
        
    });

    
    
    
}

-(void)submitOrderWithPaybackId:(NSInteger)paybackid Projectid:(NSInteger)projectid Amount:(NSInteger)amount DeliverMoney:(NSInteger)deivermoney AddressId:(NSInteger)addressid Token:(NSString *)token
{
    NSDictionary *user = @{
                           @"payback_id" : [NSString stringWithFormat:@"%ld",paybackid],
                           @"project_id" : [NSString stringWithFormat:@"%ld",projectid],
                           @"amount" : [NSString stringWithFormat:@"%ld",amount],
                           @"delivery_money" : [NSString stringWithFormat:@"%ld",deivermoney],
                           @"address_id" : [NSString stringWithFormat:@"%ld",addressid]
                           };
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/order/submit_order?token="];
        NSMutableString *str2 = [NSMutableString stringWithString:token];
        
        NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        [request startSynchronous];
        NSError *error1 = [request error];
        if (!error1)
        {
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"下单成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [view show];  
        }
        else
        {
            
            NSString *str = [NSString stringWithString:error1.localizedDescription];
            NSLog(@"%@", str);
        }
        
        
        
        
    }

}






-(NSMutableArray *)orderMessageArr
{
    if (_orderMessageArr == nil)
    {
        
        _orderMessageArr = [NSMutableArray array];
    }
    return _orderMessageArr;
}

-(NSMutableArray *)orderPayBackArr
{
    if (_orderPayBackArr == nil)
    {
        
        _orderPayBackArr = [NSMutableArray array];
    }
    return _orderPayBackArr;
}

-(NSMutableArray *)orderPublisherArr
{
    if (_orderPublisherArr == nil)
    {
        
        _orderPublisherArr = [NSMutableArray array];
    }
    return _orderPublisherArr;
}



@end
