//
//  ArtEventDetailsViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passNameDelegate <NSObject>

-(void)passName:(NSString *)aName WithIndexPath:(NSIndexPath *)index;

@end

@interface ArtEventDetailsViewController : UIViewController
@property (nonatomic,strong)NSString *myId;

@property (nonatomic,assign) id<passNameDelegate> delegate;

@property (nonatomic,strong) NSIndexPath *indexPathy;

@end
