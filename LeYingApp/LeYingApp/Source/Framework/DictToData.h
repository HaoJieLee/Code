//
//  DictToData.h
//  乐影
//
//  Created by zhaoHm on 16/3/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictToData : NSObject

+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;


//+ (NSString *)postRequestWithURL: (NSString *)url  // IN
//                      postParems: (NSMutableDictionary *)postParems // IN
//                     picFilePath: (NSMutableArray *)picFilePath  // IN
//                     picFileName: (NSMutableArray *)picFileName ;


// 多图上传
+(void)uploadImages:(NSArray *)images parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

// 单图上传
+(void)uploadimg:(UIImage *)image serverUrl:(NSString *)url success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/// 通过url获取图片
+(UIImage *)getImageWithUrl:(NSString *)url;

/// 图片放大
+(void)showImage:(UIImageView *)avatarImageView;

/**
 headImgName   头部图片
 view   截图的基view   如 self.view
 jietuSize   截图大小
 footerName   尾部图片
 */
+(UIImage *)imageWithHeadImageName:(NSString *)headImgName WithJietuBase:(UIView *)view WithJietuRect:(CGRect)jietuRect WithfooterImageName:(NSString *)footerName;



//
+(void)showMBHUBWithContent:(NSString *)content ToView:(UIView *)view;


+ (BOOL) validateMobile:(NSString *)mobile;


@end
