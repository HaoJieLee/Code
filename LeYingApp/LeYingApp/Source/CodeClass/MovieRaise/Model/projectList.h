//
//  projectList.h
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface projectList : NSObject

@property (nonatomic,assign)NSInteger status;
//@property (nonatomic,assign)NSInteger Id;
@property (nonatomic,assign)NSInteger is_recommend;
@property (nonatomic,assign)NSInteger category_id;
@property (nonatomic,assign)NSInteger  current_money;
@property (nonatomic,assign)NSInteger  total_money;
@property (nonatomic,assign)NSInteger support_times;



@property (nonatomic,copy)NSString *updated_time;

@property (nonatomic,copy)NSString *cover_image;
@property (nonatomic,copy)NSString *deadline_time;
@property (nonatomic,copy)NSString *created_time;




//项目详情key

@property (nonatomic,copy)NSString  *Id;//项目ID
@property (nonatomic,copy)NSString *title;//项目标题
@property (nonatomic,copy)NSString *coverImgUrl;//项目首图
@property (nonatomic,copy)NSString *summary;//项目简介
@property (nonatomic,copy)NSString *limitDate;//项目结束时间
@property (nonatomic,copy)NSString *viewTime;//项目点击量
@property (nonatomic,copy)NSString *publishDate;//项目发布时间
@property (nonatomic,copy)NSString *Description;//项目描述

// 剧组照片
@property (nonatomic,copy)NSString *isFinished;//是否已经关注 0表示未关注，1表示已关注
@property (nonatomic,copy)NSString *isvideo;//是否有视频
@property (nonatomic,copy)NSString *videoid;//视频id
@property (nonatomic,strong)NSArray *photos;//剧组照片数组
@property (nonatomic,copy)NSString *isFavorite;//是否已收藏
@property (nonatomic,copy)NSDictionary *video;//剧组视频
@property (nonatomic,copy)NSArray *buy;//购买活动的数组

// 详情

//购买信息
@property (nonatomic,copy)NSString * buytype;
@property (nonatomic,copy)NSString *goodsnum;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *salegoodsnum;



//乐影项目信息
@property (nonatomic,copy)NSString *addtime;
@property (nonatomic,copy)NSString *clicknum;


@property (nonatomic,copy)NSString *endtime;
@property (nonatomic,copy)NSString *property;
@property(nonatomic,copy)NSArray *piclist;
@property (nonatomic,copy)NSString *saleprice;
//@property (nonatomic,copy)NSString *status;
//@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *titlepic;
@property (nonatomic,copy)NSString *top;
@property (nonatomic,copy)NSString *toptype;//1,视频，2 图片
@property (nonatomic,copy)NSString *videoload;
@property (nonatomic,copy)NSArray *videopics;








@end
