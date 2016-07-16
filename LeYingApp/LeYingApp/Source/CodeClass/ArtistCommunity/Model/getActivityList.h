//
//  getActivityList.h
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getActivityList : NSObject

//活动列表内容

@property (nonatomic,strong)NSString *city;//活动城市

@property (nonatomic,strong)NSString *category;//活动类型
@property (nonatomic,strong)NSString *endTime;//结束时间



//通告详情
@property (nonatomic,strong)NSString *address;//详细地址
@property (nonatomic,strong)NSString *publishTime;//发布时间
@property (nonatomic,strong)NSString *reward;//报酬
@property (nonatomic,strong)NSString *rewardUnit;//报酬结算方式
@property (nonatomic,strong)NSString *male;//活动需要男生
@property (nonatomic,strong)NSString *female;//报酬需要的女生
@property (nonatomic,strong)NSString *Id;
@property (nonatomic,strong)NSString *DDescription;//活动描述
@property (nonatomic,strong)NSString *contact;//联系方式
@property (nonatomic,strong)NSArray *photos;//活动图片数组
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *title;//通知标题
@property (nonatomic,strong)NSString *titlepic;
@property (nonatomic,strong)NSString *top;
@property (nonatomic,strong)NSString *startTime;//开始时间
@property (nonatomic,strong)NSString *coverImgUrl;//通告图片

@property (nonatomic,strong)NSString *userId;//发布人ID
@property (nonatomic,strong)NSString *userAvatar;//用户头像
@property (nonatomic,strong)NSString *userName;//用户昵称
@property (nonatomic,strong)NSString *userIdentity;//用户职业
@property (nonatomic,strong)NSString *userAuthentication;//用户是否已经认证
@property (nonatomic,strong)NSString *userAuthenticationInfo;//用户认证扫描资料
@property (nonatomic)int isFavorite;//是否已经关注该用户

/**
 "viewTime": "2264",
 "userId": "9",
 "userAvatar": "",
 "userName": "",
 "userIdentity": "",
 "userAuthentication": "",
 "userAuthenticationInfo": "",
 "isFavorite": 0

*/



//艺人详情
@property (nonatomic,strong)NSString *avatar;//艺人头像图片
@property (nonatomic,strong)NSString *nicename;//艺名
@property (nonatomic,strong)NSString *gender;//性别
@property (nonatomic,strong)NSString *authentication;//是否已经认证
@property (nonatomic,strong)NSString *viewTime;//关注人数



@end
