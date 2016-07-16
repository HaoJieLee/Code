//
//  NSString+ZHMNSStringExt.m
//  时钟
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NSString+ZHMNSStringExt.h"

@implementation NSString (ZHMNSStringExt)

// 对象方法的实现
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

// 类方法的实现
+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font
{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}

@end
