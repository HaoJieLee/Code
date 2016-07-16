//
//  getAboutOrder.h
//  LeYingApp
//
//  Created by sks on 15/12/29.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OrderValue)(NSArray *orderArr);

@interface getAboutOrder : NSObject

@property (nonatomic,strong)NSMutableArray *orderMessageArr;
@property (nonatomic,strong)NSMutableArray *orderPayBackArr;
@property (nonatomic,strong)NSMutableArray *orderPublisherArr;
+(instancetype)shareDataOrder;



-(void)getOrderWithPage:(NSString *)page Pagesize:(NSString *)pagesize Paybackid:(NSString *)payid Status:(NSString *)status ProjectId:(NSString *)projectid Token:(NSString *)token WithOrderValue:(OrderValue)orderValue;



-(void)submitOrderWithPaybackId:(NSInteger)paybackid Projectid:(NSInteger)projectid Amount:(NSInteger)amount DeliverMoney:(NSInteger)deivermoney AddressId:(NSInteger)addressid Token:(NSString *)token;













@end
