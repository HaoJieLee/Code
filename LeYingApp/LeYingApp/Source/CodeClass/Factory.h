//
//  Factory.h
//  乐影
//
//  Created by LiuChenhao on 16/6/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface Factory : NSObject
//button
+ (UIButton*)initWithFrame:(CGRect)frame BackColor:(UIColor*)color Title:(NSString *)title TintColor:(UIColor*)tintColor Tag:(NSInteger)tag ButtonType:(UIButtonType)type;

//**时间戳转换*/
+(NSString*)stringWithDataString:(NSString*)dataString;

/**SHA1加密*/
+ (NSString *)SHA1HexDigest:(NSString*)input;
/**把当前时间转换为时间戳*/
+(NSString*)TimeToDataString;
/**随机产生字符串*/
+(NSString*)randomlyString;

@end
