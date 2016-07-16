//
//  getAddressModel.m
//  LeYingApp
//
//  Created by sks on 15/12/24.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "getAddressModel.h"

@implementation getAddressModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
//    if ([key isEqualToString:@"default"])
//    {
//        self.Default = value;
//    }
}




@end
