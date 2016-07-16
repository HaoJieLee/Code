//
//  ArtEventDetails.m
//  乐影
//
//  Created by zhaoHm on 16/3/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtEventDetails.h"
#import "NSString+ZHMNSStringExt.h"


@interface ArtEventDetails()





@end

@implementation ArtEventDetails

- (instancetype)initWithFrame:(CGRect)frame AddPhotoArray:(NSArray*)photos UserAuthentication:(NSString*)userAuthentication IisFavorite:(int)isFavorite UserId:(NSString *)userId
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoArray = [NSMutableArray arrayWithArray:photos];
        self.userAuthentication = userAuthentication;
        self.isFavorite = isFavorite;
        self.backgroundColor = [UIColor clearColor];
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    // 轮播图空间大小分配
//    CGFloat firstX = 0;
//    CGFloat firstY = 0;
    CGFloat firstW = CGRectGetWidth(self.frame);
    CGFloat firstH = CGRectGetHeight(self.frame) / 4;
    self.firstImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/4 + 20) imageURLStringsGroup:nil];
    [self addSubview:_firstImageView];
    
    
    
    
    // 下部分
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstImageView.frame), firstW, firstH * 3)];
    [self addSubview:_bottomView];
    
    
    
    
    // 标题  分享  收藏  横线
    
    CGFloat imgShareAndCollectionW = 30;
    // 内边距
    CGFloat padding = 20;
    // 标题
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, CGRectGetWidth(self.bottomView.frame) - padding * 3 - imgShareAndCollectionW, 30)];
    self.lblTitle.text = @"新开活动通知";
    self.lblTitle.textColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1.0];
    [self.bottomView addSubview:_lblTitle];
    
    
    
    self.notifyTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.lblTitle.frame)-2*padding, padding, CGRectGetWidth(self.bottomView.frame) - padding * 3 - imgShareAndCollectionW, 30)];
    self.notifyTime.text = @"新开活动通知";
    self.notifyTime.font = [UIFont systemFontOfSize:12];
    self.notifyTime.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f blue:83/255.0f alpha:1.0];
    [self.bottomView addSubview:self.notifyTime];
    
    // 分享
    self.imgShare = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 50, CGRectGetMinY(self.lblTitle.frame), imgShareAndCollectionW, imgShareAndCollectionW)];
    self.imgShare.image = [UIImage imageNamed:@"yb1"];
    self.imgShare.hidden = YES;
    [self.bottomView addSubview:_imgShare];
    
    // 收藏
//    self.imgCollection = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgShare.frame) + 10, CGRectGetMinY(self.imgShare.frame), imgShareAndCollectionW, imgShareAndCollectionW)];
//    self.imgCollection.image = [UIImage imageNamed:@"yb2"];
//    [self.bottomView addSubview:_imgCollection];
    
    // 横线
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.imgShare.frame) + 5, CGRectGetWidth(self.bottomView.frame) - 30, 1)];
    self.lineView.backgroundColor = [UIColor colorWithRed:133/255.0f green:133/255.0f blue:133/255.0f alpha:0.2];
    [self.bottomView addSubview:_lineView];
    
    
    
    
//    //// 活动时间
//    @property (nonatomic,strong) UIImageView *imgTime;
//    @property (nonatomic,strong) UILabel *lblTime;
    self.imgTime = [[UIImageView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(self.lineView.frame) + 18, 20, 20)];
    self.imgTime.image = [UIImage imageNamed:@"ziliao1"];
    [self.bottomView addSubview:_imgTime];
    
    self.lblTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgTime.frame) + 10, CGRectGetMinY(self.imgTime.frame), CGRectGetWidth(self.bottomView.frame) - padding * 3, CGRectGetHeight(self.imgTime.frame))];
    self.lblTime.text = @"2016-3-01 8:00——2016-3-01 10:00";
    self.lblTime.font = [UIFont systemFontOfSize:14];
    self.lblTime.textColor =[UIColor colorWithRed:85/255.0f green:85/255.0f blue:83/255.0f alpha:1.0];
    [self.bottomView addSubview:_lblTime];
