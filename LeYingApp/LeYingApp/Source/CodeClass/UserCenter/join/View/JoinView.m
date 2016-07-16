//
//  JoinView.m
//  Zhongchou
//
//  Created by 赵良育 on 15/12/10.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import "JoinView.h"

@implementation JoinView
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
    //设置Scrollow
    self.backScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    self.backScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), 700);
    
    [self addSubview:_backScrollView];
    

    
    //logo初始化
    self.logImage = [[UIImageView alloc]initWithFrame:CGRectMake(selfWidth / 2 - KScreenW/3/2, 40 + 44,KScreenW/3,KScreenW/3 )];
    self.logImage.image = [UIImage imageNamed:@"logot.png"];
    self.logImage.layer.cornerRadius =KScreenW/3/2;
    self.logImage.layer.masksToBounds = YES;
    _userImage = self.logImage;
    [self.backScrollView addSubview:_userImage];
    
    
    
    // 手机号textField
     self.phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(111, selfWidth * 2/3, CGRectGetWidth(self.frame) - 132, selfWidth /9)];
    
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    
    
    self.phoneNumber.backgroundColor = [UIColor whiteColor];
    //self.phoneNumber.alpha = 0.3;
    [self mytextField:self.phoneNumber myLabelText:@"手机号码" myTextFieldColor:[UIColor whiteColor]];
    // 登录密码textField
    self.passWord = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.phoneNumber.frame), CGRectGetMaxY(self.phoneNumber.frame)+20, CGRectGetWidth(self.phoneNumber.frame), CGRectGetHeight(self.phoneNumber.frame))];
    self.passWord.backgroundColor = [UIColor whiteColor];

    

    [self mytextField:self.passWord myLabelText:@"登录密码" myTextFieldColor:[UIColor whiteColor]];
    
    // 登录button
    
    self.joinButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.joinButton.frame = CGRectMake(selfWidth/8, CGRectGetMaxY(self.passWord.frame)+self.passWord.frame.size.height/2 + 10, selfWidth *3 /4, self.passWord.frame.size.height);
    
    [self.joinButton setTitle:@"登   录" forState:UIControlStateNormal];
    
    self.joinButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.joinButton.layer.contents = (id)[UIImage imageNamed:@"loginbg.png"].CGImage;
    
    self.joinButton.alpha = 1;
    
    [self.joinButton setTintColor:[UIColor whiteColor]];
    // 忘记密码button
    
    NSLog(@"%f",CGRectGetMaxX(self.joinButton.frame));
    self.forgetPassword = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.forgetPassword.frame = CGRectMake(CGRectGetMaxX(self.joinButton.frame) - 60 , CGRectGetMaxY(self.joinButton.frame)+self.joinButton.frame.size.height/6, 70, self.joinButton.frame.size.height);
    
    [self.forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    self.forgetPassword.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.forgetPassword setTintColor:[UIColor whiteColor]];
    
    [self.backScrollView addSubview:_forgetPassword];

    
    //注册
    self.registBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    self.registBtn.frame = CGRectMake(CGRectGetMinX(self.joinButton.frame) - 20, CGRectGetMinY(self.forgetPassword.frame), 60, CGRectGetHeight(self.forgetPassword.frame));
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.registBtn setTintColor:[UIColor whiteColor]];
    
    [self.backScrollView addSubview:_registBtn];
    

    
    
    //设置边缘光滑
    self.joinButton.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
    [self.backScrollView addSubview:_joinButton];
    
    
    
    
}
// 封装的 textField 和 label结合的私有方法
-(void)mytextField:(UITextField *)textField myLabelText:(NSString *)labelText myTextFieldColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMinY(textField.frame), 90, textField.frame.size.height)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = labelText;
    
    UIColor *color1 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"label.png"]];
    
    
    [label setBackgroundColor:color1];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
  
    textField.backgroundColor = color1;
    
    //label.backgroundColor = color;
    
    [self.backScrollView addSubview:textField];
    
    [self.backScrollView addSubview:label];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumber resignFirstResponder];
    
    [self.passWord resignFirstResponder];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
