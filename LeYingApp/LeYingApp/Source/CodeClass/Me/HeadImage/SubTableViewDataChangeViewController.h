//
//  SubTableViewDataChangeViewController.h
//  乐影
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    SubTableTypeStyleName = 0,//Name
    SubTableTypeStyleStyle,
    SubTableTypeStyleBar,
    SubTableTypeStyleID,
    SubTableTypeStyleHeight,
    SubTableTypeStyleWeight,
    SubTableTypeStyleBWH,
    SubTableTypeStyleShoe,
    SubTableTypeStylePhone,
    SubTableTypeStyleWeiChat,
    SubTableTypeStyleQQ,
    SubTableTypeStyleMail,
    SubTableTypeStyleSignature,
    SubTableTypeStyleIntroduction,
} SubTableTypeStyle;
@interface SubTableViewDataChangeViewController : UIViewController
- (instancetype)initWith:(SubTableTypeStyle)style;
@end
