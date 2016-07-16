//
//  expandModel.m
//  LeYingApp
//
//  Created by sks on 15/12/23.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "expandModel.h"

@implementation expandModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
    if ([key isEqualToString:@"description"])
    {
        self.Description = value;
    }
}





@end
