//
//  SearchModel.h
//  乐影
//
//  Created by LiuChenhao on 16/7/1.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
/**
 "data": [
 {
 "id": "19",
 "avatar": "http://o7rqw6rro.bkt.clouddn.com/Fv__1SKuRvD1nX8Mr_n4HMcm_G7R",
 "nicename": "李呈媛",
 "gender": "2",
 "authentication": "0",
 "viewTime": "56"
 }
 ]
 */
@property (nonatomic,copy)NSString *ID;//艺人id
@property (nonatomic,copy)NSString *avatar;//艺人头像
@property (nonatomic,copy)NSString *nicename;//艺人昵称
@property (nonatomic)int gender;//艺人性别
@property (nonatomic,copy)NSString *authentication;//艺人是否已经认证

@end
