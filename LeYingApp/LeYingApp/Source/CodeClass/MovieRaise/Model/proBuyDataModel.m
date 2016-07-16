//
//  proBuyDataModel.m
//  乐影
//
//  Created by LiuChenhao on 16/3/22.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "proBuyDataModel.h"

@implementation proBuyDataModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
   
    if ([key isEqualToString:@"id"])
    {
        self.Id = value;
    }
}
@end
