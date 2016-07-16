//
//  QQViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/23.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passQQNumberBlock)(NSString *);

@interface QQViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) passQQNumberBlock mBlock;

@property (nonatomic,strong) NSString *strQQ;

@end
