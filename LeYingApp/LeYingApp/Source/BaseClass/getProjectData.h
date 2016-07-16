//
//  getProjectData.h
//  LeYingApp
//
//  Created by sks on 15/12/23.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PassValue)(NSArray *array);
typedef void (^PayBackValue)(NSArray *array1);
typedef void (^PassValue2)(NSArray *array4);
typedef void (^ColleValue)(NSArray *array2);
typedef void (^GetColleValue)(NSArray *array3);


typedef void (^PassValue7)(NSArray *array7);
typedef void (^PassValueComplete)(NSArray *array6);
typedef void (^PassValuebuyDic)(NSDictionary *buyDic);
typedef void (^PassValueDic)(NSDictionary *detailDic);


//测试
typedef void (^PassValue7)(NSArray *array);

@interface getProjectData : NSObject

@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)NSMutableArray *arr1;
@property (nonatomic,strong)NSMutableArray *arr2;
@property (nonatomic,strong)NSMutableArray *arr3;
@property (nonatomic,strong)NSMutableArray *arr7;
@property (nonatomic,strong)NSMutableArray *arr6;

@property (nonatomic,strong)NSDictionary *buyDic;
+(instancetype)shareProjectData;


/**获取城市信息*/
- (NSMutableArray*)getCitys;
//获取项目列表
-(void)getDataListWithPage:(NSString *)page getPagesize:(NSString *)pagesize getRecommend:(NSString *)recommend getStatus:(NSString *)status getOrder:(NSString *)order passValue:(PassValue)Value;

-(void)getHavenDataListWithPage:(NSString *)page getPagesize:(NSString *)pagesize getRecommend:(NSString *)recommend getStatus:(NSString *)status getOrder:(NSString *)order passValue:(PassValue2)Value;



// 获取项目回报方法
-(void)getPayBackMeassageWithProjectID:(NSString *)projectID PaybackValue:(PayBackValue)BackValue;





//收藏项目
-(void)getCollectProject:(NSString *)projectId getToken:(NSString *)token;

// 删除收藏

-(void)deleteCollectProject:(NSString *)projectId getToken:(NSString *)token;

//获取收藏项目信息
-(void)getCollectWithToken:(NSString *)Token getCollectValue:(GetColleValue)GetValue;


//新版本

//获取项目列表
-(void)getDataListWithPage:(NSString *)page  passValue:(PassValue7)Value;

//项目浏览量
-(void)addClickwithID:(NSString *)projectId;

//通告点击量

-(void)tonggaoaddClickwithID:(NSString *)projectId;

/**项目详情*/
-(void)getDataListWithId:(NSString *)projectId  passValue:(PassValueDic)Value;

//购买活动详情
-(void)getBuyDetailWithId:(NSString *)projectId passValue:(PassValuebuyDic)Value;


/**已完成项目*/
-(NSArray*)getCompleteWithPageNo:(int)pageNo  AddPageSize:(int)pageSize Type:(NSString*)type;


//已经完成项目浏览量
-(void)completeClickwithID:(NSString *)projectId;

@end
