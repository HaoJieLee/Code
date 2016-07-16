//
//  ArtistNameViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/21.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passNameDelegate <NSObject>

-(void)passName:(NSString *)aName;

@end

@interface ArtistNameViewController : UIViewController

@property (nonatomic,strong) UITextField *txtFieldName;

@property (nonatomic,assign) id<passNameDelegate> delegate;

@property (nonatomic,strong) NSString *strName;

@end
