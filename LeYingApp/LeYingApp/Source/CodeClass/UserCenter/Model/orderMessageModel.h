//
//  orderMessageModel.h
//  LeYingApp
//
//  Created by sks on 15/12/30.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderMessageModel : NSObject

//publisher
@property (nonatomic,strong)NSString *name;


//payback
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *detail;
@property (nonatomic,assign)NSInteger amount;

@property (nonatomic,strong)NSString *cover_image;




//外层字典
@property (nonatomic,assign)NSInteger delivery_money;
@property (nonatomic,assign)NSInteger total_money;
@property (nonatomic,strong)NSDictionary *payback;
@property (nonatomic,strong)NSDictionary *publisher;
@property (nonatomic,assign)NSInteger status;


@end
