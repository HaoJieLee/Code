//
//  getDataHand.h
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface getDataHand : NSObject
//<ASIHTTPRequestDelegate, ASIProgressDelegate>


@property (nonatomic,strong)NSMutableArray *dataArray;




+(instancetype)shareHandLineData;


/**获取融云聊天id*/
-(NSDictionary*)getRongCloudIDWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce userid:(NSString*)userid;

/**获取融云的Token*/
-(NSDictionary*)getRongCloudTokenWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce;
/**自动登录*/
- (NSDictionary*)autoLoginWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce;
/**根据用户id获取用户所有图片*/
- (NSArray*)getUsersAllPhotosWithUserId:(NSString*)userid;

/**删除一张图片*/
-(NSString*)DeletePhotosDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce ImgId:(NSString*)imgId;
/**将图片保存到相册资料*/
-(NSDictionary*)SaveUsersPhotosDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce ImgUrl:(NSString*)imgUrl imgDescription:(NSString*)imgDescription;


/**保存资料*/
-(NSDictionary*)SaveUsersAllDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce Key:(NSString*)key;

//获取验证码方法、、注册
-(void)getPhoneNumber:(NSString *)number Type:(int)type;

// 注册方法
-(BOOL)getPhoneNumber:(NSString *)number getSMS:(NSString *)sms getPassWord:(NSString *)passWord;
//修改密码

-(BOOL)editPhoneNumber:(NSString *)number getSMS:(NSString *)sms getPassWord:(NSString *)passWord;



/**登录*/
-(NSDictionary*)getPhone:(NSString *)phone getPassword:(NSString *)password;

//获取用户信息方法

-(NSArray *)getUserMessageToken:(NSString *)userToken;

/**获取标签分类*/
-(NSArray *)returnKind;

//系统设置/修改密码，修改昵称 获取验证码
-(void)editGetNumber:(NSString *)number;

-(BOOL)editUserMarket:(NSString *)artistMarket;//修改昵称

-(BOOL)editUserPasswordWithPhone:(NSString *)artPhone Code:(NSString *)artCode password:(NSString *)artPassword;//修改密码

/**刷新用户的全部资料*/
-(NSDictionary*)RefreshUsersAllDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce;

/**获取上传图片的Token*/
-(NSString*)stringPutPicture;


-(NSString *)getPhone1:(NSString *)phone1 getyanzheng:(NSString *)code getPassword:(NSString *)password;
/**保存身份的用户信息*/
-(NSString*)RefreshUsersIdentityDataWithAccessKey:(NSString*)accessKey Signature:(NSString*)signature Timestamp:(NSString*)timestamp Nonce:(NSString*)nonce Identity:(NSString*)identity;




@end
