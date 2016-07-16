//
//  ShowsModelCollectionViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

// 艺人相册界面



@interface ShowsModelCollectionViewController : UICollectionViewController
@property(nonatomic,strong)NSString *showIndex;
@property (nonatomic,assign) CGSize collectionViewSizeNew;
@property (nonatomic,strong)NSMutableArray *photoArray;//照片数组
@property (nonatomic,copy)NSString *mypicStr;//模特卡
@end
