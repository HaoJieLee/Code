//
//  LaunchDemo.h
//  LaunchDemo
//
//  Created by 赵良育 on 15/12/19.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JRApperaStyle) {
	JRApperaStyleNone,
	JRApperaStyleOne,
};

typedef NS_ENUM(NSUInteger, JRDisApperaStyle) {
	JRDisApperaStyleNone,
	JRDisApperaStyleOne,
	JRDisApperaStyleTwo,
	JRDisApperaStyleLeft,
	JRDisApperaStyleRight,
	JRDisApperaStyleBottom,
	JRDisApperaStyleTop,
};

@interface LaunchDemo : NSObject

@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, strong) UILabel		*desLabel;
@property (nonatomic, assign) CGRect desLabelFreme;

- (void)loadLaunchImage:(NSString *)imageName;

- (void)loadLaunchImage2:(NSString *)imageName iconName:(NSString *)icon;


- (void)loadLaunchImage:(NSString *)imgName
			   iconName:(NSString*)iconName
			appearStyle:(JRApperaStyle)style
				bgImage:(NSString *)bgName
			  disappear:(JRDisApperaStyle)disappear
		 descriptionStr:(NSString *)des;

@end
