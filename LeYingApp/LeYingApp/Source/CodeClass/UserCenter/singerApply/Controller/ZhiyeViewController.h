//
//  ZhiyeViewController.h
//  乐影
//
//  Created by zhaoHm on 16/5/9.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LeixingBlock)(NSString *str);

@interface ZhiyeViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) LeixingBlock mBlock;

@property (nonatomic,strong) NSString *strZhiye;

@end
