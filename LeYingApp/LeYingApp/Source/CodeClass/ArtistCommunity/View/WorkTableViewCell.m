//
//  WorkTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/24.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "WorkTableViewCell.h"

@implementation WorkTableViewCell




-(UILabel *)titLab
{
    if (_titLab == nil)
    {
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(20 , 10, (CGRectGetWidth(self.frame) - 40)/2, 20)];
        self.titLab .font = [UIFont systemFontOfSize:15];
        self.titLab.textColor =  [UIColor colorWithRed:48/255.0f green:50/255.0f blue:51/255.0f alpha:1.0];
        self.titLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titLab];
    }
    return _titLab ;
}

-(UILabel *)detailLab
{
    if (_detailLab == nil)
    {
        self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(20 , CGRectGetMaxY(self.titLab.frame), (CGRectGetWidth(self.frame) - 40), 10)];
        self.detailLab .font = [UIFont systemFontOfSize:14];
        self.detailLab.textAlignment = NSTextAlignmentLeft;
        self.detailLab.textColor =  [UIColor colorWithRed:48/255.0f green:50/255.0f blue:51/255.0f alpha:1.0];
        self.detailLab.numberOfLines = 0;
        [self.contentView addSubview:_detailLab];
    }
    return _detailLab ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
