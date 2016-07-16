//
//  loginModel.m
//  乐影
//
//  Created by LiuChenhao on 16/7/3.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "loginModel.h"

@implementation loginModel
+(loginModel*)grobleLoginModel{
    static loginModel *only;
    if (only==nil) {
        only = [[loginModel alloc]init];
    }
    return only;
}
@end
