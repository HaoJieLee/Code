//
//  QicaiViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/5/4.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QicaiBlock)(NSString *str);

@interface QicaiViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,copy) QicaiBlock mBlock;

@property (nonatomic,strong) NSString *strQicai;

@end
