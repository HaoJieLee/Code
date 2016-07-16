//
//  MySuppostTableViewCell.h
//  LeYingApp
//
//  Created by sks on 15/12/11.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySuppostTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *initiatorLable;
@property (nonatomic,strong)UILabel *initiatorShowLable;
@property (nonatomic,strong)UILabel *stateLable;//状态
@property (nonatomic,strong)UIImageView *showImage;//展示图片
@property (nonatomic,strong)UILabel *showTitLable;//展示标题
@property (nonatomic,strong)UILabel *priceLablel;//价格
@property (nonatomic,strong)UILabel *goodsLable;
@property (nonatomic,strong)UILabel *numberLable;
//@property (nonatomic,strong)UILabel *
@property (nonatomic,strong)UILabel *allLable;//共计
@property (nonatomic,strong)UILabel *allShowLable;
@property (nonatomic,strong)UILabel *freightLable;
@property (nonatomic,strong)UILabel *freightShowLable;//运费
@property (nonatomic,strong)UIButton *deleteBtn;//删除订单
@property (nonatomic,strong)UIButton *paymentBtn;//确认付款

@end
