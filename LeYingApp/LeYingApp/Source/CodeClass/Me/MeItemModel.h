//
//  MeItemModel.h
//  YHXZ
//
//  Created by LiuChenhao on 16/6/27.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeItemModel : NSObject
@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString *itemName;
@property (nonatomic,copy)NSString *urlID;
@property (nonatomic,copy)NSString *quantityVolume;//信息数量
- (id)initWithImageName:(NSString *)image Name:(NSString *)name Url:(NSString*)url;
@end
