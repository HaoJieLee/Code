//
//  MeItemModel.m
//  YHXZ
//
//  Created by LiuChenhao on 16/6/27.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import "MeItemModel.h"

@implementation MeItemModel
- (id)initWithImageName:(NSString *)image Name:(NSString *)name Url:(NSString*)url{
    if (self = [super init]) {
        _imageName = image;
        _itemName = name;
        _urlID = url;
    }
    return self;
}
@end
