//
//  UnfinishDetailView.m
//  乐影
//
//  Created by LiuChenhao on 16/3/11.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "UnfinishDetailView.h"

@implementation UnfinishDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self p_UI];
    }
    return self;
}



-(void)p_UI
{
    
    //设置Scrollow
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), 2000);

    [self addSubview:_scrollView];
    
    
    //背景颜色
    self.scrollView.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f  blue:222/255.0f alpha:1.0];
   
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/4 + 20) imageURLStringsGroup:nil];

    self.cycleScrollView.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f  blue:222/255.0f alpha:1.0];
    [self.scrollView addSubview:_cycleScrollView];
    //播放按钮
    self.topMidImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.cycleScrollView.frame)/2 - 25,CGRectGetHeight(self.cycleScrollView.frame)/2 - 40, 80, 80)];
    [self.cycleScrollView addSubview:_topMidImage];
    //标题
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.cycleScrollView.frame) +10, CGRectGetWidth(self.frame) - 80, 30)];
    //self.titleLab.backgroundColor = [UIColor yellowColor];
    self.titleLab.text = @"我愿意孙周作品";
    [self.scrollView addSubview:_titleLab];
    
    //成交额
    self.volumeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLab.frame), CGRectGetMaxY(self.titleLab.frame), 40, 15)];
    self.volumeLab.font = [UIFont systemFontOfSize:12];
 
    self.volumeLab.textColor = [UIColor colorWithRed:111/255.0f green:111/255.0f blue:111/255.0f alpha:1.0];
    self.volumeLab.text = @"成交额:";
    [self.scrollView addSubview:_volumeLab];
    // 成交额展示
    self.volumeshowLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.volumeLab.frame), CGRectGetMaxY(self.titleLab.frame), 35, 15)];
    self.volumeshowLab.font = [UIFont systemFontOfSize:12];
    self.volumeshowLab.text = @"258";
    self.volumeshowLab.textColor = [UIColor colorWithRed:111/255.0f green:111/255.0f blue:111/255.0f alpha:1.0];
    [self.scrollView addSubview:_volumeshowLab];
    
    //播放量
    self.playLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.volumeshowLab.frame) , CGRectGetMaxY(self.titleLab.frame), 40, 15)];
    self.playLable.font = [UIFont systemFontOfSize:12];
    self.playLable.textColor = [UIColor colorWithRed:111/255.0f green:111/255.0f blue:111/255.0f alpha:1.0];
    self.playLable.text = @"播放量:";
    [self.scrollView addSubview:_playLable];
    
    //播放量展示
    self.playshowLab =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.playLable.frame) , CGRectGetMaxY(self.titleLab.frame), 40, 15)];
    self.playshowLab.font = [UIFont systemFontOfSize:12];
    self.playshowLab.textColor = [UIColor colorWithRed:111/255.0f green:111/255.0f blue:111/255.0f alpha:1.0];
    self.playshowLab.text = @"125";
    [self.scrollView addSubview:_playshowLab];
    
    
    
    self.shareImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -80 , CGRectGetMaxY(self.cycleScrollView.frame) +20, 25, 25)];
    self.shareImage.image = [UIImage imageNamed:@"yb1.png"];
    self.shareImage.hidden = YES;
    [self.scrollView addSubview:_shareImage];
    
    self.collectImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -45 , CGRectGetMaxY(self.cycleScrollView.frame) +20, 25, 25)];
    self.collectImage.image = [UIImage imageNamed:@"yb2.png"];
    [self.scrollView addSubview:_collectImage];
    
    
    self.contentWeb = [[UIWebView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.playshowLab.frame), CGRectGetWidth(self.frame) - 30,80)];
    NSString *htmlStr = @"";
    self.contentWeb.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f  blue:222/255.0f alpha:1.0];
    [self.contentWeb loadHTMLString:htmlStr baseURL:nil];
    [self.contentWeb sizeToFit];
    self.contentWeb.scrollView.tag = 2002;
    [self.scrollView addSubview:_contentWeb];
    
    /// 展开按钮
    self.btnShowDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnShowDetail.frame = CGRectMake(CGRectGetMaxX(self.contentWeb.frame) - 60, CGRectGetMaxY(self.contentWeb.frame) + 4 - 2, 60, 18);
    [self.btnShowDetail setBackgroundImage:[UIImage imageNamed:@"zhankai4.png"] forState:UIControlStateNormal];
    [self.scrollView addSubview:_btnShowDetail];
    
    
    self.titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentWeb.frame)+40, self.frame.size.width, 40)];
    //self.titleBar.backgroundColor = [UIColor blackColor];
    self.titles = @[@"剧组照片",  @"购买活动"];
    
    self.titleBar.titles = _titles;
    self.scrollView.tag = 2003;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
    [self.scrollView addSubview:_titleBar];
    
    
    
    
    
}


@end
