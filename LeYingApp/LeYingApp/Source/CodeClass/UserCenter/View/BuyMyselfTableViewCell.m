//
//  BuyMyselfTableViewCell.m
//  乐影
//
//  Created by zhaoHm on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "BuyMyselfTableViewCell.h"
#import "NSString+ZHMNSStringExt.h"

@implementation BuyMyselfTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        @property (nonatomic,strong) UIImageView *imgShows;
        self.imgShows = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgShows];
//        @property (nonatomic,strong) UILabel *lblDetails;
        self.lblDetails = [[UILabel alloc] init];
        [self.contentView addSubview:_lblDetails];
//        @property (nonatomic,strong) UIView *myView;
        self.myView = [[UIView alloc] init];
        [self.contentView addSubview:_myView];
//        @property (nonatomic,strong) UILabel *lblState;
        self.lblState = [[UILabel alloc] init];
        [self.myView addSubview:_lblState];
//        @property (nonatomic,strong) UILabel *lblStateContent;
        self.lblStateContent = [[UILabel alloc] init];
        [self.myView addSubview:_lblStateContent];
//        @property (nonatomic,strong) UILabel *lblAdministrator;
        self.lblAdministrator = [[UILabel alloc] init];
        [self.myView addSubview:_lblAdministrator];
//        @property (nonatomic,strong) UILabel *lblAdministratorContent;
        self.lblAdministratorContent = [[UILabel alloc] init];
        [self.myView addSubview:_lblAdministratorContent];
    }
    return self;
}


-(void)setModel:(TestModel *)model
{
    _model = model;
    
    [self p_settingData];
    
    
    [self p_settingFrame];
}

/// 赋值
-(void)p_settingData
{
    self.imgShows.image = self.model.imgShows;
    self.lblDetails.text = self.model.details;
    self.lblStateContent.text = self.model.state;
    self.lblAdministrator.textColor = [UIColor colorWithRed:146/255.0f green:149/255.0f  blue:149/255.0f alpha:1.0];
    self.lblAdministratorContent.text = self.model.admin;
    self.lblAdministratorContent.textColor = [UIColor colorWithRed:146/255.0f green:149/255.0f  blue:149/255.0f alpha:1.0];
}

/// 设置frame
-(void)p_settingFrame
{
//    @property (nonatomic,strong) UIImageView *imgShows;
    self.imgShows.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 200);
//    @property (nonatomic,strong) UILabel *lblDetails;
    CGSize newSize = [NSString sizeWithText:self.model.details maxSize:CGSizeMake(CGRectGetWidth(self.imgShows.frame) - 20, 100000) font:[UIFont systemFontOfSize:14]];
    self.lblDetails.frame = CGRectMake(CGRectGetMinX(self.imgShows.frame) + 10, CGRectGetMaxY(self.imgShows.frame) + 10, newSize.width, newSize.height);
    self.lblDetails.backgroundColor = [UIColor clearColor];
    self.lblDetails.font = [UIFont systemFontOfSize:14];
    self.lblDetails.numberOfLines = 0;
//    @property (nonatomic,strong) UIView *myView;
    self.myView.frame = CGRectMake(CGRectGetMinX(self.lblDetails.frame), CGRectGetMaxY(self.lblDetails.frame) + 3, CGRectGetWidth(self.contentView.frame), 60);
//    @property (nonatomic,strong) UILabel *lblState;
    self.lblState.frame = CGRectMake(0, 0, 35, 25);
    self.lblState.font = [UIFont systemFontOfSize:14];
    self.lblState.backgroundColor = [UIColor clearColor];
    self.lblState.textColor = [UIColor colorWithRed:146/255.0f green:149/255.0f  blue:149/255.0f alpha:1.0];
//    @property (nonatomic,strong) UILabel *lblStateContent;
    self.lblStateContent.frame = CGRectMake(CGRectGetMaxX(self.lblState.frame) + 3, CGRectGetMinY(self.lblState.frame), CGRectGetWidth(self.myView.frame) - 10 - CGRectGetMaxX(self.lblState.frame), CGRectGetHeight(self.lblState.frame));
    self.lblStateContent.textColor = [UIColor colorWithRed:202/255.0 green:164/255.0 blue:4/255.0 alpha:1];
    self.lblStateContent.backgroundColor = [UIColor clearColor];
    self.lblStateContent.font = [UIFont systemFontOfSize:14];
//    @property (nonatomic,strong) UILabel *lblAdministrator;
    self.lblAdministrator.frame = CGRectMake(0, CGRectGetMaxY(self.lblState.frame) , 75, CGRectGetHeight(self.lblState.frame));
    self.lblAdministrator.font = [UIFont systemFontOfSize:14];
    self.lblAdministrator.backgroundColor = [UIColor clearColor];
//    @property (nonatomic,strong) UILabel *lblAdministratorContent;
    self.lblAdministratorContent.frame = CGRectMake(CGRectGetMaxX(self.lblAdministrator.frame) + 3, CGRectGetMinY(self.lblAdministrator.frame), CGRectGetMaxX(self.myView.frame) - CGRectGetMaxX(self.lblAdministrator.frame), CGRectGetHeight(self.lblAdministrator.frame));
    self.lblAdministratorContent.font = [UIFont systemFontOfSize:14];
    self.lblAdministratorContent.backgroundColor = [UIColor clearColor];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)heightForCell
{
    BuyMyselfTableViewCell *ceel = [[BuyMyselfTableViewCell alloc] init];
    CGFloat heightNew = ceel.imgShows.frame.size.height + ceel.myView.frame.size.height + ceel.lblDetails.frame.size.height + 20;
    
    return heightNew;
}

@end
