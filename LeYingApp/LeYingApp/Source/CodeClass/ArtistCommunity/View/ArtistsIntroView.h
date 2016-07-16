//
//  ArtistsIntroView.h
//  乐影
//
//  Created by LiuChenhao on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistsIntroView : UIView



@property (nonatomic,strong)UIScrollView *backScrollView;
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UIImageView *headImage;//图像
@property (nonatomic,strong)UIImageView *headImage1;
@property (nonatomic,strong)UILabel *nameLable;//名字
@property (nonatomic,strong)UILabel *numberLab;//编号
@property (nonatomic,strong)UILabel *numberShowLab;//编号展示
@property (nonatomic,strong)UIImageView *sexImage;//性别标签
@property (nonatomic,strong)UILabel *markLab;//标签
@property (nonatomic,strong)UIImageView *collectImage;//收藏
@property (nonatomic,strong)UIImageView *shareImage;//分享
@property (nonatomic,strong)UILabel *introduceLable;//签名
@property (nonatomic,strong)UIImageView *certifyImage;//认证
@property (nonatomic,strong)UILabel *addressLabel;//地址

@property (nonatomic,strong)UILabel *artistIntroduceLab;
@property (nonatomic,strong)UILabel *artistDetailLab;
@property (nonatomic,strong)UIImageView *artArrImage;
@property (nonatomic,strong)UILabel *artistNameLable;
@property (nonatomic,strong)UILabel *heightLable;
@property (nonatomic,strong)UILabel *sinaLable;
@property (nonatomic,strong)UILabel *constellationLable;

- (instancetype)initWithFrame:(CGRect)frame AddDictionary:(NSDictionary * )dictionary;

@end
