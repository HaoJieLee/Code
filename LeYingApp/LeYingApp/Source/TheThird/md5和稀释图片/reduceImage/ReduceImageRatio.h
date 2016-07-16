//
//  ReduceImageRatio.h
//  GGSee
//
//  Created by zhouhaifeng on 15/8/20.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ReduceImageRatio : NSObject
+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image;
@end
