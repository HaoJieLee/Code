//
//  JoinView.h
//  Zhongchou
//
//  Created by 赵良育 on 15/12/10.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinView : UIView

@property (nonatomic,strong)UIScrollView *backScrollView;


@property(nonatomic,strong)UITextField * phoneNumber;
@property(nonatomic,strong)UITextField * passWord;
@property(nonatomic,strong)UIButton * joinButton;
@property(nonatomic,strong)UIButton * forgetPassword;

@property(nonatomic,strong)UIButton *registBtn;


@property (nonatomic,strong)UIImageView *logImage;
//修改

@property (nonatomic,weak)UIImageView *userImage;


@end
