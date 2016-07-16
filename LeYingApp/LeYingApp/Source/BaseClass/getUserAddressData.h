//
//  getUserAddressData.h
//  LeYingApp
//
//  Created by sks on 15/12/24.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^GetAddressValue)(NSArray *addressArr);

typedef void(^GetDefaultAddressValue)(NSArray *defaultArr);

@interface getUserAddressData : NSObject

@property (nonatomic,strong)NSMutableArray *allAddressArr;
@property (nonatomic,strong)NSMutableArray *defaultAddressArr;

+(instancetype)shareDataAddress;


//增加用户地址
-(void)addUserAddressWithReceieveMan:(NSString *)receiveman Phone:(NSString *)phone Address:(NSString *)address Withtoken:(NSString *)userToken;

//获取所有用户地址
-(void)getAlladdressWithToken:(NSString *)userToken WithAddressValue:(GetAddressValue)addressValue;

//获取默认用户地址
-(void)getDefaultAddressWithToken:(NSString *)userToken WithAddressValue:(GetDefaultAddressValue)defaultAddressValue;

//删除用户地址
-(void)deleteAddressWithId:(NSString *)addressId withToken:(NSString *)mytoken;


//修改用户地址
-(void)editUserAddressWithReceieveMan:(NSString *)receiveman Phone:(NSString *)phone Address:(NSString *)address AddressId:(NSString *)addressid Withtoken:(NSString *)userToken;









@end
