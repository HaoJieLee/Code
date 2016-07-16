//
//  DictToData.m
//  乐影
//
//  Created by zhaoHm on 16/3/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "DictToData.h"
#import <AFNetworking.h>
#import "MBProgressHUD.h"
static CGRect oldFrame;

@implementation DictToData

+(NSData*)returnDataWithDictionary:(NSDictionary*)dict
{
    NSMutableData* data = [[NSMutableData alloc] init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    return data;
}

// 多图上传
+(void)uploadImages:(NSArray *)images parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
//    NSString *kUploadImageURL = @"http://leying.hivipplus.com/index.php/Home/member/piliangimg.html";
    NSString *kUploadImageURL = [NSString stringWithFormat:@"%@/index.php/Home/member/piliangimg.html",myurl];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    NSURLSessionTask *task = [session POST:kUploadImageURL
                                parameters:parameters
                 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                     NSInteger imageCount = images.count;
                     if (imageCount) {
                         for (NSInteger i = 0; i < imageCount; i++) {
                             UIImage *image = images[i];
                             NSData *imageData = UIImageJPEGRepresentation(image, 0.0f);
                             [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"img%ld", i + 1] fileName:[NSString stringWithFormat:@"img%ld.jpg", i + 1] mimeType:@"image/jpeg"];
                         }
                     }
                 }
                                  progress:nil
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       success(responseObject);
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       failure(error);
                                   }];
    [task resume];
}

// 单张图片上传
+(void)uploadimg:(UIImage *)image serverUrl:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    // 非空上传
    if (image != nil)
    {
        // 图片压缩
//        UIImage *img = [DictToData thumbnailWithImageWithoutScale:image size:CGSizeMake(365, 210)];
        // 再次压缩
        NSData *imageData = UIImageJPEGRepresentation(image, 0.0f);
        // url
        NSURL *URL = [NSURL URLWithString:url];
        
        NSDictionary *param = @{@"ios":@"1"
                                };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:URL.absoluteString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // 上传文件
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
            
        }  progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"成功%@",result);
             UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alView show];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"请检查网络连接" message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alView show];
             NSLog(@"失败%@",error);
         }];
        
    }
}

+(UIImage *)getImageWithUrl:(NSString *)url
{
    UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return img;
}


///////////////////////////////////////////
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}
///////////////////////////////////////////

#pragma mark 图片放大开始
+(void)showImage:(UIImageView *)avatarImageView
{
    UIImage *image = avatarImageView.image;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    
    oldFrame = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroundView.backgroundColor=[UIColor blackColor];
    
    backgroundView.alpha = 0;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldFrame];
    
    imageView.image = image;
    
    imageView.tag = 1;
    
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer: tap];
    
    
    [UIView animateWithDuration:0.3
     
                     animations:^{
                         imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2,[UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
                         
                         backgroundView.alpha = 1;
                         
                     }
                     completion:^(BOOL finished) {
                         
                         
                         
                     }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldFrame;
        backgroundView.alpha = 0;
    }
                     completion:^(BOOL finished) {
                         [backgroundView removeFromSuperview];
                     }];
    
}
#pragma mark 图片放大结束

#pragma mark (头部图片+截图+尾部图片)截图   开始
/**
 headImgName   头部图片
 view   截图的基view   如 self.view
 jietuSize   截图大小
 footerName   尾部图片
 */
+(UIImage *)imageWithHeadImageName:(NSString *)headImgName WithJietuBase:(UIView *)view WithJietuRect:(CGRect)jietuRect WithfooterImageName:(NSString *)footerName
{
    CGFloat headImageHeight = 0.0;
    // 底层图片view
    UIImageView *imgFatherView = [[UIImageView alloc] init];
    // 位置
    CGRect rect = CGRectZero;
    rect.origin.x = 0;
    rect.origin.y = 0;
    // 拼接头部图片
    for (int i = 0; i < 1; i ++) {
        UIImage *imgSource = [UIImage imageWithCGImage:[UIImage imageNamed:headImgName].CGImage];
        
        CGFloat height = imgSource.size.height;
        headImageHeight = height;
        CGFloat width = imgSource.size.width;
        rect.size.width = [UIScreen mainScreen].bounds.size.width;
        rect.size.height = height * (([UIScreen mainScreen].bounds.size.width) / width);
        UIImageView *newimgView = [[UIImageView alloc] initWithFrame:rect];
        newimgView.image = imgSource;
        rect.origin.y += rect.size.height - 1;
        [imgFatherView addSubview:newimgView];
    }
    
    // 截图(全屏 view的大小)
    // 设置截图大小
    UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width, view.frame.size.height));
    // 设置截图的裁剪区域
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *imageJie = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 截取想要的部分
    //    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageJie.CGImage, jietuRect);
    //    UIImage *imageJietu = [UIImage imageWithCGImage:imageRefRect];
    
//    UIGraphicsBeginImageContext(jietuRect.size);
//    [imageJie drawAtPoint:CGPointMake(jietuRect.origin.x, jietuRect.origin.y)];
//    UIImage *imageJietu = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    UIImageView *imgBiew = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, imageJie.size.width, imageJie.size.height)];
    imgBiew.image = imageJie;
    [imgFatherView addSubview:imgBiew];
    
    rect.origin.y += imageJie.size.height;
    // 拼接尾部图片
    for (int i = 0; i < 1; i ++) {
        UIImage *imgSource = [UIImage imageWithCGImage:[UIImage imageNamed:footerName].CGImage];
        
        CGFloat height = imgSource.size.height;
        CGFloat width = imgSource.size.width;
        rect.size.width = [UIScreen mainScreen].bounds.size.width;
        rect.size.height = height * (([UIScreen mainScreen].bounds.size.width) / width);
        UIImageView *newimgView = [[UIImageView alloc] initWithFrame:rect];
        newimgView.image = imgSource;
        rect.origin.y += rect.size.height - 1;
        [imgFatherView addSubview:newimgView];
    }
    imgFatherView.frame = CGRectMake(rect.origin.x, 10, rect.size.width, rect.origin.y + 5);
    
    // 截图
    // 设置截图大小
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width, imgFatherView.frame.size.height));
    // 设置截图的裁剪区域
    [imgFatherView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 保存到系统相册库中
    //    UIImageWriteToSavedPhotosAlbum(imageNew, self, nil, nil);
    return imageNew;
}

