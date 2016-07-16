//
//  buyModel.m
//  乐影
//
//  Created by LiuChenhao on 16/7/2.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "buyModel.h"

@implementation buyModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"descrition"])
    {
        self.Description = value;
    }
}

@end