//    
//    // 地址
//    @property (nonatomic,strong) UIImageView * imgLocation;
//    @property (nonatomic,strong) UILabel *lblLocation;
    self.imgLocation = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imgTime.frame), CGRectGetMaxY(self.imgTime.frame) + 6, CGRectGetWidth(self.imgTime.frame), CGRectGetHeight(self.imgTime.frame))];
    self.imgLocation.image = [UIImage imageNamed:@"ziliao2"];
    [self.bottomView addSubview:_imgLocation];
    
    self.lblLocation = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblTime.frame), CGRectGetMinY(self.imgLocation.frame), CGRectGetWidth(self.lblTime.frame), CGRectGetHeight(self.lblTime.frame))];
    self.lblLocation.text = @"浙江省杭州市江干区";
    self.lblLocation.font = [UIFont systemFontOfSize:14];
    self.lblLocation.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f blue:83/255.0f alpha:1.0];
    [self.bottomView addSubview:_lblLocation];
//    
//    // 模特详情
//    @property (nonatomic,strong) UIImageView *imgModol;
//    @property (nonatomic,strong) UILabel *lblModol;
//    @property (nonatomic,strong) UILabel *lblPrice;
    self.imgModol = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imgLocation.frame), CGRectGetMaxY(self.imgLocation.frame) + 6, CGRectGetWidth(self.imgLocation.frame), CGRectGetHeight(self.imgLocation.frame))];
    self.imgModol.image = [UIImage imageNamed:@"ziliao3"];
    [self.bottomView addSubview:_imgModol];
    
    self.lblModol = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblLocation.frame), CGRectGetMinY(self.imgModol.frame), CGRectGetWidth(self.lblLocation.frame) - 150, CGRectGetHeight(self.lblLocation.frame))];
    self.lblModol.text = @"模特*2 男女不限";
    self.lblModol.font = [UIFont systemFontOfSize:14];
    self.lblModol.textColor =[UIColor colorWithRed:85/255.0f green:85/255.0f blue:83/255.0f alpha:1.0];
    [self.bottomView addSubview:_lblModol];
    
    self.lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) -120, CGRectGetMinY(self.lblModol.frame), 100, CGRectGetHeight(self.lblModol.frame))];
    self.lblPrice.textAlignment = NSTextAlignmentRight;
    self.lblPrice.text = @"5000元/天";
    self.lblPrice.font = [UIFont systemFontOfSize:14];
    self.lblPrice.textColor = [UIColor colorWithRed:196 / 255.0 green:153 / 255.0 blue:44 / 255.0 alpha:1];
    [self.bottomView addSubview:_lblPrice];
//    
//    // 点击数量
//    @property (nonatomic,strong) UIImageView *imgClick;
//    @property (nonatomic,strong) UILabel *lblClick;
    self.imgClick = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imgTime.frame), CGRectGetMaxY(self.imgModol.frame) + 6, CGRectGetWidth(self.imgTime.frame), CGRectGetHeight(self.imgTime.frame))];
    self.imgClick.image = [UIImage imageNamed:@"ziliao4"];
    [self.bottomView addSubview:_imgClick];
    
    self.lblClick = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblTime.frame), CGRectGetMaxY(self.lblModol.frame) + 6, CGRectGetWidth(self.lblTime.frame), CGRectGetHeight(self.lblTime.frame))];
    self.lblClick.text = @"1000";
    self.lblClick.font = [UIFont systemFontOfSize:14];
    self.lblClick.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f blue:83/255.0f alpha:1.0];
    [self.bottomView addSubview:_lblClick];
    
//    // 详情
//    @property (nonatomic,strong) UIImageView *imgDetails;
//    @property (nonatomic,strong) UILabel *lblDetails;
    self.imgDetails = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.imgTime.frame), CGRectGetMaxY(self.imgClick.frame) + 6, CGRectGetWidth(self.imgTime.frame), CGRectGetHeight(self.imgTime.frame))];
    self.imgDetails.image = [UIImage imageNamed:@"ziliao5"];
    [self.bottomView addSubview:_imgDetails];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:14];
    CGSize maxSize;
    maxSize.height = 1000;
    maxSize.width = CGRectGetWidth(self.lblTime.frame) - 20;

    self.lblDetails = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblTime.frame)-5, CGRectGetMinY(self.imgDetails.frame) -10, CGRectGetWidth(self.lblTime.frame) + 20, KScreenH - 100 - CGRectGetMaxY(self.lblClick.frame))];
    self.lblDetails.userInteractionEnabled = YES;
    self.lblDetails.font = [UIFont systemFontOfSize:14];
    self.lblDetails.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:_lblDetails];
    [self addPhoneView];
    [self addPhotos];
}
- (void)addPhotos{
    UIScrollView *photos = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.lblDetails.frame)+130, CGRectGetWidth(self.frame), 100)];
    photos.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:photos];
    NSInteger count = self.photoArray.count;
    for (int i = 0; i < count; i++) {

        NSString *dic =  [self.photoArray[i] objectForKey:@"pic"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20+i*(80+10), 10, 80, 80)];
        NSURL *url = [NSURL URLWithString:dic];
        [imageView sd_setImageWithURL:url];
