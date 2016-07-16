//
//  SubDataTableViewController.h
//  乐影
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubDataTableViewController : UITableViewController
@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) NSArray * dataSourceTitle;//tableView标题,外界传入;
@property (nonatomic, strong) NSMutableDictionary *dataSource;//数据源字典
@property (nonatomic) CGRect tableViewFrame;//tableView的坐标
@property (nonatomic) CGFloat superOffsetY; //主视图的偏移量,没有大于一定程度,禁止tableView滑动
- (instancetype)initWithFrame:(CGRect)frame;
@end
