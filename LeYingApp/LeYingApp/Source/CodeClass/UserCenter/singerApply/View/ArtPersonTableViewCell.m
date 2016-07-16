//
//  ArtPersonTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtPersonTableViewCell.h"

@implementation ArtPersonTableViewCell


-(UILabel *)specificLab
{
    if (_specificLab == nil)
    {
        self.specificLab = [[UILabel alloc]initWithFrame:CGRectMake(20,10,80,20)];
        self.specificLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        self.specificLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_specificLab];
        
    }
    return _specificLab;
}


-(UITextView *)specificText
{
    if (_specificText == nil)
    {
        self.specificText = [[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.specificLab.frame), CGRectGetWidth(self.frame) - 40, 30)];
        self.specificText.textColor = [UIColor whiteColor];
       [self.contentView addSubview:_specificText];
        
    }
    return _specificText;
}





-(UILabel *)lifeLab
{
    if (_lifeLab == nil)
    {
        self.lifeLab = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.specificText.frame) + 5,80,20)];
        self.lifeLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        self.lifeLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lifeLab];
        
    }
    return _lifeLab;
}



-(UITextView *)lifeText
{
    if (_lifeText == nil)
    {
        self.lifeText = [[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.lifeLab.frame) + 5, CGRectGetWidth(self.frame) - 40, 90)];
        self.lifeText.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_lifeText];
        
    }
    return _lifeText;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
