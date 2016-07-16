//
//  NotifyModel.h
//  乐影
//
//  Created by LiuChenhao on 16/6/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotifyModel : NSObject
/*
{
    "code": 0,
    "message": "成功",
    "data": [
             {
                 "id": "1",
                 "coverImgUrl": "http://o7rqw6rro.bkt.clouddn.com/1465798747444233354.jpg",
                 "title": "测试通告",
                 "startTime": "1465881118",
                 "city": "杭州",
                 "reward": "1111",
                 "rewardUnit": "小时",
                 "male": "2",
                 "female": "3",
                 "viewTime": "2255"
             }
             ]
}
*/
@property (nonatomic,strong)NSString *ID;//活动id
@property (nonatomic,strong)NSString *coverImgUrl;//活动图片
@property (nonatomic,strong)NSString *title;//活动标题
@property (nonatomic,strong)NSString *startTime;//活动开始时间
@property (nonatomic,strong)NSString *city;//活动城市
@property (nonatomic,strong)NSString *reward;//活动报酬
@property (nonatomic,strong)NSString *rewardUnit;//报酬类型
@property (nonatomic,strong)NSString *male;//活动所需男
@property (nonatomic,strong)NSString *female;//活动所需女
@property (nonatomic,strong)NSString *viewTime;//活动被点击量


@end
