//
//  UnfinishDetailView.h
//  乐影
//
//  Created by LiuChenhao on 16/3/11.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"


@interface UnfinishDetailView : UIView
@property(nonatomic,retain)UIScrollView *scrollView;

//@property (nonatomic,strong)UIImageView *topImage;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;


@property (nonatomic,strong)UIImageView *topMidImage;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *volumeLab;
@property (nonatomic,strong)UILabel *volumeshowLab;
@property (nonatomic,strong)UILabel *playLable;
@property (nonatomic,strong)UILabel *playshowLab;
@property (nonatomic,strong)UIImageView *shareImage;
@property (nonatomic,strong)UIImageView *collectImage;



/// 展开收缩
@property (nonatomic,strong)UIWebView *contentWeb;
@property (nonatomic,strong) UIButton *btnShowDetail;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) LGtitleBarView *titleBar;




@end
