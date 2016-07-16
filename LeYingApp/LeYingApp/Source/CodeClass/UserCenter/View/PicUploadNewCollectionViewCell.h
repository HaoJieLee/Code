//
//  PicUploadCollectionViewCell.h
//  乐影
//
//  Created by zhaoHm on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMButton.h"

@interface PicUploadNewCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imgCategory;

// 删除按钮
@property (nonatomic,strong) HMButton *btnDelete;

@end
