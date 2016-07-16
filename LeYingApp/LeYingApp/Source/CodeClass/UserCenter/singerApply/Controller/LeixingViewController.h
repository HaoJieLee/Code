//
//  LeixingViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/5/4.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeixingBlock)(NSString *str);

@interface LeixingViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) LeixingBlock mBlock;

@property (nonatomic,strong) NSString *strLeixing;

@end
