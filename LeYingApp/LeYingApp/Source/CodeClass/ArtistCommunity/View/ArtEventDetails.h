//
//  ArtEventDetails.h
//  乐影
//
//  Created by zhaoHm on 16/3/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

typedef void (^ReturnTextBlock)(NSString* state);//声明block

typedef void (^ReturnUserInformation)();//声明block
@interface ArtEventDetails : UIScrollView

@property (nonatomic,copy) ReturnTextBlock block;//d定义block对象
//方法触发block
@property (nonatomic,copy)ReturnUserInformation userBlock;//进入用户信息
@property (nonatomic,strong) NSMutableArray *photoArray;//活动照片数组


// 轮播图
@property (nonatomic,strong) SDCycleScrollView *firstImageView;

// 下部分
@property (nonatomic,strong) UIView *bottomView;

//
@property (nonatomic,strong) UILabel *lblTitle;
// 分享图标
@property (nonatomic,strong) UIImageView *imgShare;
@property (nonatomic,strong) UIImageView *imgCollection;
@property (nonatomic,strong) UIView *lineView;

//// 活动时间
@property (nonatomic,strong) UIImageView *imgTime;
@property (nonatomic,strong) UILabel *lblTime;

// 地址
@property (nonatomic,strong) UIImageView * imgLocation;
@property (nonatomic,strong) UILabel *lblLocation;

// 模特详情
@property (nonatomic,strong) UIImageView *imgModol;
@property (nonatomic,strong) UILabel *lblModol;
@property (nonatomic,strong) UILabel *lblPrice;

// 点击数量
@property (nonatomic,strong) UIImageView *imgClick;
@property (nonatomic,strong) UILabel *lblClick;

// 详情
@property (nonatomic,strong) UIImageView *imgDetails;
@property (nonatomic,strong) UITextView *lblDetails;

@property (nonatomic,strong) UILabel *notifyTime;//发布时间

@property (nonatomic,strong) UIButton *phoneButton;//打电话

@property (nonatomic,strong) UILabel *phoneNum;//联系方式


@property (nonatomic,strong) UILabel *userNameLabel;//发布人姓名
@property (nonatomic,strong) UILabel *userWorkLabel;//发布人职业
@property (nonatomic,strong) UIImageView *userHeadImage;//发布人头像
@property (nonatomic) int isFavorite;//是否已经收藏

@property (nonatomic,copy) NSString *userid;//发布人头像

@property (nonatomic,copy)NSString *userAuthentication;//用户是否已经认证
- (instancetype)initWithFrame:(CGRect)frame AddPhotoArray:(NSArray*)photos UserAuthentication:(NSString*)userAuthentication IisFavorite:(int)isFavorite UserId:(NSString*)userId;

@end
