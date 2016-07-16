//
//  forgetView.m
//  乐影
//
//  Created by LiuChenhao on 16/4/6.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "forgetView.h"

@implementation forgetView

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
    self.backScrollView1 = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backScrollView1.backgroundColor = [UIColor whiteColor];
    self.backScrollView1.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    self.backScrollView1.contentSize = CGSizeMake(CGRectGetWidth(self.frame), 750);
    
    [self addSubview:_backScrollView1];
    
    
    //logo初始化
    self.logImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(selfWidth / 2 - KScreenW/3/2, 40 + 44,KScreenW/3,KScreenW/3 )];
    self.logImage1.image = [UIImage imageNamed:@"logot.png"];
    self.logImage1.layer.cornerRadius =KScreenW/3/2;
    self.logImage1.layer.masksToBounds = YES;
    _userImage = self.logImage1;
    [self.backScrollView1 addSubview:_userImage];
    
    
    
    // 电话号码textField初始化
    self.phoneNumber1 = [[UITextField alloc]initWithFrame:CGRectMake(selfWidth / 4, selfWidth * 2/3, selfWidth * 3 / 4, selfWidth /9)];
    
    self.phoneNumber1.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumber1.backgroundColor = [UIColor whiteColor];
    self.phoneNumber1.alpha = 0.3;
    
    [self mytextField:self.phoneNumber1 myLabelText:@"手机号" myTextFieldColor:[UIColor whiteColor]];
    
    // 验证码textField初始化
    self.number1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.phoneNumber1.frame), CGRectGetMaxY(self.phoneNumber1.frame)+0.8, CGRectGetWidth(self.phoneNumber1.frame), CGRectGetHeight(self.phoneNumber1.frame))];
    
    self.number1.keyboardType = UIKeyboardTypeNumberPad;
    self.number1.backgroundColor = [UIColor whiteColor];
    self.number1.alpha = 0.3;
    
    [self mytextField:self.number1 myLabelText:@"验证码" myTextFieldColor:[UIColor whiteColor]];
    
    // 获取验证码button初始化
    self.getNumberButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    
    self.getNumberButton1.frame = CGRectMake(selfWidth*3/4, self.number1.frame.size.height/8 + CGRectGetMinY(self.number1.frame), selfWidth/4 - 5, self.number1.frame.size.height * 3/4);
    
    self.getNumberButton1.backgroundColor = [UIColor colorWithRed:113/255.0f green:132/255.0f blue:140/255.0f alpha:0.8];
    
    [self.getNumberButton1 setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getNumberButton1.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.getNumberButton1 setTintColor:[UIColor whiteColor]];
    
    [self.backScrollView1 addSubview:_getNumberButton1];
    
    // 密码textField初始化
    self.password1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.number1.frame), CGRectGetMaxY(self.number1.frame)+0.8, CGRectGetWidth(self.number1.frame), CGRectGetHeight(self.number1.frame))];
    
    self.password1.returnKeyType = UIReturnKeyDefault;
    self.password1.backgroundColor = [UIColor whiteColor];
    self.password1.alpha = 0.3;
    
    [self mytextField:self.password1 myLabelText:@"新密码" myTextFieldColor:[UIColor whiteColor]];
    
    self.password1.secureTextEntry = YES;
    
    // 再次输入密码textField初始化
    self.twoPassword1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.password1.frame), CGRectGetMaxY(self.password1.frame)+0.8, CGRectGetWidth(self.password1.frame), CGRectGetHeight(self.password1.frame))];
    
    self.twoPassword1.backgroundColor = [UIColor whiteColor];
    self.twoPassword1.alpha = 0.3;
    
    [self mytextField:self.twoPassword1 myLabelText:@"确认密码" myTextFieldColor:[UIColor whiteColor]];
    
    self.twoPassword1.secureTextEntry = YES;
    
    // 注册button
    
    self.registerButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.registerButton1.frame = CGRectMake(CGRectGetWidth(self.frame)/ 2 - selfWidth*3/5/2, CGRectGetMaxY(self.twoPassword1.frame) + 20, selfWidth *3 /5, self.twoPassword1.frame.size.height);
    
    
    
    [self.registerButton1 setTitle:@"确认修改" forState:UIControlStateNormal];
    
    self.registerButton1.titleLabel.font = [UIFont systemFontOfSize:17];
    self.registerButton1.layer.contents = (id)[UIImage imageNamed:@"loginbg.png"].CGImage;
    
    [self.registerButton1 setTintColor:[UIColor whiteColor]];
    
    //设置边缘光滑
    self.registerButton1.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
    
    [self.backScrollView1 addSubview:_registerButton1];
    
    
    
    
    
    
}
// 封装的 textField 和 label结合的私有方法
-(void)mytextField:(UITextField *)textField myLabelText:(NSString *)labelText myTextFieldColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(textField.frame), selfWidth/4, textField.frame.size.height)];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.alpha = 0.4;
    label.font = [UIFont systemFontOfSize:15];
    label.text = labelText;
    
    textField.backgroundColor = color;
    //label.textColor = [UIColor whiteColor];
    label.backgroundColor = color;
    
    [self.backScrollView1 addSubview:textField];
    
    [self.backScrollView1 addSubview:label];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.number1 resignFirstResponder];
    
    [self.phoneNumber1 resignFirstResponder];
    
    [self.password1 resignFirstResponder];
    
    [self.twoPassword1 resignFirstResponder];
}

@end
