//
//  getProjectData.m
//  LeYingApp
//
//  Created by sks on 15/12/23.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "getProjectData.h"
#import "projectList.h"
#import "payBackModel.h"
#import "completeModel.h"
static getProjectData *gd;
@implementation getProjectData


+(instancetype)shareProjectData
{
    if (gd == nil)
    {
        //dispatch_once_t 用于检查该代码块是否已经被调度谓词
        //dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题。
        static dispatch_once_t once_token;
        dispatch_once(&once_token,^{
            gd = [[getProjectData alloc]init];
            
        });
    }
    return gd;
}
/**获取城市信息*/
- (NSMutableArray*)getCitys{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dic = [self dictionaruWithUrl:@"" UrlString:@"/other/city"];
    NSArray *cityArray = [dic objectForKey:@"data"];
    for (NSDictionary *dic in cityArray) {
        [array addObject:[dic objectForKey:@"province"]];
    }
    return array;
}

/**封装请求 urlString请求参数  string接口字符串 */
- (NSDictionary*)dictionaruWithUrl:(NSString *)urlString UrlString:(NSString*)string{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,string];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSData *argDada = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}

// 获取项目列表
-(void)getDataListWithPage:(NSString *)page getPagesize:(NSString *)pagesize getRecommend:(NSString *)recommend getStatus:(NSString *)status getOrder:(NSString *)order passValue:(PassValue)Value
{
    // 创建线程队列(全局)
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    // 定义子线程的内容.
    dispatch_async(globl_t, ^{
        // 在这对花括号内的所有操作都不会阻塞主线程了哦
        
        // 请求数据
       
        NSDictionary *user = @{
                               @"page" : page,
                               @"page_size" : pagesize,
                               @"is_recommend" : recommend,
                               @"status" : status,
                               @"order_by" : order
                               };
        if ([NSJSONSerialization isValidJSONObject:user])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            
            NSURL *url = [NSURL URLWithString:@"http://www.leychina.com/api/public/project/get_projects_by_page"];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request setRequestMethod:@"POST"];
            [request setPostBody:tempJsonData];
            [request startSynchronous];
            NSError *error1 = [request error];
            if (!error1) {
                NSData *response = [request responseData];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:(NSJSONReadingAllowFragments) error:nil];
                
                NSArray *arr1 = [NSArray array];
                arr1 = [dict objectForKey:@"projects"];
                //self.arr = [NSMutableArray array];
                for (NSDictionary * dict in arr1)
                {
                    projectList * model = [[projectList alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.arr addObject:model];
                }
                
                
            }
            else
            {
                
                NSString *str = [NSString stringWithString:error1.localizedDescription];
                NSLog(@"%@", str);
            }
        }
        Value(self.arr);
        
        //self.arr = [NSMutableArray array];
    });
  
    
}
-(void)getHavenDataListWithPage:(NSString *)page getPagesize:(NSString *)pagesize getRecommend:(NSString *)recommend getStatus:(NSString *)status getOrder:(NSString *)order passValue:(PassValue2)Value
{
    // 创建线程队列(全局)
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    // 定义子线程的内容.
    dispatch_async(globl_t, ^{
        // 在这对花括号内的所有操作都不会阻塞主线程了哦
        
        // 请求数据
        
        NSDictionary *user = @{
                               @"page" : page,
                               @"page_size" : pagesize,
                               @"is_recommend" : recommend,
                               @"status" : status,
                               @"order_by" : order
                               };
        if ([NSJSONSerialization isValidJSONObject:user])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            
            NSURL *url = [NSURL URLWithString:@"http://www.leychina.com/api/public/project/get_projects_by_page"];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request setRequestMethod:@"POST"];
            [request setPostBody:tempJsonData];
            [request startSynchronous];
            NSError *error1 = [request error];
            if (!error1) {
                NSData *response = [request responseData];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:(NSJSONReadingAllowFragments) error:nil];
                
                NSArray *arr1 = [NSArray array];
                arr1 = [dict objectForKey:@"projects"];
                //self.arr = [NSMutableArray array];
                for (NSDictionary * dict in arr1)
                {
                    projectList * model = [[projectList alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.arr3 addObject:model];
                }
                
                
            }
            else
            {
                
                NSString *str = [NSString stringWithString:error1.localizedDescription];
                NSLog(@"%@", str);
            }
        }
        Value(self.arr3);
        
    });
}
//获取项目回报信息
-(void)getPayBackMeassageWithProjectID:(NSString *)projectID PaybackValue:(PayBackValue)BackValue
{
    // 创建线程队列(全局)
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    // 定义子线程的内容.
    dispatch_async(globl_t, ^{
        // 在这对花括号内的所有操作都不会阻塞主线程了哦
        
        // 请求数据
        
        NSDictionary *user = @{
                               @"project_id" : projectID
                               };
        if ([NSJSONSerialization isValidJSONObject:user])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
            NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
            
            NSURL *url = [NSURL URLWithString:@"http://www.leychina.com/api/public/payback/get_paybacks_by_project_id"];
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
            [request setRequestMethod:@"POST"];
            [request setPostBody:tempJsonData];
            [request startSynchronous];
            NSError *error1 = [request error];
            if (!error1) {
                NSData *response = [request responseData];
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:(NSJSONReadingAllowFragments) error:nil];
                
                NSArray *arr2 = [NSArray array];
                arr2 = [dict objectForKey:@"paybacks"];
                //NSLog(@"%@",self.arr);
                //self.arr1 = [NSMutableArray array];
                for (NSDictionary * dict in arr2)
                {
                    payBackModel * m = [[payBackModel alloc] init];
                    [m setValuesForKeysWithDictionary:dict];
                    [self.arr1 addObject:m];
                }
                
            }
            else
            {
                
                NSString *str = [NSString stringWithString:error1.localizedDescription];
                NSLog(@"%@", str);
            }
        }
        
        BackValue(self.arr1);
     
    });
}


