//
//  expandModel.h
//  LeYingApp
//
//  Created by sks on 15/12/23.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface expandModel : NSObject

//@property (nonatomic,copy)NSString *imageUrl;
@property (nonatomic,copy)NSString *Description;
@property (nonatomic,copy)NSString *updated_time;
@property (nonatomic,copy)NSString *link;
@property (nonatomic,strong)NSString *created_time;
@property (nonatomic,assign)NSInteger post_type;
@property (nonatomic,strong)NSString *artist_profile_id;





#pragma mark 艺人轮播
//@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *Id;
@property (nonatomic,strong)NSString *imageUrl;
//@property (nonatomic,strong)NSString *sort;
//@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *title;
//@property (nonatomic,strong)NSString *y_id;
@property (nonatomic,strong)NSString *bannerType;
@property (nonatomic,strong)NSString *actionInfo;







@end
