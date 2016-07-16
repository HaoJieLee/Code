//
//  ReduceImageRatio.m
//  GGSee
//
//  Created by zhouhaifeng on 15/8/20.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "ReduceImageRatio.h"

@implementation ReduceImageRatio
+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = GGSSizeReduce(image.size, length);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}

static CGSize GGSSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
{
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    
    return imgSize;
}
@end
