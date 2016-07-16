//
//  RegisterView.m
//  Zhongchou
//
//  Created by 赵良育 on 15/12/10.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView
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
    self.backScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame),700);
    
    [self addSubview:_backScrollView];
    
    
    //logo初始化
    self.logImage = [[UIImageView alloc]initWithFrame:CGRectMake(selfWidth / 2 - KScreenW/3/2, 40 + 44,KScreenW/3,KScreenW/3 )];
    self.logImage.image = [UIImage imageNamed:@"logot.png"];
    self.logImage.layer.cornerRadius =KScreenW/3/2;
    self.logImage.layer.masksToBounds = YES;
    _userImage = self.logImage;
    [self.backScrollView addSubview:_userImage];
    
    
    
    // 电话号码textField初始化
    self.phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(selfWidth / 4, selfWidth * 2/3, selfWidth * 3 / 4, selfWidth /9)];
//    self.phoneNumber.textColor = [UIColor blackColor];
    
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumber.backgroundColor = [UIColor whiteColor];
    self.phoneNumber.alpha = 0.3;

    [self mytextField:self.phoneNumber myLabelText:@"手机号" myTextFieldColor:[UIColor whiteColor]];
    
    // 验证码textField初始化
    self.number = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.phoneNumber.frame), CGRectGetMaxY(self.phoneNumber.frame)+0.8, CGRectGetWidth(self.phoneNumber.frame), CGRectGetHeight(self.phoneNumber.frame))];
    
    self.number.keyboardType = UIKeyboardTypeNumberPad;
    self.number.backgroundColor = [UIColor whiteColor];
    
    self.number.alpha = 0.3;

    [self mytextField:self.number myLabelText:@"验证码" myTextFieldColor:[UIColor whiteColor]];
    
    // 获取验证码button初始化
    self.getNumberButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    
    self.getNumberButton.frame = CGRectMake(selfWidth*3/4, self.number.frame.size.height/8 + CGRectGetMinY(self.number.frame), selfWidth/4 - 5, self.number.frame.size.height * 3/4);
    
    self.getNumberButton.backgroundColor = [UIColor colorWithRed:113/255.0f green:132/255.0f blue:140/255.0f alpha:0.8];
    
    [self.getNumberButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getNumberButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.getNumberButton setTintColor:[UIColor whiteColor]];
    
    [self.backScrollView addSubview:_getNumberButton];
    
    // 密码textField初始化
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.number.frame), CGRectGetMaxY(self.number.frame)+0.8, CGRectGetWidth(self.number.frame), CGRectGetHeight(self.number.frame))];
    
    self.password.returnKeyType = UIReturnKeyDefault;
    self.password.backgroundColor = [UIColor whiteColor];
    self.password.alpha = 0.3;

    [self mytextField:self.password myLabelText:@"登录密码" myTextFieldColor:[UIColor whiteColor]];
    
    self.password.secureTextEntry = YES;
    
    // 再次输入密码textField初始化
    self.twoPassword = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.password.frame), CGRectGetMaxY(self.password.frame)+0.8, CGRectGetWidth(self.password.frame), CGRectGetHeight(self.password.frame))];
    
    self.twoPassword.backgroundColor = [UIColor whiteColor];
    self.twoPassword.alpha = 0.3;

    [self mytextField:self.twoPassword myLabelText:@"确认密码" myTextFieldColor:[UIColor whiteColor]];
    
    self.twoPassword.secureTextEntry = YES;
    
    // 注册button
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.registerButton.frame = CGRectMake(selfWidth/8, CGRectGetMaxY(self.twoPassword.frame)+self.twoPassword.frame.size.height/2, selfWidth *3 /4, self.twoPassword.frame.size.height);
    
    
    
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
     self.registerButton.layer.contents = (id)[UIImage imageNamed:@"loginbg.png"].CGImage;
    
    [self.registerButton setTintColor:[UIColor whiteColor]];
    
    //设置边缘光滑
    self.registerButton.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
    
    [self.backScrollView addSubview:_registerButton];
    
    //
    
    self.myTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.registerButton.frame) + self.registerButton.frame.size.height/2, selfWidth*1/2 -10, self.registerButton.frame.size.height/2)];
    self.myTextLabel.textColor = [UIColor whiteColor];
    self.myTextLabel.textAlignment = NSTextAlignmentRight;
    //0self.myTextLabel.backgroundColor = [UIColor redColor];
    NSString * string = @"点击'注册'表示您同意";
    NSMutableAttributedString  * str = [[NSMutableAttributedString alloc]initWithString:string];
   /// [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(12, 6)];
    
    self.myTextLabel.attributedText = str;
    
    //self.myTextLabel.textAlignment = NSTextAlignmentCenter;
    
    self.myTextLabel.font = [UIFont systemFontOfSize:12];
    
    [self.backScrollView addSubview:_myTextLabel];
    
    
    
    self.userProtoclBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.userProtoclBtn.frame = CGRectMake(CGRectGetMaxX(self.myTextLabel.frame), CGRectGetMinY(self.myTextLabel.frame), 100, CGRectGetHeight(self.myTextLabel.frame));
    self.userProtoclBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.userProtoclBtn.tintColor = [UIColor colorWithRed:150/255.0f green:208/255.0f blue:220/255.0f alpha:1.0];
    [self.userProtoclBtn setTitle:@"《用户注册协议》" forState:UIControlStateNormal];
    [self.backScrollView addSubview:_userProtoclBtn];
    
    
    

}
// 封装的 textField 和 label结合的私有方法
-(void)mytextField:(UITextField *)textField myLabelText:(NSString *)labelText myTextFieldColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(textField.frame), selfWidth/4, textField.frame.size.height)];
    
    label.textAlignment = NSTextAlignmentCenter;
   // label.backgroundColor = [UIColor whiteColor];
   // label.alpha = 0.4;
    label.text = labelText;
    label.textColor = [UIColor whiteColor];
    UIColor *color1 = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dengbg.jpg"]];
    textField.backgroundColor = color;
    label.font = [UIFont systemFontOfSize:15];
    
    label.backgroundColor = color1;
    
    [self.backScrollView addSubview:textField];
    
    [self.backScrollView addSubview:label];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.number resignFirstResponder];
    
    [self.phoneNumber resignFirstResponder];
    
    [self.password resignFirstResponder];
    
    [self.twoPassword resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
