//
//  MineLeYingTableViewCell.m
//  乐影
//
//  Created by zhaoHm on 16/3/16.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MineLeYingTableViewCell.h"

@implementation MineLeYingTableViewCell

-(UIImageView *)imgShows
{
    if (_imgShows == nil) {
        self.imgShows = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), 200)];
        [self.contentView addSubview:_imgShows];
    }
    return _imgShows;
}

-(UILabel *)lblTitle
{
    if (_lblTitle == nil) {
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imgShows.frame) + 10, CGRectGetMaxY(self.imgShows.frame), CGRectGetWidth(self.imgShows.frame) - 20 - 20, 30)];
        [self.contentView addSubview:_lblTitle];
        self.lblTitle.font = [UIFont systemFontOfSize:14];
        self.lblTitle.textColor = [UIColor colorWithRed:138/255.0f green:140/255.0f blue:140/255.0f alpha:1.0];
    }
    return _lblTitle;
}

-(UIButton *)imgDelete
{
    if (_imgDelete == nil) {
        self.imgDelete = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.imgShows.frame) - 10 - 20, CGRectGetMinY(self.lblTitle.frame) + 5, 18, 17)];
       // self.imgDelete.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imgDelete];
    }
    return _imgDelete;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
