//
//  getAboutArtistData.h
//  LeYingApp
//
//  Created by sks on 15/12/23.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetArtistValue)(NSDictionary *detailDic,NSString *mypage);

typedef void(^GetArtistExpand)(NSArray *artistExpandArr);

typedef void(^GetArtivity)(NSDictionary *activityListDic);

typedef void(^GetRecommend)(NSArray *Recommend);

typedef void(^GetArtistCategory)(NSDictionary *CategoryDic);

typedef void(^GetArtistPromote)(NSArray *artistPromote);

typedef void(^GetNotifyList)(NSMutableArray *notify);
typedef void(^GetCategory)(NSMutableArray *categoryArray);

@interface getAboutArtistData : NSObject

@property (nonatomic,strong)NSMutableArray *artistArr;
@property (nonatomic,strong)NSMutableArray *activityArr;
@property (nonatomic,strong)NSMutableArray *recommendArr;
@property (nonatomic,strong)NSDictionary *categoryDic;
@property (nonatomic,strong)NSDictionary *activityDic;
@property (nonatomic,strong)NSDictionary *detailDic;
@property (nonatomic,strong)NSMutableArray *myarr;

@property (nonatomic,strong)NSMutableArray *notifyArray;
@property (nonatomic,strong)NSMutableArray *categoryArr;


@property (nonatomic,strong)NSMutableArray *promoteArr;

+(instancetype)shareArtistData;
//搜索艺人


/**搜索获取艺人列表*/
-(NSMutableArray*)SearchExpandWithType:(NSString *)location WithCategoryid:(NSString*)woid gender:(int)gender Category:(NSString*)category Sort:(int)sort PageNo:(int)pageno PageSize:(int)pagesize;

//获取艺人列表
-(void)getCategoryExpandWithType:(NSString *)pageno WithCategoryid:(NSString*)pagesize gender:(NSString*)gender Category:(NSString*)category Expand:(GetCategory)expand;

//获取通告列表
-(void)getNotifyExpandWithType:(int )pageno WithCategoryid:(int)pagesize City:(NSString *)city Category:(NSString*)category Expand:(GetNotifyList)ExpandValue;
//判断是否能够成为艺术家

-(BOOL)judgeAboutArtist:(NSString *)myToken;



////////////////////////////////////////////// 新版本
//获取艺人板块的推广海报  轮播图
-(void)getArtistExpandWithType:(NSString *)actlunboType WithCategoryid:(NSString *)categoryid Expand:(GetArtistExpand)ExpandValue;



//通告详情
-(void)getActivityListWithId:(NSString *)activityId Artivity:(GetArtivity)activityValue;

//获取演员分类   // 分类
-(void)getArtistCategory:(GetArtistCategory)categoryValue;


//获取全部艺术家
-(void)getArtistsWithPage:(NSString *)page getId:(NSString *)artistId ArtistValue:(GetArtistValue)ArtistValue;


//
// 获取全部艺术家 包括男女
-(void)getArtistsWithPage:(NSString *)page getId:(NSString *)artistId getManorWoman:(NSString*)sex ArtistValue:(GetArtistValue)ArtistValue;


//单个艺人详情

-(void)getRecommendWithId:(NSString *)artistId Recommend:(GetRecommend)recommendValue;

//项目收藏
-(BOOL)leyingCollectWithId:(NSString *)projectId;


//艺人收藏
-(BOOL)artistCollectWithId:(NSString *)artistId;
//艺人点击量
-(void)artAddclick:(NSString *)myId;

-(void)getArtcollectWithpage:(NSString *)myPage Type:(NSString *)mytype;


@end
