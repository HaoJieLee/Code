//
//  ArtistSexViewController.h
//  乐影
//
//  Created by zhaoHm on 16/3/21.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol passSexDelegate <NSObject>

-(void)passSex:(NSString *)sex;

@end

@interface ArtistSexViewController : UIViewController

@property (nonatomic,strong) UIView *manView;
@property (nonatomic,strong) UILabel *lblManSex;
@property (nonatomic,strong) UIImageView *imgMan;
@property (nonatomic,strong) UIView *womanView;
@property (nonatomic,strong) UILabel *lblWomanSex;
@property (nonatomic,strong) UIImageView *imgWoman;

@property (nonatomic,assign) id<passSexDelegate> delegate;

@property (nonatomic,strong) NSString *strSex;

@end
