//
//  TypeSelectedViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/21.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passSelectedType <NSObject>

-(void)passType:(NSString *)aType;
-(void)passtypeId:(NSArray *)aid;

@end

@interface TypeSelectedViewController : UIViewController

@property (nonatomic,strong) UIView *prompView;
@property (nonatomic,strong) UILabel *lblPromp;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) NSArray *typeidStr;


@property (nonatomic,assign) id<passSelectedType> delegate;

@end
