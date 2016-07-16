//
//  loginModel.h
//  乐影
//
//  Created by LiuChenhao on 16/7/3.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface loginModel : NSObject
/**
 "accessKey": "0149cbda41126b910ec6e6328db08ff3",
 "secretKey": "3c848bf70a07c156d2916b810b7e16ac",
 "token": "f37e1e9a282c7e88871938b9536a9607",
 "rongCloudToken": "",
 "userId": "30",
 "username": "13675883582",
 "nicename": "",
 "avatar": "",
 "gender": "",
 "authentication": "false",
 "authenticationInfo": "",
 "identity": "",
 "category": "",
 "subCategory": "",
 "tag": "",
 "coin": ""
 */
@property (nonatomic,copy)NSString *accessKey;//访问所用到的Key
@property (nonatomic,copy)NSString *secretKey;//登录安全码, 用于请求数据的加密.
@property (nonatomic,copy)NSString *token;//用于wap网页访问实现登录.
@property (nonatomic,copy)NSString *rongCloudToken;//融云聊天 Token
@property (nonatomic,copy)NSString *userId;//用户 ID
@property (nonatomic,copy)NSString *username;//用户名(登录的名称)
@property (nonatomic,copy)NSString *nicename;//昵称(艺名)
@property (nonatomic,copy)NSString *authentication;//是否已经验证false未验证
@property (nonatomic,copy)NSString *avatar;//用户头像URL
@property (nonatomic,copy)NSString *gender;//1男，2女，3未定义
@property (nonatomic,copy)NSString *identity;//用户身份.如演员等.如果未验证,
@property (nonatomic,copy)NSString *category;//类型. 如:模特, 演员. 可以有多个类型. 用 "|" 符号间隔
@property (nonatomic,copy)NSString *subCategory;//子类型. 如: 走秀.平面. 同样用 "|" 符号间隔
@property (nonatomic,copy)NSString *tag;//标签. 如:时尚, 性感. 可以有多个标签. 用"|"符号隔开.
@property (nonatomic,copy)NSString *coin;
@property (nonatomic,copy)NSString *authenticationInfo;//认证资料 述. 后台要另外保存 交的 身份认证信息.


/**登录的单例*/

+(loginModel*)grobleLoginModel;
@end
