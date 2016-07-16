//
//  ActiveApplysTableViewController.h
//  乐影
//
//  Created by zhaoHm on 16/4/25.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArtPersonTableViewCell;

@interface ActiveApplysTableViewController : UITableViewController

@property (nonatomic,strong) ArtPersonTableViewCell *artPersonTableviewCell;

/// 经修改后重新赋值
@property (nonatomic,strong) NSString *ArtistName;
@property (nonatomic,strong) NSString *ArtistXingzhi;
@property (nonatomic,strong) NSString *ArtistLeixing;
//@property (nonatomic,strong) NSString *ArtistBiaoqian;
@property (nonatomic,strong) NSString *ArtistLocal;
@property (nonatomic,strong) NSString *ArtistWeixinNumber;
@property (nonatomic,strong) NSString *ArtistTelNumber;
@property (nonatomic,strong) NSString *ArtistEmailNumber;
@property (nonatomic,strong) NSString *ArtistQQNumber;
//@property (nonatomic,strong) NSString *ArtistBiaoqianId;
//@property (nonatomic,strong) NSString *ArtistTypeId;

// 个性签名 活动方介绍
@property (nonatomic,strong) NSString *ArtistSignature;
// 活动方介绍
@property (nonatomic,strong) NSString *ArtistMainWorks;
//@property (nonatomic,strong) NSString *ArtistLifeExperience;

@property (nonatomic,strong) NSString *isWeixinSelected;
@property (nonatomic,strong) NSString *isTelSelected;




@property (nonatomic,copy)NSString *gender;
@property (nonatomic,strong)NSArray *HdType;
@property (nonatomic,strong)NSArray *HdXingzhi;


@end
