//
//  ResetTableViewCell.m
//  News
//
//  Created by Xcord-LS on 15/10/27.
//  Copyright (c) 2015年 李帅,赵良育,吴豪明. All rights reserved.
//

#import "ResetTableViewCell.h"

@implementation ResetTableViewCell

-(UILabel *)cacheLable
{
    if (_cacheLable == nil)
    {
        self.cacheLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.frame), 0, 80, 60)];
        
        self.cacheLable.textColor = [UIColor colorWithRed:126/255.0f green:126/255.0f blue:126/255.0f alpha:1.0];
        [self.contentView addSubview:_cacheLable];
    }
    return _cacheLable;
}



-(UILabel *)showLab
{
    if (_showLab == nil)
    {
        self.showLab = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW - 160, 8, 125, 20)];
        self.showLab.textAlignment = NSTextAlignmentRight;
       // self.showLab.backgroundColor = [UIColor redColor];
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
        self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.showLab.frame) + 10, 12.5, 7, 14)];
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
