//
//  getUserAddressData.m
//  LeYingApp
//
//  Created by sks on 15/12/24.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "getUserAddressData.h"
#import "getAddressModel.h"
static getUserAddressData *gud = nil;
@implementation getUserAddressData


+(instancetype)shareDataAddress
{
    if (gud == nil)
    {
        static dispatch_once_t once_token;
        dispatch_once(&once_token,^{
            gud = [[getUserAddressData alloc]init];
            
        });

    }
    return gud;
}


-(void)addUserAddressWithReceieveMan:(NSString *)receiveman Phone:(NSString *)phone Address:(NSString *)address Withtoken:(NSString *)userToken
{
    NSDictionary *user = @{
                           @"recieve_man" : receiveman,
                           @"phone":phone,
                           @"address":address
                           };
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/add_user_address?token="];
        NSMutableString *str2 = [NSMutableString stringWithString:userToken];
        
        NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        [request startSynchronous];
        NSError *error1 = [request error];
        if (!error1) {
            NSData *response = [request responseData];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:(NSJSONReadingAllowFragments) error:nil];
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"添加成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
            
        }
        else
        {
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"添加失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
        }
    }

}

//全部地址
-(void)getAlladdressWithToken:(NSString *)userToken WithAddressValue:(GetAddressValue)addressValue
{
    
    // 创建线程队列(全局)
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    // 定义子线程的内容.
    dispatch_async(globl_t, ^{
        // 在这对花括号内的所有操作都不会阻塞主线程了哦
        
        // 请求数据
        NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/get_user_addresses?token="];
        NSMutableString *str2 = [NSMutableString stringWithString:userToken];
        
        NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        
        [request setHTTPMethod:@"GET"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        NSArray *arr = [dictionary objectForKey:@"addresses"];
        
        self.allAddressArr = [NSMutableArray array];
        for (NSDictionary * dict in arr)
        {
            
            getAddressModel * m = [[getAddressModel alloc] init];
            [m setValuesForKeysWithDictionary:dict];
            [self.allAddressArr addObject:m];
        }
        
        addressValue(self.allAddressArr);

      
    });

}

#pragma 默认地址
-(void)getDefaultAddressWithToken:(NSString *)userToken WithAddressValue:(GetDefaultAddressValue)defaultAddressValue
{
    
//     创建线程队列(全局)
//    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
//    
//    // 定义子线程的内容.
//    dispatch_async(globl_t, ^{
//        // 在这对花括号内的所有操作都不会阻塞主线程了哦
//        
//        // 请求数据
//        
//        
//        
//        
//    });

    
    
    
    NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/get_user_default_address?token="];
    NSMutableString *str2 = [NSMutableString stringWithString:userToken];
    
    NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.defaultAddressArr = [NSMutableArray array];
    NSDictionary *s = [dictionary objectForKey:@"address"];
    //NSLog(@"%@",s);
    getAddressModel * m = [[getAddressModel alloc] init];
    [m setValuesForKeysWithDictionary:s];
    [self.defaultAddressArr addObject:m];

//    for (NSDictionary * dict in arr)
//    {
//        getAddressModel * m = [[getAddressModel alloc] init];
//        [m setValuesForKeysWithDictionary:s];
//        [self.defaultAddressArr addObject:m];
   // }
    
    defaultAddressValue(self.defaultAddressArr);

}

-(void)deleteAddressWithId:(NSString *)addressId withToken:(NSString *)mytoken
{
    NSDictionary *user = @{
                           @"address_id":addressId
                           };
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/del_user_address?token="];
        NSMutableString *str2 = [NSMutableString stringWithString:mytoken];
        
        NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        [request startSynchronous];
        NSError *error1 = [request error];
        if (!error1) {
            NSData *response = [request responseData];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:(NSJSONReadingAllowFragments) error:nil];
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
            
        }
        else
        {
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"删除失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
        }
    }

}




-(void)editUserAddressWithReceieveMan:(NSString *)receiveman Phone:(NSString *)phone Address:(NSString *)address AddressId:(NSString *)addressid Withtoken:(NSString *)userToken
{
    NSDictionary *user = @{
                           @"recieve_man" : receiveman,
                           @"phone":phone,
                           @"address":address,
                           @"address_id":addressid
                           };
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/update_user_address?token="];
        NSMutableString *str2 = [NSMutableString stringWithString:userToken];
        
        NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
        [request setRequestMethod:@"POST"];
        [request setPostBody:tempJsonData];
        [request startSynchronous];
        NSError *error1 = [request error];
        if (!error1) {
            NSData *response = [request responseData];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:(NSJSONReadingAllowFragments) error:nil];
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
            
        }
        else
        {
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
        }
    }

}





-(NSMutableArray *)allAddressArr
{
    if (_allAddressArr == nil)
    {
        
        _allAddressArr = [NSMutableArray array];
    }
    return _allAddressArr;
}

-(NSMutableArray *)defaultAddressArr
{
    if (_defaultAddressArr == nil)
    {
        
        _defaultAddressArr = [NSMutableArray array];
    }
    return _defaultAddressArr;
}









@end
