//
//  PhotoCollectionViewCell.m
//  LeYingApp
//
//  Created by sks on 16/1/13.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell


-(UIImageView *)photoImage
{
    if (_photoImage == nil)
    {
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame) )];
        [self.contentView addSubview:_photoImage];
    }
    return _photoImage;
}















@end
