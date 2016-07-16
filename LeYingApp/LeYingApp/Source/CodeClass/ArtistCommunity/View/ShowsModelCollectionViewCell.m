//
//  ShowsModelCollectionViewCell.m
//  乐影
//
//  Created by zhaoHm on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ShowsModelCollectionViewCell.h"

@implementation ShowsModelCollectionViewCell

-(UIImageView *)imgCategory
{
    if (_imgCategory == nil) {
        CGFloat padding = 4;
        self.imgCategory = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, (CGRectGetWidth(self.frame)) - padding * 2, (CGRectGetWidth(self.frame)) - padding * 2)];
        [self.contentView addSubview:_imgCategory];
        self.contentView.backgroundColor = [UIColor colorWithRed:195/255.0 green:197/255.0 blue:200/255.0 alpha:1];
//        self.imgCategory.contentMode = UIViewContentModeCenter;
//        self.imgCategory.clipsToBounds = YES;
        self.imgCategory.contentMode =  UIViewContentModeScaleAspectFill;
        self.imgCategory.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.imgCategory.clipsToBounds  = YES;
        
    }
    return _imgCategory;
}

@end
