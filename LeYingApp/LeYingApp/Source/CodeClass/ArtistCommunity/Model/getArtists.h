//
//  getArtists.h
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getArtists : NSObject

@property (nonatomic,assign)NSInteger user_id;
@property (nonatomic,assign)NSInteger weight;

@property (nonatomic,assign)NSInteger project_id;



@property (nonatomic,strong)NSString *Description;
@property (nonatomic,strong)NSString *nick_name;
@property (nonatomic,strong)NSString *photo;
@property (nonatomic,strong)NSArray *photos;
@property (nonatomic,strong)NSString *popularity;
@property (nonatomic,strong)NSString *real_name;
@property (nonatomic,strong)NSString *is_checked;
@property (nonatomic,strong)NSString *blood;
@property (nonatomic,strong)NSString *created_time;
@property (nonatomic,assign)NSInteger height;
@property (nonatomic,strong)NSString *sina;
@property (nonatomic,strong)NSString *qq;
@property (nonatomic,strong)NSString *wexin;
@property (nonatomic,strong)NSArray *works;



///////////////////////////////////////////////
//分类
@property (nonatomic,strong)NSString *addtime;
@property (nonatomic)NSNumber *Id;
@property (nonatomic,strong)NSString *sort;
@property (nonatomic)NSNumber *yuanid;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *img;


@property (nonatomic,strong)NSString *type;







// 演员列表


@property (nonatomic,strong)NSString *display_order;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *updated_time;






@end
