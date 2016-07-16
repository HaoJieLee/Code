//
//  UserTableViewCell.m
//  LeYingApp
//
//  Created by sks on 15/12/10.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell




-(UILabel *)titLable
{
    if (_titLable == nil)
    {
        self.titLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
        //self.titLable.backgroundColor = [UIColor yellowColor];
        self.titLable.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        self.titLable.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_titLable];
    }
    return _titLable;
}


-(UILabel *)showLab
{
    if (_showLab == nil)
    {
        self.showLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 80, 10, 40, 20)];
        self.showLab.textAlignment = NSTextAlignmentRight;
        self.showLab.font = [UIFont systemFontOfSize:16];
        self.showLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        [self.contentView addSubview:_showLab];
    }
    return _showLab;
}



-(UIImageView *)titleImage
{
    if (_titleImage == nil)
    {
        self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.showLab.frame) + 10, 10, 10, 20)];
        //self.titleImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_titleImage];
        
    }
    return _titleImage;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
