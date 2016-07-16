//
//  MeItemCollectionViewCell.h
//  YHXZ
//
//  Created by LiuChenhao on 16/6/27.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeItemModel.h"
@interface MeItemCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *itemNameLabel;
@property (nonatomic,strong)UIImageView *itemImage;
@property (nonatomic,strong)UILabel *MessageCount;
@property (nonatomic,strong)UIImageView *lineImage;
- (id)initWithFrame:(CGRect)frame;
- (void)setCollectionViewCellData:(MeItemModel*)model;

@end
