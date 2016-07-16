//
//  SearchModel.m
//  乐影
//
//  Created by LiuChenhao on 16/7/1.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.ID = value;
    }
}

@end