#pragma mark MB小菊花
+(void)showMBHUBWithContent:(NSString *)content ToView:(UIView *)view
{
    MBProgressHUD *mbHUB = [[MBProgressHUD alloc] init];
    mbHUB = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbHUB.opacity = 0.6;
    mbHUB.labelColor = [UIColor whiteColor];
    mbHUB.labelText = content;
    [mbHUB show:YES];
}


#pragma mark (头部图片+截图+尾部图片)截图   结束


// 判断手机号
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//+ (NSString *)postRequestWithURL: (NSString *)url
//                      postParems: (NSMutableDictionary *)postParems
//                     picFilePath: (NSMutableArray *)picFilePath
//                     picFileName: (NSMutableArray *)picFileName
//{
//    
//    
//    NSString *hyphens = @"--";
//    NSString *boundary = @"*****";
//    NSString *end = @"\r\n";
//    
//    NSMutableData *myRequestData1=[NSMutableData data];
//    //遍历数组，添加多张图片
//    for (int i = 0; i < picFilePath.count; i ++) {
//        NSData* data;
//        UIImage *image=[UIImage imageWithContentsOfFile:[picFilePath objectAtIndex:i]];
//        //判断图片是不是png格式的文件
//        if (UIImagePNGRepresentation(image)) {
//            //返回为png图像。
//            data = UIImagePNGRepresentation(image);
//        }else {
//            //返回为JPEG图像。
//            data = UIImageJPEGRepresentation(image, 1.0);
//        }
//        
//        //所有字段的拼接都不能缺少，要保证格式正确
//        [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
//        [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
//        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSMutableString *fileTitle=[[NSMutableString alloc]init];
//        //要上传的文件名和key，服务器端用file接收
//        [fileTitle appendFormat:@"Content-Disposition:form-data;name=\"%@\";filename=\"%@\"",[NSString stringWithFormat:@"file%d",i+1],[NSString stringWithFormat:@"image%d.png",i+1]];
//        
//        [fileTitle appendString:end];
//        
//        [fileTitle appendString:[NSString stringWithFormat:@"Content-Type:application/octet-stream%@",end]];
//        [fileTitle appendString:end];
//        
//        [myRequestData1 appendData:[fileTitle dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [myRequestData1 appendData:data];
//        
//        [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//        
//    }
//    
//    
//    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
//    [myRequestData1 appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
//    [myRequestData1 appendData:[hyphens dataUsingEncoding:NSUTF8StringEncoding]];
//    [myRequestData1 appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    
//    //参数的集合的所有key的集合
//    NSArray *keys= [postParems allKeys];
//    
//    //添加其他参数
//    for(int i=0;i<[keys count];i++)
//    {
//        
//        NSMutableString *body=[[NSMutableString alloc]init];
//        [body appendString:hyphens];
//        [body appendString:boundary];
//        [body appendString:end];
//        //得到当前key
//        NSString *key=[keys objectAtIndex:i];
//        //添加字段名称
//        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"",key];
//        
//        [body appendString:end];
//        
//        [body appendString:end];
//        //添加字段的值
//        [body appendFormat:@"%@",[postParems objectForKey:key]];
//        
//        [body appendString:end];
//        
//        [myRequestData1 appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//        NSLog(@"添加字段的值==%@",[postParems objectForKey:key]);
//    }
//    
//    //根据url初始化request
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
//                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                                       timeoutInterval:20];
//    
//    
//    //设置HTTPHeader中Content-Type的值
//    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    //设置HTTPHeader
//    [request setValue:content forHTTPHeaderField:@"Content-Type"];
//    //设置Content-Length
//    [request setValue:[NSString stringWithFormat:@"%d", [myRequestData1 length]] forHTTPHeaderField:@"Content-Length"];
//    //设置http body
//    [request setHTTPBody:myRequestData1];
//    //http method
//    [request setHTTPMethod:@"POST"];
//    
//    NSHTTPURLResponse *urlResponese = nil;
//    NSError *error = [[NSError alloc]init];
//    
//    NSData* resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponese error:&error];
//    NSString* result= [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
//    
//    if([urlResponese statusCode] >=200&&[urlResponese statusCode]<300){
//        NSLog(@"返回结果=====%@",result);
//        SBJsonParser *parser = [[SBJsonParser alloc ] init];
//        NSDictionary *jsonobj = [parser objectWithString:result];
//        
//        if (jsonobj == nil || (id)jsonobj == [NSNull null] || [[jsonobj objectForKey:@"flag"] intValue] == 0)
//        {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//            });
//        }
//        else
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [Singleton sharedSingleton].shopId = [[jsonobj objectForKey:@"shopId"]stringValue];
//                [alert show];
//            });
//        }
//        
//        return result;
//    }
//    else if (error) {
//        NSLog(@"%@",error);
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"dissmissSVP" object:nil];
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return nil;
//        
//    }
//    else
//        return nil;
//    
//}

@end
