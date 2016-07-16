//
//  ConfirmView.m
//  乐影
//
//  Created by zhaoHm on 16/4/27.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ConfirmView.h"

@implementation ConfirmView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setUpView];
    }
    return self;
}

-(void) p_setUpView
{
    // 设置view的背景
    self.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    // 背景backView的设置
    CGFloat Margin = 25;
    CGFloat backVW = KScreenW - 2 * Margin;
    CGFloat backVH = backVW;
    CGFloat backVY = (KScreenH - backVH) * 0.5;
    _backView = [[UIView alloc] initWithFrame:CGRectMake(Margin, backVY, backVW, backVH)];
    _backView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_backView];
    
    
//    // 四种身份
    CGFloat ArtW = backVW * 0.5;
    CGFloat ArtH = backVH * 0.5;
//    /// 艺人
//    @property (nonatomic,strong) UIImageView *imgArtist;
    _imgArtist = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yiren.jpg"]];
    _imgArtist.frame = CGRectMake(ArtW, 0, ArtW, ArtH);
    [_backView addSubview:_imgArtist];
    
//    /// 影视机构
//    @property (nonatomic,strong) UIImageView *imgMoviePart;
    _imgMoviePart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yingshi.jpg"]];
    _imgMoviePart.frame = CGRectMake(0, 0, ArtW, ArtH);
    [_backView addSubview:_imgMoviePart];
    
//    /// 活动方
//    @property (nonatomic,strong) UIImageView *imgActive;
    _imgActive = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huodong.jpg"]];
    _imgActive.frame = CGRectMake(0, ArtH, ArtW, ArtH);
    [_backView addSubview:_imgActive];
    
//    /// 路人
//    @property (nonatomic,strong) UIImageView *imgPasserBy;
    _imgPasserBy = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"luren.jpg"]];
    _imgPasserBy.frame = CGRectMake(ArtW, ArtH, ArtW, ArtH);
    [_backView addSubview:_imgPasserBy];
    
    
    
    
    ////     温馨提示
    //    @property (nonatomic,strong) UILabel *lblPrompt;
    _lblPrompt = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_backView.frame) + ArtW * 0.3, KScreenW, 30)];
    _lblPrompt.textAlignment = NSTextAlignmentCenter;
    _lblPrompt.textColor = [UIColor whiteColor];
    _lblPrompt.font = [UIFont systemFontOfSize:10];
    _lblPrompt.text = @"温馨提示：角色一经确认，无法更改，请谨慎";
    [self addSubview:_lblPrompt];
    
}

@end
