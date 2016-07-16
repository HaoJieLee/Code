//
//  WaresDetailViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/7/3.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WaresDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *productTableView;
@property(nonatomic, strong)NSMutableArray *productList;


@property (nonatomic,copy)NSString *buyId;//货物id
@property (nonatomic,copy)NSString *buytype;//货物类型
@property (nonatomic,copy)NSString *imgUrl;//货物图片
@property (nonatomic,copy)NSString *title;//货物标题
@property (nonatomic,copy)NSString *price;//货物价格
@property (nonatomic,copy)NSString *remain;//货物剩余数量
@property (nonatomic,copy)NSString *limitDate;//货物截止时间

@end
