//
//  PicUploadCollectionViewCell.m
//  乐影
//
//  Created by zhaoHm on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "PicUploadCollectionViewCell.h"

@implementation PicUploadCollectionViewCell

-(UIImageView *)imgCategory
{
    if (_imgCategory == nil) {
        CGFloat padding = 2;
        self.imgCategory = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, (CGRectGetWidth(self.frame)) - padding * 2, 154)];
        [self.contentView addSubview:_imgCategory];
        self.contentView.backgroundColor = [UIColor colorWithRed:195/255.0 green:197/255.0 blue:200/255.0 alpha:1];
    }
    return _imgCategory;
}

-(HMButton *)btnDelete
{
    if (_btnDelete == nil) {
        _btnDelete = [HMButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.frame = CGRectMake(CGRectGetWidth(self.frame) - 30, 2, 30, 30);
        _btnDelete.layer.cornerRadius = 15;
//        _btnDelete.frame = CGRectMake(0, 0, 50, 50);
        _btnDelete.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_btnDelete];
        _btnDelete.hidden = YES;
    }
    return _btnDelete;
}

@end
