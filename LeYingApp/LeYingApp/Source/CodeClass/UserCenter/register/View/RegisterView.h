//
//  RegisterView.h
//  Zhongchou
//
//  Created by 赵良育 on 15/12/10.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView
@property (nonatomic,strong)UIScrollView *backScrollView;
@property (nonatomic,strong)UIImageView *logImage;


@property(nonatomic,strong)UITextField * phoneNumber;
@property(nonatomic,strong)UITextField * number;
@property(nonatomic,strong)UITextField * password;
@property(nonatomic,strong)UITextField * twoPassword;
@property(nonatomic,strong)UIButton * getNumberButton;
@property(nonatomic,strong)UIButton * registerButton;
@property(nonatomic,strong)UILabel * myTextLabel;
@property(nonatomic,strong)UIButton *userProtoclBtn;


//修改

@property (nonatomic,weak)UIImageView *userImage;



@end
