//
//  forgetView.h
//  乐影
//
//  Created by LiuChenhao on 16/4/6.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgetView : UIView

@property (nonatomic,strong)UIScrollView *backScrollView1;
@property (nonatomic,strong)UIImageView *logImage1;


@property(nonatomic,strong)UITextField * phoneNumber1;
@property(nonatomic,strong)UITextField * number1;
@property(nonatomic,strong)UITextField * password1;
@property(nonatomic,strong)UITextField * twoPassword1;
@property(nonatomic,strong)UIButton * getNumberButton1;
@property(nonatomic,strong)UIButton * registerButton1;


//修改

@property (nonatomic,weak)UIImageView *userImage;


@end
