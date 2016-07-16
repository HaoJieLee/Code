//
//  getDataHand.m
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "getDataHand.h"




static getDataHand *gd = nil;

@implementation getDataHand

+(instancetype)shareHandLineData
{
    if (gd == nil)
    {
        //dispatch_once_t 用于检查该代码块是否已经被调度谓词
        //dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题。
        static dispatch_once_t once_token;
        dispatch_once(&once_token,^{
            gd = [[getDataHand alloc]init];
            
        });
    }
    return gd;
}

/**获取融云聊天id*/
-(NSDictionary*)getRongCloudIDWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce userid:(NSString*)userid{
    NSString *delteString = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@&id=%@",accessKey,signature,timestamp,nonce,userid];
    NSDictionary *dic = [self dictionaruWithUrl:delteString UrlString:@"/Talk/getRongCloudId"];
    return dic;
}

/**获取融云的Token*/
-(NSDictionary*)getRongCloudTokenWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce{
    NSString *delteString = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@",accessKey,signature,timestamp,nonce];
    NSDictionary *dic = [self dictionaruWithUrl:delteString UrlString:@"/talk/refreshRongCloudToken"];
    return dic;
}
/**自动登录*/
- (NSDictionary*)autoLoginWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce{
    NSString *delteString = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@",accessKey,signature,timestamp,nonce];
    NSDictionary *dic = [self dictionaruWithUrl:delteString UrlString:@"/api/autoLogin"];
    return dic;
}
/**根据用户id获取用户所有图片*/
- (NSArray*)getUsersAllPhotosWithUserId:(NSString*)userid{
    NSMutableArray *array = [NSMutableArray array];
    NSString *url = [NSString stringWithFormat:@"id=%@",userid];
    NSDictionary *dic = [self dictionaruWithUrl:url UrlString:@"/Artist/photos"];
    NSArray *arr = [dic objectForKey:@"data"];
    for (NSDictionary *dictionay in arr) {
        [array addObject:dictionay];
    }
   
        return array;
}
/**删除一张图片*/
-(NSString*)DeletePhotosDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce ImgId:(NSString*)imgId{
    NSString *delteString = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@&imgId=%@",accessKey,signature,timestamp,nonce,imgId];
    NSDictionary *dic = [self dictionaruWithUrl:delteString UrlString:@"/artist/deletePhoto"];
    return [dic objectForKey:@"message"];
}
/**将图片保存到相册资料*/
-(NSDictionary*)SaveUsersPhotosDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce ImgUrl:(NSString*)imgUrl imgDescription:(NSString*)imgDescription{
    NSString *urlData = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@&imgUrl=%@&imgDescription=%@",accessKey,signature,timestamp,nonce,imgUrl,imgDescription];
    NSDictionary *dic = [self dictionaruWithUrl:urlData UrlString:@"/artist/addPhoto"];
    return dic;

}

-(NSDictionary*)SaveUsersAllDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce Key:(NSString*)key{
        NSString *urlData = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@&%@",accessKey,signature,timestamp,nonce,key];
    NSDictionary *dic = [self dictionaruWithUrl:urlData UrlString:@"/artist/update"];
    return dic;
}

