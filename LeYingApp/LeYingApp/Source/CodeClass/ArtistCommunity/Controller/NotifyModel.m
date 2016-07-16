//
//  NotifyModel.m
//  乐影
//
//  Created by LiuChenhao on 16/6/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "NotifyModel.h"

@implementation NotifyModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}
@end
