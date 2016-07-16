//
//  LocalViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/23.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passValueBlock)(NSString *str);

@interface LocalViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) passValueBlock mBlock;

@property (nonatomic,strong) NSString *strLocation;

@end
