//
//  projectList.m
//  LeYingApp
//
//  Created by sks on 15/12/22.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "projectList.h"

@implementation projectList

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"descrition"])
    {
        self.Description = value;
    }
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
}



@end
