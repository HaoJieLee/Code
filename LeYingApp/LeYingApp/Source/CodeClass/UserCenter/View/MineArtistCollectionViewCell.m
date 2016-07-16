//
//  MineArtistCollectionViewCell.m
//  乐影
//
//  Created by zhaoHm on 16/3/16.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MineArtistCollectionViewCell.h"

@implementation MineArtistCollectionViewCell

-(UIImageView *)imgShows
{
    if (_imgShows == nil) {
        CGFloat padding = 4;
        self.imgShows = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, (CGRectGetWidth(self.frame)) - padding * 2, 110)];
        [self.contentView addSubview:_imgShows];
        self.contentView.backgroundColor = [UIColor colorWithRed:195/255.0 green:197/255.0 blue:200/255.0 alpha:1];
    }
    return _imgShows;
}

//@property (nonatomic,strong) UIView *bottomView;
-(UIView *)bottomView
{
    if (_bottomView == nil) {
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgShows.frame) + 4, CGRectGetWidth(self.imgShows.frame) + 2 * 4, 30)];
        self.bottomView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}

-(UILabel *)lblTitle
{
    if (_lblTitle == nil) {
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(3, 2, (CGRectGetWidth(self.bottomView.frame) - 6) / 2, 20)];
        self.lblTitle.font = [UIFont systemFontOfSize:14];
        [self.bottomView addSubview:_lblTitle];
    }
    return _lblTitle;
}

-(UIButton *)imgDelete
{
    if (_imgDelete == nil) {
        CGFloat lblSeeW = 16;
        self.imgDelete = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bottomView.frame) - 10 - lblSeeW, CGRectGetMinY(self.lblTitle.frame), lblSeeW, lblSeeW)];
        [self.bottomView addSubview:_imgDelete];
    }
    return _imgDelete;
}

@end
