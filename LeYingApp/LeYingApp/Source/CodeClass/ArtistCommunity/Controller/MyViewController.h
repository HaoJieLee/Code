//
//  MyViewController.h
//  Heng
//
//  Created by 赵良育 on 16/4/1.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController
@property(nonatomic,strong)NSString  * imageString;

//@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

// 透明度背景
@property (nonatomic,strong) UIView *myView;

// 图标
@property (nonatomic,strong) UIImageView *imgIcon;

// 昵称
@property (nonatomic,strong) UILabel *lblNicheng;

// 三围
@property (nonatomic,strong) UILabel *lblSanwei;

// 显示昵称    昵称:良玉
@property (nonatomic,strong) NSString *strMessage;

// 显示三围等数据
@property (nonatomic,strong) NSString *strSanweiMes;

@end
