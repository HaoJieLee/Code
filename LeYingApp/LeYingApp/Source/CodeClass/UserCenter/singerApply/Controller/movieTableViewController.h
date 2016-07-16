//
//  movieTableViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/4/25.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArtPersonTableViewCell;

@interface movieTableViewController : UITableViewController

@property (nonatomic,strong) ArtPersonTableViewCell *artPersonTableviewCell;

/// 经修改后重新赋值
@property (nonatomic,strong) NSString *ArtistName;
@property (nonatomic,strong) NSString *ArtistSex;

@property (nonatomic,strong) NSString *ArtistLocal;
@property (nonatomic,strong) NSString *ArtistWeixinNumber;
@property (nonatomic,strong) NSString *ArtistTelNumber;
@property (nonatomic,strong) NSString *ArtistEmailNumber;
@property (nonatomic,strong) NSString *ArtistQQNumber;

@property (nonatomic,strong) NSString *ArtistXingzhi;
@property (nonatomic,strong) NSString *ArtistGongling;
@property (nonatomic,strong) NSString *ArtistLeixing;
@property (nonatomic,strong) NSString *ArtistQicai;

// 个性签名 主要作品 人生经历   3.31 start
@property (nonatomic,strong) NSString *ArtistSignature;
@property (nonatomic,strong) NSString *ArtistMainWorks;
@property (nonatomic,strong) NSString *ArtistLifeExperience;

@property (nonatomic,strong) NSString *sanweiNew1;
@property (nonatomic,strong) NSString *sanweiNew2;
@property (nonatomic,strong) NSString *sanweiNew3;

@property (nonatomic,strong) NSString *heightNew;
@property (nonatomic,strong) NSString *weightNew;
@property (nonatomic,strong) NSString *chimaNew;

@property (nonatomic,strong) NSString *isWeixinSelected;
@property (nonatomic,strong) NSString *isTelSelected;




@property (nonatomic,strong)NSMutableArray *myXingzhi;



@end
