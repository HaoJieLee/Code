//
//  payBackModel.h
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface payBackModel : NSObject

@property (nonatomic,strong)NSString *payback_after_days;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger delivery_mode;
@property (nonatomic,assign)NSInteger limit;
@property (nonatomic,assign)NSInteger money;
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)NSInteger project_id;



@property (nonatomic,strong)NSString *cover_image_thumbnail;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *detail;
@property (nonatomic,strong)NSString *updated_time;
@property (nonatomic,strong)NSString *cover_image;
@property (nonatomic,strong)NSString *created_time;




@end
