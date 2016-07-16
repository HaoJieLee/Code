//
//  Factory.m
//  乐影
//
//  Created by LiuChenhao on 16/6/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "Factory.h"

@implementation Factory
+ (UIButton*)initWithFrame:(CGRect)frame BackColor:(UIColor*)color Title:(NSString *)title TintColor:(UIColor*)tintColor Tag:(NSInteger)tag ButtonType:(UIButtonType)type{
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = frame;
    button.backgroundColor = color;
    button.tintColor = tintColor;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+(NSString*)stringWithDataString:(NSString*)dataString{
   
    NSTimeInterval time=[dataString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *timeString = [formatter stringFromDate:detaildate];
    return timeString;
}
/**SHA1加密*/
+ (NSString *)SHA1HexDigest:(NSString*)input
{
    const char *cstr = [input UTF8String];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(cstr,  strlen(cstr), digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
   
}
/**把当前时间转换为时间戳*/
+(NSString*)TimeToDataString{
    
    NSTimeInterval time =  [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",time];
    return timeString;

}


+(NSString*)randomlyString{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
@end
