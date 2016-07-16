//
//  ArtistsIntroView.m
//  乐影
//
//  Created by LiuChenhao on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtistsIntroView.h"

@implementation ArtistsIntroView

- (instancetype)initWithFrame:(CGRect)frame AddDictionary:(NSDictionary * )dictionary {    
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
    self.backScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), 1300);
    self.backScrollView.tag = 2701;
    [self addSubview:_backScrollView];
    
    
    //设置顶部背景
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 130)];
    //self.topView.backgroundColor = [UIColor redColor];
    self.topView.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [self.backScrollView addSubview:_topView];
    
    
    //设置头部图片
    self.headImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(self.topView.frame)/2-CGRectGetWidth(self.frame) *0.21/2, CGRectGetWidth(self.frame) *0.21, CGRectGetWidth(self.frame) *0.21)];
    self.headImage1.backgroundColor = [UIColor colorWithRed:232/255.0f green:227/255.0f blue:239/255.0f alpha:1.0];
    self.headImage1.layer.cornerRadius = CGRectGetWidth(self.frame) *0.21/2;
   // self.headImage1.image = [UIImage imageNamed:@"logo.png"];
    self.headImage1.layer.masksToBounds = YES;
    [self.topView addSubview:_headImage1];
    
    //设置头部图片
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, CGRectGetWidth(self.frame) *0.21 - 8, CGRectGetWidth(self.frame) *0.21 - 8)];
    //self.headImage.backgroundColor = [UIColor ];
    self.headImage.layer.cornerRadius = (CGRectGetWidth(self.frame) *0.21 - 8)/2;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage1 addSubview:_headImage];
    //姓名
    //    @property (nonatomic,strong)UILabel *nameLable;//名字
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImage1.frame) + 8, CGRectGetMinY(self.headImage1.frame), 130, 20)];
    self.nameLable.font = [UIFont systemFontOfSize:17];
    self.nameLable.text = @"杭州鸿古";
    self.nameLable.textColor = [UIColor whiteColor];
    
    [self.topView addSubview:_nameLable];
    //    @property (nonatomic,strong)UILabel *numberLab;//编号
    CGFloat numberW = 30;
    CGFloat numberH = 25;
    self.numberLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) - 80 - numberW, CGRectGetMinY(self.nameLable.frame) , numberW, numberH)];
    self.numberLab.font = [UIFont systemFontOfSize:13];
    self.numberLab.textColor = [UIColor whiteColor];
    self.numberLab.text = @"编号:";
    [self.topView addSubview:_numberLab];
    //    @property (nonatomic,strong)UILabel *numberShowLab;//编号展示
    self.numberShowLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.numberLab.frame) + 3, CGRectGetMinY(self.numberLab.frame), 70, CGRectGetHeight(self.numberLab.frame))];
    self.numberShowLab.font = [UIFont systemFontOfSize:13];
    self.numberShowLab.text = @"hg123";
    self.numberShowLab.textColor = [UIColor whiteColor];
    [self.topView addSubview:_numberShowLab];
    //@property (nonatomic,strong)UIImageView *sexImage;//性别标签
    self.sexImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.nameLable.frame)+40, CGRectGetMinY(self.numberLab.frame), 20, 20)];
    self.sexImage.image = [UIImage imageNamed:@"xingbie"];
    [self.topView addSubview:_sexImage];
    
    //已认证image
    self.certifyImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.nameLable.frame)+60, CGRectGetMinY(self.numberLab.frame), 60, 20)];
    self.certifyImage.image = [UIImage imageNamed:@"xingbie"];
    [self.topView addSubview:self.certifyImage];
    //职业
    self.markLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImage1.frame) + 8, CGRectGetMaxY(self.sexImage.frame)+5, 150, CGRectGetHeight(self.sexImage.frame))];
    self.markLab.font = [UIFont systemFontOfSize:13];
    self.markLab.textColor = [UIColor whiteColor];
    self.markLab.text = @"我就是我";
    [self.topView addSubview:_markLab];
    
    //地址
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImage1.frame) + 8, CGRectGetMaxY(self.markLab.frame)+5, 150, CGRectGetHeight(self.markLab.frame))];
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    self.addressLabel.textColor = [UIColor whiteColor];
    self.addressLabel.text = @"中国";
    [self.topView addSubview:self.addressLabel];

    
    //    @property (nonatomic,strong)UILabel *introduceLable;//签名
    self.introduceLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImage1.frame) + 8, CGRectGetMaxY(self.addressLabel.frame), CGRectGetWidth(self.topView.frame) - CGRectGetMinX(self.addressLabel.frame) - 20, CGRectGetHeight(self.addressLabel.frame))];
    self.introduceLable.font = [UIFont systemFontOfSize:15];
    self.introduceLable.text = @"我是艺人";
    self.introduceLable.textColor = [UIColor whiteColor];
    [self.topView addSubview:_introduceLable];
    
    //    @property (nonatomic,strong)UIImageView *shareImage;//分享
    CGFloat chazhi = (CGRectGetMaxX(self.numberShowLab.frame) - CGRectGetMinX(self.numberLab.frame) - (CGRectGetMinY(self.introduceLable.frame) - CGRectGetMaxY(self.numberLab.frame) - 10) * 2 - 12) / 2;
    
     //分享图片
    self.shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.numberLab.frame) + chazhi, CGRectGetMaxY(self.numberLab.frame)  + 5, CGRectGetMinY(self.introduceLable.frame) - CGRectGetMaxY(self.numberLab.frame) - 5, CGRectGetMinY(self.introduceLable.frame) - CGRectGetMaxY(self.numberLab.frame) - 5)];
    self.shareImage.image = [UIImage imageNamed:@"yb1"];
    //self.shareImage.hidden = YES;
    [self.topView addSubview:_shareImage];
    
    
    //    @property (nonatomic,strong)UIImageView *collectImage;//收藏
    self.collectImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.shareImage.frame) + 12, CGRectGetMinY(self.shareImage.frame), CGRectGetWidth(self.shareImage.frame), CGRectGetHeight(self.shareImage.frame))];
    self.collectImage.image = [UIImage imageNamed:@"yb2"];
    [self.topView addSubview:_collectImage];
    
}



@end