/**保存用户的身份信息,修改用户资料*/
-(NSString*)RefreshUsersIdentityDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce Identity:(NSString*)identity{
    NSString *urlData = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@&identity=%@&gender=1",accessKey,signature,timestamp,nonce,identity];
    NSDictionary *dic = [self dictionaruWithUrl:urlData UrlString:@"/api/modifybaseprofile"];
    NSString *idenString = [dic objectForKey:@"message"];
    return idenString;
}
/**获取标签分类*/
-(NSArray *)returnKind{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dic = [self dictionaruWithUrl:nil UrlString:@"/api/artist/gettag"];
    [array addObjectsFromArray:[dic objectForKey:@"data"]];
    return array;
}
/**获取上传图片的Token */
-(NSString*)stringPutPicture{
   NSString *string =[[[self dictionaruWithUrl:nil UrlString:@"/other/getupimgtoken"]objectForKey:@"data"] objectForKey:@"token"];
    return string;
}
/**刷新用户的全部资料*/
-(NSDictionary*)RefreshUsersAllDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce{
    NSString *dataString = [NSString stringWithFormat:@"accessKey=%@&signature=%@&timestamp=%@&nonce=%@",accessKey,signature,timestamp,nonce];
    NSDictionary *dic = [self dictionaruWithUrl:dataString UrlString:@"/api/refreshall"];
    return [dic objectForKey:@"data"];
}
//获取验证码、、注册,忘记密码
-(void)getPhoneNumber:(NSString *)number Type:(int)type
{
    // 准备请求
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/api/sendPhoneCode"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"phone=%@&type=%d",number,type];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (type==1) {
        if ([[dict objectForKey:@"message"]isEqualToString:@"该手机号码已存在"])
        {
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"发送失败：%@",[dict objectForKey:@"message"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }
        else
        {
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            
        }

    }else if (type==2){
        if (![[dict objectForKey:@"message"]isEqualToString:@"成功"])
        {
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"发送失败：%@",[dict objectForKey:@"message"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }
        else
        {
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            
        }

    }
    
    
}

/**忘记密码*/
-(BOOL)editPhoneNumber:(NSString *)number getSMS:(NSString *)sms getPassWord:(NSString *)passWord
{
    NSString *phoneTokenId = [[[self verifySMSPhone:number VerifyCode:sms Type:2] objectForKey:@"data"] objectForKey:@"phoneTokenId"];
    NSString *urlStr = @"/api/forgetPassword";
       NSString *argument = [NSString stringWithFormat:@"phone=%@&phoneTokenId=%@&newPassword=%@",number,phoneTokenId,passWord];
    NSDictionary *dic = [self dictionaruWithUrl:argument UrlString:urlStr];
    NSLog(@"%@",[dic objectForKey:@"message"]);
    if ([[dic objectForKey:@"message"] isEqual:@"密码修改成功"]) {
        return YES;
    }
    else{
        return NO;
    }
}


/**注册*/
-(BOOL)getPhoneNumber:(NSString *)number getSMS:(NSString *)sms getPassWord:(NSString *)passWord
{
   
    NSDictionary *smsVerifyDic = [self verifySMSPhone:number VerifyCode:sms Type:1];
    //验证手机验证码是否正确
    if ([[smsVerifyDic objectForKey:@"message"]isEqual:@"成功"]) {
        NSDictionary *phoneTokenIdDic = [smsVerifyDic objectForKey:@"data"];
        NSString *phoneTokenId = [phoneTokenIdDic objectForKey:@"phoneTokenId"];
        // 准备参数
        NSString *argument = [NSString stringWithFormat:@"phone=%@&phoneTokenId=%@&password=%@",number,phoneTokenId,passWord];
        NSDictionary *successDic = [self dictionaruWithUrl:argument UrlString:@"/api/register"];
        if ([[successDic objectForKey:@"message"]isEqualToString:@"成功"]) {

            return YES;
        }else{
            //注册失败
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[successDic objectForKey:@"message"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
            return NO;
        }
     
    }else{
        //验证码失败
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[smsVerifyDic objectForKey:@"message"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
        return NO;
    }
    return YES;
    
}
/**验证手机验证码是否正确*/
- (NSDictionary*)verifySMSPhone:(NSString*)phone VerifyCode:(NSString*)verify Type:(int)type{
    //验证手机注册码
    NSString *dataString = [NSString stringWithFormat:@"verifyCode=%@&phone=%@&type=%d",verify,phone,type];
   NSDictionary *dic = [self dictionaruWithUrl:dataString UrlString:@"/api/checkPhoneCode"];
    return dic;
}
//封装的请求
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
/**登录*/
-(NSDictionary*)getPhone:(NSString *)phone getPassword:(NSString *)password
{
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"phone=%@&password=%@",phone,password];
   NSDictionary *loginDic = [self dictionaruWithUrl:argument UrlString:@"/api/login"];
    return loginDic;
}

-(void)editGetNumber:(NSString *)number
{
    // 准备请求
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/system/getcode.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"tel=%@",number];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"]objectForKey:@"error"]);
    if (![[NSString stringWithFormat:@"%@",[[dict objectForKey:@"datas"]objectForKey:@"error"] ]isEqualToString:@"(null)"])
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"发送失败：%@",[[dict objectForKey:@"datas"]objectForKey:@"error"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
    }
    else
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alView show];
        
    }
}

//修改昵称
-(BOOL)editUserMarket:(NSString *)artistMarket
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/system/marketedit.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"market=%@",artistMarket];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"success"]);
    if ([[dict objectForKey:@"datas"] objectForKey:@"success"] != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }

}

//修改密码
-(BOOL)editUserPasswordWithPhone:(NSString *)artPhone Code:(NSString *)artCode password:(NSString *)artPassword

{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/system/passwordedit.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"tel=%@&code=%@&password=%@",artPhone,artCode,artPassword];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([[dict objectForKey:@"datas"]objectForKey:@"success"]!= nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
  


}

//懒加载初始化数组
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil)
    {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}






@end
