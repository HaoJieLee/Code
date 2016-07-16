//
//  detailModel.m
//  乐影
//
//  Created by LiuChenhao on 16/3/24.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "detailModel.h"

@implementation detailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
}


@end
