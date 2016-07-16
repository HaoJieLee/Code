//
//  WeixinViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/23.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WeixinNumberBlock)(NSString *str);

@interface WeixinViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) WeixinNumberBlock mBlock;

@property (nonatomic,strong) NSString *strWeixin;

@end
