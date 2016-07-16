//
//  UNfinishDetailViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/3/11.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>


// 进行中详情界面
@interface UNfinishDetailViewController : UIViewController

@property (nonatomic,strong)NSString *index;//活动id
@property (nonatomic)int type;//0表示进行中，1表示已完成


@end
