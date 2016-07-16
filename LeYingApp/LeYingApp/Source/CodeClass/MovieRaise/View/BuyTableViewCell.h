//
//  BuyTableViewCell.h
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "buyModel.h"
typedef void (^BuyButton)();
@interface BuyTableViewCell : UITableViewCell
@property (nonatomic,strong)BuyButton button;
@property (nonatomic,strong)UIImageView * waresShowImage;//货物图片
@property (nonatomic,strong)UILabel * waresTitleLable;//货物标题
@property (nonatomic,strong)UILabel *unitpriceLable;//@"单价"
@property (nonatomic,strong)UILabel *unitpriceShowLable;//货物价格
@property (nonatomic,strong)UILabel * waresAmountLable;//@“剩余货数量”
@property (nonatomic,strong)UILabel *waresAmountShowLb;//剩余货物量
//@property (nonatomic,strong)UILabel *endTimeLable;//交易@"截止时间"
//@property (nonatomic,strong)UILabel *endTimeShowLab;//@"截止时间"
@property (nonatomic,strong)UIButton * waresDetailBtn;//货物购买按钮
@property (nonatomic,strong)UILabel *waresDetailLabel;//货物详情介绍

- (void)setWaresDataSourceWithModel:(buyModel*)model;




@end
