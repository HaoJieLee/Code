//
//  XingzhiViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/5/4.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XingzhiBlock)(NSString *str);

@interface XingzhiViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) XingzhiBlock mBlock;

@property (nonatomic,strong) NSString *strXingzhi;

@end
