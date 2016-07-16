//
//  CrewPhCollectionViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CrewPhCollectionViewCell.h"

@implementation CrewPhCollectionViewCell


-(UIImageView *)photoImage
{
    if (_photoImage == nil)
    {
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame) )];
        [self.contentView addSubview:_photoImage];
        self.photoImage.contentMode =  UIViewContentModeScaleAspectFill;
        self.photoImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.photoImage.clipsToBounds  = YES;
    }
    return _photoImage;
}





@end