// 收藏项目
-(void)getCollectProject:(NSString *)projectId getToken:(NSString *)token
{
    NSDictionary *user = @{
                           @"project_id" : projectId
                           
                          };
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/attention_project?token="];
        
        NSMutableString *str2 = [NSMutableString stringWithString:token];
        
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
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
            
        }
        else
        {
            
            NSString *str = [NSString stringWithString:error1.localizedDescription];
            NSLog(@"%@", str);
        }
    }

}


-(void)deleteCollectProject:(NSString *)projectId getToken:(NSString *)token
{
    
    
    
    
    NSDictionary *user = @{
                           @"project_id" : projectId
                           };
    if ([NSJSONSerialization isValidJSONObject:user])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:user options:NSJSONWritingPrettyPrinted error: &error];
        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
        
        NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/del_attention_project?token="];
        NSMutableString *str2 = [NSMutableString stringWithString:token];
        
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
            
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"删除成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            
            [view show];
            
        }
        else
        {
            
            NSString *str = [NSString stringWithString:error1.localizedDescription];
            NSLog(@"%@", str);
        }
    }

}

-(void)getCollectWithToken:(NSString *)Token getCollectValue:(GetColleValue)GetValue
{
  
    NSMutableString *str1 = [NSMutableString stringWithString:@"http://www.leychina.com/api/private/user/get_attention_projects?token="];
    
    NSMutableString *str2 = [NSMutableString stringWithString:Token];
    
    NSURL *url = [NSURL URLWithString:[str1 stringByAppendingString:str2]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    [request setHTTPMethod:@"GET"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    

    NSArray *arr1 = [NSArray array];
    arr1 = [dictionary objectForKey:@"projects"];
    self.arr2 = [NSMutableArray array];

    for (NSDictionary * dict in arr1)
    {
        projectList * model = [[projectList alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.arr2 addObject:model];
    }


    GetValue(self.arr2);

}



///////////////////////////////TODO
//进行中
-(void)getDataListWithPage:(NSString *)page  passValue:(PassValue7)Value
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/index/leyinginglist.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"page=%@",page];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr1 = [NSArray array];
    arr1 = [[dict objectForKey:@"datas"] objectForKey:@"list"];
    self.arr7 = [NSMutableArray array];
    if ([[NSString stringWithFormat:@"%@",arr1] isEqualToString:@"0"])
    {
        
    }
    else
    {
        for (NSDictionary * dic in arr1)
        {
            projectList * model = [[projectList alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.arr7 addObject:model];
        }
        
    }
    
    Value(self.arr7);
   
}


// 乐影浏览量
-(void)addClickwithID:(NSString *)projectId
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/index/leyinginglistaddclick.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",projectId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"]objectForKey:@"error"]);
    

    

}
//通告点击量
-(void)tonggaoaddClickwithID:(NSString *)projectId
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/yiren/tonggaoaddclick.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",projectId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"]objectForKey:@"error"]);
    

}

//项目详情
-(void)getDataListWithId:(NSString *)projectId  passValue:(PassValueDic)Value
{
    NSString *urlString = [NSString stringWithFormat:@"id=%@",projectId];
    NSDictionary *dictionary = [[self dictionaruWithUrl:urlString UrlString:@"/Leying/leyingDetail"] objectForKey:@"data"];
    Value(dictionary);
}

//购买活动详情
-(void)getBuyDetailWithId:(NSString *)projectId passValue:(PassValuebuyDic)Value
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/index/buyactivitieinfo.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",projectId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.buyDic = dict;
    Value(self.buyDic);
    
    
    
}


/**已完成项目*/
-(NSArray*)getCompleteWithPageNo:(int)pageNo  AddPageSize:(int)pageSize Type:(NSString*)type
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSString *urlData = [NSString stringWithFormat:@"pageNo=%d&pageSize=%d&type=%@",pageNo,pageSize,type];
    
    NSDictionary *diction = [self dictionaruWithUrl:urlData UrlString:@"/Leying/index"];
        NSArray *arr1 = [NSArray array];
    arr1 = [diction objectForKey:@"data"] ;
        for (NSDictionary * dic in arr1)
        {
            completeModel * model = [[completeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [mutableArray addObject:model];
        }
    
    return mutableArray;
   
}

//已经完成项目浏览量
-(void)completeClickwithID:(NSString *)projectId
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/index/leyingendaddclick.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@",projectId];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"]objectForKey:@"error"]);
    

}

-(NSMutableArray *)arr
{
    if (_arr == nil)
    {
        
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(NSMutableArray *)arr1
{
    if (_arr1 == nil)
    {
        
        _arr1 = [NSMutableArray array];
    }
    return _arr1;
}

-(NSMutableArray *)arr2
{
    if (_arr2 == nil)
    {
        
        _arr2 = [NSMutableArray array];
    }
    return _arr2;
}


-(NSMutableArray *)arr3
{
    if (_arr3 == nil)
    {
        
        _arr3 = [NSMutableArray array];
    }
    return _arr3;
}

-(NSMutableArray *)arr7
{
    if (_arr7 == nil)
    {
        
        _arr7 = [NSMutableArray array];
    }
    return _arr7;
}
-(NSMutableArray *)arr6
{
    if (_arr6 == nil)
    {
        
        _arr6 = [NSMutableArray array];
    }
    return _arr6;
}

-(NSDictionary *)buyDic
{
    if (_buyDic == nil)
    {
        _buyDic = [NSDictionary dictionary];
    }
    return _buyDic;
}

@end
