//
//  DataTableViewCell.m
//  LeYingApp
//
//  Created by sks on 16/1/13.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "DataTableViewCell.h"

@implementation DataTableViewCell



-(UILabel*)dataLabel
{
    if (_dataLabel == nil)
    {
        self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        [self.contentView addSubview:_dataLabel];
    }
    return _dataLabel;
}

-(UILabel*)dataShowLabel
{
    if (_dataShowLabel == nil)
    {
        self.dataShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -160 , 10, 150, 30)];
        self.dataShowLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_dataShowLabel];
    }
    return _dataShowLabel;
}









- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