//        imageView.backgroundColor = [UIColor blueColor];
        [photos addSubview:imageView];
    }
    if (count>4) {
        photos.contentSize = CGSizeMake((count-4)*100, 100);
    }
    [self addUserInformation];
    
}
- (void)addUserInformation{
    UIView *information = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.lblDetails.frame)+230, CGRectGetWidth(self.frame), 110)];
    information.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    UIView *informationView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 100)];
    informationView.backgroundColor = [UIColor whiteColor];
    
    self.userHeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 65, 20, 10)];
    if ([self.userAuthentication isEqualToString:@"1"]) {
        imageView.image = [UIImage imageNamed:@"both1"];
        
    }else{
        imageView.image = [UIImage imageNamed:@"both1"];
    }
    [self.userHeadImage addSubview:imageView];
    
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 80, 40)];
    self.userNameLabel.textColor = [UIColor blackColor];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont systemFontOfSize:15];
    self.userWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 80, 30)];
    self.userWorkLabel.textColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    self.userWorkLabel.textAlignment = NSTextAlignmentLeft;
    self.userWorkLabel.font = [UIFont systemFontOfSize:12];
    [informationView addSubview:self.userHeadImage];
    [informationView addSubview:self.userNameLabel];
    [informationView addSubview:self.userWorkLabel];
    
    UIImageView *lingImage = [[UIImageView alloc]initWithFrame:CGRectMake(selfWidth-30, 20, 10, 60)];
    
#pragma need image
    lingImage.image = [UIImage imageNamed:@"both1.png"];
    
    
    UIButton *infoButton = [Factory initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 100) BackColor:[UIColor clearColor] Title:@"" TintColor:nil Tag:1 ButtonType:UIButtonTypeCustom];
    [infoButton addTarget:self action:@selector(userInforButton) forControlEvents:UIControlEventTouchUpInside];
    [informationView addSubview:infoButton];
    [informationView addSubview:lingImage];
    [information addSubview:informationView];
    [self.bottomView addSubview:information];

}
- (void)userInforButton{
    
    if (self.userBlock) {
        self.userBlock();
    }
}
//打电话的view
- (void)addPhoneView{
    UIView *phoneView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.lblDetails.frame)+40, CGRectGetWidth(self.frame), 90)];
    phoneView1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), 70)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [phoneView1 addSubview:phoneView];
    
    
    self.phoneButton = [Factory initWithFrame:CGRectMake(20, 20, 30, 30) BackColor:[UIColor whiteColor] Title:@"电话" TintColor:[UIColor clearColor] Tag:0 ButtonType:UIButtonTypeCustom];
    [self.phoneButton setBackgroundImage:[UIImage imageNamed:@"both1"] forState:UIControlStateNormal];
    [self.phoneButton addTarget:self action:@selector(telPhone) forControlEvents:UIControlEventTouchUpInside];
    [phoneView addSubview:self.phoneButton];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.phoneButton.frame)+10, 10, 80, 50)];
    label.text = @"联系方式";
    label.textColor = [UIColor blackColor];
    [phoneView addSubview:label];
    //电话号码
    self.phoneNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 10, 100, 50)];
    self.phoneNum.text = @"111111111111";
    self.phoneNum.textColor = [UIColor blueColor];
    self.phoneNum.font = [UIFont systemFontOfSize:17];
    [phoneView addSubview:self.phoneNum];
    
    [self.bottomView addSubview:phoneView1];
    
    
    if (CGRectGetMaxY(self.lblDetails.frame) > CGRectGetHeight(self.bottomView.frame)) {
        self.scrollEnabled = YES;
        self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.lblDetails.frame) + CGRectGetHeight(self.firstImageView.frame));
    }
    
}
- (void)telPhone{
    if (self.block) {
        self.block(@"打电话");
    }
    

}
@end
