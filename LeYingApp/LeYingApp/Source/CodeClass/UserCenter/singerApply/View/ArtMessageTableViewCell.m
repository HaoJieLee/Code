//
//  ArtMessageTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtMessageTableViewCell.h"

@implementation ArtMessageTableViewCell

-(UIImageView *)starImage
{
    if (_starImage == nil)
    {
        self.starImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, (CGRectGetWidth(self.frame) - 60) /4 /2 + 5, 10, 10)];
        //self.titleImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_starImage];
        
    }
    return _starImage;
}


-(UIButton *)heightBtn
{
    if (_heightBtn == nil)
    {
        self.heightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.heightBtn.frame = CGRectMake(20, 10, (CGRectGetWidth(self.frame) - 60) /4, (CGRectGetWidth(self.frame) - 60) /4);
         [self.contentView addSubview:_heightBtn
          ];
        self.heightBtn.layer.cornerRadius = (CGRectGetWidth(self.frame) - 60) /4 / 2;
        self.heightBtn.layer.masksToBounds = YES;
        
    }
    return _heightBtn;
}


-(UIButton *)weightBtn
{
    if (_weightBtn == nil)
    {
        self.weightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.weightBtn.frame = CGRectMake(CGRectGetMaxX(self.heightBtn.frame) + 10, 10, (CGRectGetWidth(self.frame) - 60) /4, (CGRectGetWidth(self.frame) - 60) /4);
        [self.contentView addSubview:_weightBtn
         ];
        self.weightBtn.layer.cornerRadius = (CGRectGetWidth(self.frame) - 60) /4 / 2;
        self.weightBtn.layer.masksToBounds = YES;
        
    }
    return _weightBtn;
}


-(UIButton *)mensurationsBtn
{
    if (_mensurationsBtn == nil)
    {
        self.mensurationsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.mensurationsBtn.frame = CGRectMake(CGRectGetMaxX(self.weightBtn.frame) + 10, 10, (CGRectGetWidth(self.frame) - 60) /4, (CGRectGetWidth(self.frame) - 60) /4);
        [self.contentView addSubview:_mensurationsBtn
         ];
        self.mensurationsBtn.layer.cornerRadius = (CGRectGetWidth(self.frame) - 60) /4 / 2;
        self.mensurationsBtn.layer.masksToBounds = YES;
        
    }
    return _mensurationsBtn;
}



-(UIButton *)sizeBtn
{
    if (_sizeBtn == nil)
    {
        self.sizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.sizeBtn.frame = CGRectMake(CGRectGetMaxX(self.mensurationsBtn.frame) + 10, 10, (CGRectGetWidth(self.frame) - 60) /4, (CGRectGetWidth(self.frame) - 60) /4);
        [self.contentView addSubview:_sizeBtn
         ];
        self.sizeBtn.layer.cornerRadius = (CGRectGetWidth(self.frame) - 60) /4 / 2;
        self.sizeBtn.layer.masksToBounds = YES;
        
    }
    return _sizeBtn;
}


-(UILabel *)heightLab
{
    if (_heightLab == nil)
    {
        self.heightLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.heightBtn.frame) - CGRectGetWidth(self.heightBtn.frame)/2 - 25, CGRectGetMaxY(self.heightBtn.frame), 50, 20)];
        //self.heightLab .backgroundColor = [UIColor redColor];
        self.heightLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        self.heightLab.font = [UIFont systemFontOfSize:15];
       // self.heightLab.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_heightLab];
        
    }
    return _heightLab;
}


-(UILabel *)weightLab
{
    if (_weightLab == nil)
    {
        self.weightLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.weightBtn.frame) -  CGRectGetWidth(self.heightBtn.frame)/2 - 20, CGRectGetMaxY(self.heightBtn.frame), 40, 20)];
        self.weightLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        self.weightLab.font = [UIFont systemFontOfSize:15];
       // self.weightLab.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_weightLab];
        
    }
    return _weightLab;
}

-(UILabel *)mensurationLab
{
    if (_mensurationLab == nil)
    {
        self.mensurationLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.mensurationsBtn.frame) -  CGRectGetWidth(self.heightBtn.frame)/2 - 40, CGRectGetMaxY(self.heightBtn.frame), 80, 20)];
        self.mensurationLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        self.mensurationLab.textAlignment = NSTextAlignmentCenter;
        self.mensurationLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_mensurationLab];
        
    }
    return _mensurationLab;
}


-(UILabel *)sizeLab
{
    if (_sizeLab == nil)
    {
        self.sizeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sizeBtn.frame) -  CGRectGetWidth(self.heightBtn.frame)/2 - 20, CGRectGetMaxY(self.heightBtn.frame), 40, 20)];
        self.sizeLab.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];;
        self.sizeLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_sizeLab];
        
    }
    return _sizeLab;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
