//
//  GonglingViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/5/4.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GonglingBlock)(NSString *str);

@interface GonglingViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) GonglingBlock mBlock;

@property (nonatomic,strong) NSString *strGongling;

@end
