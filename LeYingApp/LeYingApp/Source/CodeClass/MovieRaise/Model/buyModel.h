//
//  buyModel.h
//  乐影
//
//  Created by LiuChenhao on 16/7/2.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface buyModel : NSObject
/**
 
 [
 {
 "buyId": "2",
 "buytype": "1",
 "imgUrl": "http://o7rqw6rro.bkt.clouddn.com/1467370257380485549.jpg",
 "title": "钟汉良签名照啦",
 "description": "十月围城》能够与众多优质电视剧一起进入“中国梦”题材电视剧行列，是因为都有着饱满的艺术构思和精良的制作水准",
 "price": "123.00",
 "remain": "11",
 "limitDate": "1467388800"
 },
 */
@property (nonatomic,copy)NSString *buyId;//购买活动的id
@property (nonatomic,copy)NSString *buytype;//购买活动的类型 1：实物，2：虚拟物品，3：广告
@property (nonatomic,copy)NSString *imgUrl;//购买活动的图片接口
@property (nonatomic,copy)NSString *title;//购买活动的标题
@property (nonatomic,copy)NSString *price;//购买活动的价格
@property (nonatomic,copy)NSString *remain;//购买活动的剩余量
@property (nonatomic,copy)NSString *Description;//购买活动的商品描述
@property (nonatomic,copy)NSString *limitDate;//购买活动的截止时间


@end
