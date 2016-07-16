//
//  NameAndIdViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/7/11.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^userNameAndId) (NSString *string);
@interface NameAndIdViewController : UIViewController
@property (nonatomic,copy)userNameAndId  userName;

@end
