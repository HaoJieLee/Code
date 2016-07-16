//
//  BuyMyselfTableViewCell.h
//  乐影
//
//  Created by zhaoHm on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

@interface BuyMyselfTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *imgShows;
@property (nonatomic,strong) UILabel *lblDetails;
@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) UILabel *lblState;
@property (nonatomic,strong) UILabel *lblStateContent;
@property (nonatomic,strong) UILabel *lblAdministrator;
@property (nonatomic,strong) UILabel *lblAdministratorContent;



@property (nonatomic,strong) TestModel *model;


+(CGFloat)heightForCell;

//@property (nonatomic,assign) CGSize newSize;

@end
