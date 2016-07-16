//
//  SwitchButton.h
//  乐影
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SwitchButton : NSObject

@property (strong, nonatomic) UISwitch *witch1;
@property (strong, nonatomic) UISwitch *witch2;
@property (strong, nonatomic) UISwitch *witch3;
@property (strong, nonatomic) UISwitch *witch4;
@property (nonatomic)float scle;//屏幕比例
+(instancetype) shareSwich;

@end
