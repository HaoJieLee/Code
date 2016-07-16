//
//  getActivityList.m
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "getActivityList.h"

@implementation getActivityList


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.DDescription = value;
    }
}




@end
