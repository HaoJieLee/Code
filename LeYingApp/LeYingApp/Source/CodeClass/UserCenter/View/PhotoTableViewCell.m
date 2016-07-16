//
//  PhotoTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell



-(UIImageView *)photoImage1
{
    if (_photoImage1 == nil)
    {
        self.photoImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 75, 75)];
        
        self.photoImage1.layer.cornerRadius = 37.5;
        self.photoImage1.backgroundColor = [UIColor whiteColor];
        self.photoImage1.layer.masksToBounds = YES;
        
        
        [self.contentView addSubview:_photoImage1];
        
    }
    return _photoImage1;
}


-(UIImageView *)photoImage
{
    if (_photoImage == nil)
    {
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 2.5, 70, 70)];
        
        self.photoImage.layer.cornerRadius = 35;
        self.photoImage.layer.masksToBounds = YES;
        

        [self.photoImage1 addSubview:_photoImage];
        
    }
    return _photoImage;
}





-(UILabel *)showLab
{
    if (_showLab == nil)
    {
        self.showLab = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW - 160, 25, 125, 30)];
        self.showLab.textAlignment = NSTextAlignmentRight;
        self.showLab.font = [UIFont systemFontOfSize:15];
        self.showLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        // self.showLab.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_showLab];
    }
    return _showLab;
}



-(UIImageView *)titleImage
{
    if (_titleImage == nil)
    {
        self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.showLab.frame) + 10, 32.5, 7, 14)];
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
