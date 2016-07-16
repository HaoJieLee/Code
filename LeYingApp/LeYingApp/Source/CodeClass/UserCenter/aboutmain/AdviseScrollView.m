//
//  AdviseScrollView.m
//  SeeWorld
//
//  Created by LZZ on 15/10/28.
//  Copyright (c) 2015年 LZZ. All rights reserved.
//

#import "AdviseScrollView.h"

@implementation AdviseScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    
    //    textField
    //    self.textField = [[UITextField alloc] init];
    //    CGFloat textX = 0;
    CGFloat textY = 94;
    //    CGFloat textW = KScreenW;
    CGFloat textH = 170;
    //    self.textField.frame = CGRectMake(textX, textY, textW, textH);
    //    self.textField.placeholder = @"请输入你的宝贵意见";
    //    self.textField.adjustsFontSizeToFitWidth = YES;
    //    self.textField.borderStyle = UITextBorderStyleLine;
    //    self.textField.font = [UIFont systemFontOfSize:16];
    //    [self addSubview:_textField];
    
    
    //    btnSub
    self.btnSub = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat subX = KMarginX * 2;
    CGFloat subY = 180;
    CGFloat subW = KScreenW - 4 * KMarginX;
    CGFloat subH = 40;
    self.btnSub.frame = CGRectMake(subX, subY, subW, subH);
    [self.btnSub setTitle:@"提交" forState:UIControlStateNormal];
    self.btnSub.layer.cornerRadius = 7;
    [self.btnSub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnSub.backgroundColor = [UIColor whiteColor];
    self.btnSub.alpha = 0.5;
    self.btnSub.backgroundColor = [UIColor colorWithRed:222 / 255.0 green:222 / 255.0 blue:222 / 255.0 alpha:1];
    [self.btnSub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_btnSub];
    
    
    /// textView
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 168)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.layer.cornerRadius = 7;
    [self addSubview:_textView];
    
    
    self.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:232 / 255.0 blue:232 / 255.0 alpha:1];
}

@end
