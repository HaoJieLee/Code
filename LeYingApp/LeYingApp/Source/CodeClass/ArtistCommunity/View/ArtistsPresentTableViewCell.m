//
//  ArtistsPresentTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtistsPresentTableViewCell.h"

@implementation ArtistsPresentTableViewCell




-(UILabel *)titLab
{
    if (_titLab == nil)
    {
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(20 , 10, (CGRectGetWidth(self.frame) - 20)/2, 20)];
        self.titLab .font = [UIFont systemFontOfSize:15];
        self.titLab.textColor = [UIColor colorWithRed:48/255.0f green:50/255.0f blue:51/255.0f alpha:1.0];
        self.titLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titLab];
    }
    return _titLab ;
}
-(UILabel *)titShowLab
{
    if (_titShowLab == nil)
    {
        self.titShowLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2 , 10, (CGRectGetWidth(self.frame) - 40)/2, 20)];
        self.titShowLab.font = [UIFont systemFontOfSize:15];
        self.titShowLab.textAlignment = NSTextAlignmentRight;
        self.titShowLab.textColor =  [UIColor colorWithRed:48/255.0f green:50/255.0f blue:51/255.0f alpha:1.0];
        [self.contentView addSubview:_titShowLab];
    }
    return _titShowLab ;
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
