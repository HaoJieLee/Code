//
//  ArtPublicTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtPublicTableViewCell.h"

@implementation ArtPublicTableViewCell


-(UILabel *)publicLab
{
    if (_publicLab == nil)
    {
        self.publicLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, 50)];
        self.publicLab.backgroundColor = [UIColor colorWithRed:116/255.0f green:126/255.0f blue:124/255.0f alpha:1.0];
        self.publicLab.textColor = [UIColor whiteColor];
        self.publicLab.font = [UIFont systemFontOfSize:13];
        self.publicLab.numberOfLines = 0;
        [self.contentView addSubview:_publicLab];
    }
    return _publicLab;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
