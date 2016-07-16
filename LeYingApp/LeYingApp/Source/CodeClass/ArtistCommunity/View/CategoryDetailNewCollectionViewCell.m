//
//  CategoryDetailCollectionViewCell.m
//  乐影
//
//  Created by zhaoHm on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CategoryDetailNewCollectionViewCell.h"

@implementation CategoryDetailNewCollectionViewCell

//@property (nonatomic,strong) UIImageView *imgCategory;
-(UIImageView *)imgCategory
{
    if (_imgCategory == nil) {
        CGFloat padding = 0;
        self.imgCategory = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding, (CGRectGetWidth(self.frame)) + 4 * 1, 110 + 25)];
        [self.contentView addSubview:_imgCategory];
//        self.contentView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
//        self.contentView.backgroundColor = [UIColor orangeColor];
        
    }
    return _imgCategory;
}
//// 下部容器
//@property (nonatomic,strong) UIView *bottomView;
-(UIView *)bottomView
{
    if (_bottomView == nil) {
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgCategory.frame) - 25, CGRectGetWidth(self.imgCategory.frame) - 0 * 4, 25)];
//        self.bottomView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
        self.bottomView.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.6];
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}
//@property (nonatomic,strong) UILabel *lblName;
-(UILabel *)lblName
{
    if (_lblName == nil) {
        self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(3, 2, (CGRectGetWidth(self.bottomView.frame) - 6) / 2, 20)];
        self.lblName.font = [UIFont systemFontOfSize:14];
//        self.lblName.textColor =  [UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1.0];
        _lblName.textColor = [UIColor whiteColor];
        [self.bottomView addSubview:_lblName];
    }
    return _lblName;
}
//@property (nonatomic,strong) UILabel *lblSee;
-(UILabel *)lblSee
{
    if (_lblSee == nil) {
        CGFloat lblSeeW = CGRectGetWidth(self.lblName.frame) - 20;
        self.lblSee = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bottomView.frame) - lblSeeW - 3, CGRectGetMinY(self.lblName.frame), lblSeeW+10, CGRectGetHeight(self.lblName.frame))];
        self.lblSee.font = [UIFont systemFontOfSize:14];
//        self.lblSee.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f blue:85/255.0f alpha:1.0];
        _lblSee.textColor = [UIColor whiteColor];
        [self.bottomView addSubview:_lblSee];
    }
    return _lblSee;
}
//@property (nonatomic,strong) UIImageView *imgSee;
-(UIImageView *)imgSee
{
    if (_imgSee == nil) {
        self.imgSee = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblSee.frame)-10, CGRectGetMinY(self.lblName.frame), 20, 20)];
        [self.bottomView addSubview:_imgSee];
        
    }
    return _imgSee;
}


@end
