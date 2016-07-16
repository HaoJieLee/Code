//
//  ArtApplyTableViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArtPersonTableViewCell;

@interface ArtApplyTableViewController : UITableViewController

@property (nonatomic,copy)UIView *backView;
@property (nonatomic,copy)UIImageView *myImage;

@property (nonatomic,assign) BOOL isYiren;
@property (nonatomic,copy) NSString *myPic;

@property (nonatomic,strong) ArtPersonTableViewCell *artPersonTableviewCell;


/// 经修改后重新赋值
@property (nonatomic,copy) NSString *ArtistName;//艺人姓名
@property (nonatomic,copy) NSString *ArtistSex;//艺人性别
@property (nonatomic,copy) NSString *ArtistType;//艺人类型
@property (nonatomic,copy) NSString *ArtistBiaoqian;//艺人标签
@property (nonatomic,copy) NSString *ArtistLocal;//艺人归属地
@property (nonatomic,copy) NSString *ArtistWeixinNumber;//艺人微信
@property (nonatomic,copy) NSString *ArtistTelNumber;//艺人电话
@property (nonatomic,copy) NSString *ArtistEmailNumber;//艺人Email
@property (nonatomic,copy) NSString *ArtistQQNumber;//艺人QQ
@property (nonatomic,copy) NSString *ArtistBiaoqianId;//
@property (nonatomic,copy) NSArray *ArtistTypeId;//
// 标签类型备份
//@property (nonatomic,copy) NSString *ArtistBiaoqianId;
//@property (nonatomic,copy) NSString *ArtistTypeId;

// 个性签名 主要作品 人生经历   3.31 start
@property (nonatomic,copy) NSString *ArtistSignature;
@property (nonatomic,copy) NSString *ArtistMainWorks;
@property (nonatomic,copy) NSString *ArtistLifeExperience;
// 3.31 end
@property (nonatomic,copy) NSString *sanweiNew1;
@property (nonatomic,copy) NSString *sanweiNew2;
@property (nonatomic,copy) NSString *sanweiNew3;

@property (nonatomic,copy) NSString *heightNew;
@property (nonatomic,copy) NSString *weightNew;
@property (nonatomic,copy) NSString *chimaNew;

@property (nonatomic,copy) NSString *isWeixinSelected;
@property (nonatomic,copy) NSString *isTelSelected;


@end
