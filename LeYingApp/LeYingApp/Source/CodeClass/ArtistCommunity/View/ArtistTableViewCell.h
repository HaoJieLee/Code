//
//  ArtistTableViewCell.h
//  LeYingApp
//
//  Created by sks on 15/12/11.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistTableViewCell : UITableViewCell


@property (nonatomic,strong)UIImageView  *artImage;
@property (nonatomic,strong)UILabel *titleLable;

// 活动时间
@property (nonatomic,strong) UIImageView *imgTime;
@property (nonatomic,strong) UILabel *lblTime;

// 地址
@property (nonatomic,strong) UIImageView * imgLocation;
@property (nonatomic,strong) UILabel *lblLocation;

// 模特详情
@property (nonatomic,strong) UIImageView *imgModol;
@property (nonatomic,strong) UILabel *lblModol;

// 点击数量
@property (nonatomic,strong) UIImageView *imgClick;
@property (nonatomic,strong) UILabel *lblClick;

// 活动详情
@property (nonatomic,strong) UIButton *btnEventDetails;





@end
