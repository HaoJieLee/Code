//
//  CompanyConnectTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/16.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CompanyConnectTableViewCell.h"

@implementation CompanyConnectTableViewCell





-(UILabel *)myLab
{
    if (_myLab == nil)
    {
        self.myLab = [[UILabel alloc]initWithFrame:CGRectMake(20 , 10, CGRectGetWidth(self.frame) - 40, 30)];
        self.myLab .font = [UIFont systemFontOfSize:15];
        self.myLab.textColor =  [UIColor colorWithRed:48/255.0f green:50/255.0f blue:51/255.0f alpha:1.0];
        self.myLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_myLab];
    }
    return _myLab;
}




-(UILabel *)phoneLab
{
    if (_phoneLab == nil)
    {
        self.phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(20 , CGRectGetMaxY(self.myLab.frame), CGRectGetWidth(self.frame) - 40, 20)];
        self.phoneLab.font = [UIFont systemFontOfSize:15];
        self.phoneLab.textColor =  [UIColor colorWithRed:48/255.0f green:50/255.0f blue:51/255.0f alpha:1.0];
        self.phoneLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_phoneLab];
    }
    return _phoneLab ;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
