//
//  FeedbackViewController.h
//  YHXZ
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnTextBlock)(NSString *dateString,NSString *answerText);

@interface FeedbackViewController : UIViewController

@property (nonatomic,strong) ReturnTextBlock block;
@property (nonatomic,assign) int mailId;

@end
