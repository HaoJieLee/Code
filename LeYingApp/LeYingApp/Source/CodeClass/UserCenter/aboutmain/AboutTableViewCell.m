//
//  AboutTableViewCell.m
//  About软件
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 WHM. All rights reserved.
//

#import "AboutTableViewCell.h"

@implementation AboutTableViewCell

-(UILabel *)titlable
{
    if (_titlable == nil) {
        self.titlable = [[UILabel alloc]init];
        self.titlable.frame = CGRectMake(10, 10, 100, 30);
        [self.contentView addSubview:_titlable];
      //  self.titlable.backgroundColor = [UIColor redColor];
        self.titlable.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0];
        self.titlable.textColor = [UIColor grayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _titlable;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
