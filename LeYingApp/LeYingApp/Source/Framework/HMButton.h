//
//  HMButton.h
//  乐影
//
//  Created by zhaoHm on 16/3/22.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMButton : UIButton

@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL isWeixin;
@property (nonatomic,assign) BOOL isTel;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
