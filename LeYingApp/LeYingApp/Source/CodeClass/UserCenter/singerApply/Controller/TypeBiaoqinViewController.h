//
//  TypeBiaoqinViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/22.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passBiaoqianDelegate <NSObject>

-(void)passBiaoqian:(NSString *)aBiaoqian;
-(void)passBiaoqianId:(NSString *)aid;

@end

@interface TypeBiaoqinViewController : UIViewController

@property (nonatomic,strong) UIView *prompView;
@property (nonatomic,strong) UILabel *lblPromp;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) NSString *biaoqianIdStr;


@property (nonatomic,strong) id<passBiaoqianDelegate> delegate;

@end
