//
//  ArtistsIntroViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

//  艺人详情  界面
@interface ArtistsIntroViewController : UIViewController
@property (nonatomic,strong)NSString *actsIndex;
@property (nonatomic)int InType;//1是push出来的界面,0是present
@end
