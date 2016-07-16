//
//  OrderMessageToServer.h
//  乐影
//
//  Created by zhaoHm on 16/3/26.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMessageToServer : NSObject

/// 活动id
@property (nonatomic,strong) NSString *buyactivitieid;
/// 身份证
@property (nonatomic,strong) NSString *cardno;
/// 收件人
@property (nonatomic,strong) NSString *username;
/// 收件人电话
@property (nonatomic,strong) NSString *tel;
/// 收件人地址
@property (nonatomic,strong) NSString *address;
/// 商品数量
@property (nonatomic,strong) NSString *goodsnum;
/// 给卖家留言
@property (nonatomic,strong) NSString *tomaijiamessage;

@end
