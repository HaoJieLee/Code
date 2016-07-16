//
//  IdentityViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/7/8.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^IdentityBlock)(NSString *str);
@interface IdentityViewController : UIViewController
@property (nonatomic,strong)IdentityBlock block;
@property (nonatomic,copy)NSString *identityString;
@end
