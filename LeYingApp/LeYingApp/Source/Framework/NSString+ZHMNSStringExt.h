//
//  NSString+ZHMNSStringExt.h
//  时钟
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZHMNSStringExt)

// 对象方法
- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

// 类方法
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;

@end
