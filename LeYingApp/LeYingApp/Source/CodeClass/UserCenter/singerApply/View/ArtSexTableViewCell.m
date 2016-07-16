//
//  ArtSexTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtSexTableViewCell.h"

@implementation ArtSexTableViewCell

-(UIImageView *)starImage
{
    if (_starImage == nil)
    {
        self.starImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 10, 10)];
        //self.titleImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_starImage];
        
    }
    return _starImage;
}





-(UILabel *)titLable
{
    if (_titLable == nil)
    {
        self.titLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 40, 30)];
        //self.titLable.backgroundColor = [UIColor yellowColor];
        self.titLable.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        self.titLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titLable];
    }
    return _titLable;
}



-(UILabel *)remindLab
{
    if (_remindLab == nil)
    {
        self.remindLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titLable.frame), 10, CGRectGetWidth(self.frame) -135,30)];
         self.remindLab.font = [UIFont systemFontOfSize:14];
        self.remindLab.textColor  = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        [self.contentView addSubview:_remindLab];
    }
    return _remindLab;
}

-(UILabel *)showLab
{
    if (_showLab == nil)
    {
        self.showLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.remindLab.frame) + 20, 10, 30, 30)];
        self.showLab.textAlignment = NSTextAlignmentRight;
        self.showLab.font = [UIFont systemFontOfSize:14];
        //self.showLab.backgroundColor = [UIColor redColor];
        self.showLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        [self.contentView addSubview:_showLab];
    }
    return _showLab;
}



-(UIImageView *)titleImage
{
    if (_titleImage == nil)
    {
        self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.showLab.frame) + 5, 15, 10, 20)];
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
