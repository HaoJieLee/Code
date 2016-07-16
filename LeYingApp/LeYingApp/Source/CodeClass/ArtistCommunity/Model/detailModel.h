//
//  detailModel.h
//  乐影
//
//  Created by LiuChenhao on 16/3/24.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detailModel : NSObject



@property (nonatomic)int isFavorite;//是否关注
@property (nonatomic,strong)NSString *location;//地址
@property (nonatomic,strong)NSString *subCategory;//职业
@property (nonatomic,strong)NSString *bwh;//三围
@property (nonatomic,strong)NSString *authenticationInfo;
@property (nonatomic,strong)NSString *authentication;
@property (nonatomic,strong)NSString *email;//邮箱
@property (nonatomic,strong)NSString *isEmailOpen;//是否邮箱
@property (nonatomic,strong)NSString *experience;
@property (nonatomic,strong)NSString *height;
@property (nonatomic,strong)NSString *Id;//id
//@property (nonatomic,strong)NSString *imworks;
@property (nonatomic,strong)NSString *isPhoneOpen;//是否公开手机号
@property (nonatomic,strong)NSString *isWechatOpen;//是否公开微信
@property (nonatomic,strong)NSString *tag;//标签
@property (nonatomic,strong)NSString *shoeSize;//编号展示
//@property (nonatomic,strong)NSString *motecard;
@property (nonatomic,strong)NSString *moka;//其他图片
@property (nonatomic,strong)NSString *qq;//QQ
@property (nonatomic,strong)NSString *gender;//性别
@property (nonatomic,strong)NSString *shoesize;
@property (nonatomic,strong)NSString *identity;//身份
@property (nonatomic,strong)NSString *phone;//手机号码
@property (nonatomic,strong)NSString *weight;//体重
@property (nonatomic,strong)NSString *wechat;//微信
@property (nonatomic,strong)NSString *category;//类别
@property (nonatomic,strong)NSString *nicename;//艺名、昵称
@property (nonatomic,strong)NSString *yirenno;
@property (nonatomic,strong)NSString *avatar;//头像
@property (nonatomic,strong)NSString *motto;//个性签名
@property (nonatomic,strong)NSString *isQQOpen;//是否公开QQ
@property (nonatomic,strong)NSArray *photo;//图片


@end
