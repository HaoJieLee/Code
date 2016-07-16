//
//  TopView.m
//  乐影
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "TopView.h"

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createTopView];
    }
    return self;
}
- (void)createTopView {
//    Image
    self.headImage = [UIImageView new];
    CGFloat headX = 25;
    CGFloat headH = self.frame.size.height - (headX * 2);
    CGRect headFrame = CGRectMake(headX, headX, headH, headH);
    _headImage.frame = headFrame;
    _headImage.layer.cornerRadius = headH/2;
    _headImage.layer.masksToBounds = YES;
    [_headImage.layer setBorderWidth:5];
    [_headImage.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为蓝色
    _headImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_headImage];
    _headImage.userInteractionEnabled = YES;
    self.headImage.backgroundColor = [UIColor greenColor];
    
//    Name
    self.nameLable = [UILabel new];
    CGFloat nameH = 25;
    CGFloat TopY = (self.frame.size.height - nameH)/2;
    CGRect nameFrame = CGRectMake(headX + headH + 8, TopY, 60, nameH);
    _nameLable.frame = nameFrame;
    _nameLable.text = @"一个人";
    [self addSubview:_nameLable];
    
//    Sex And attestation
    
    CGFloat imageH = 23;
    self.sexImage = [UIImageView new];
    CGRect sexFrame = CGRectMake(_nameLable.frame.origin.x + _nameLable.frame.size.width,TopY, imageH, imageH);
    _sexImage.frame = sexFrame;
    [self addSubview:_sexImage];
    
    
    self.attestation = [UIImageView new];
    CGFloat attW = 78;
    CGRect attFrame = CGRectMake(self.frame.size.width - attW - 15, TopY, attW, imageH);
    _attestation.image = [UIImage imageNamed:@"ic_me_authentication"];
    _attestation.frame = attFrame;
    [self addSubview:_attestation];
    
    _sexImage.backgroundColor = [UIColor blueColor];
    
    
}

@end
