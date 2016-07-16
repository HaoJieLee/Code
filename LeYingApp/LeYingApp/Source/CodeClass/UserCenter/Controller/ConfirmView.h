//
//  ConfirmView.h
//  乐影
//
//  Created by zhaoHm on 16/4/27.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmView : UIView

// 背景容器
@property (nonatomic,strong) UIView *backView;

// 四种身份
/// 艺人
@property (nonatomic,strong) UIImageView *imgArtist;
/// 影视机构
@property (nonatomic,strong) UIImageView *imgMoviePart;
/// 活动方
@property (nonatomic,strong) UIImageView *imgActive;
/// 路人
@property (nonatomic,strong) UIImageView *imgPasserBy;


@property (nonatomic,strong) UILabel *lblPrompt;
@end
