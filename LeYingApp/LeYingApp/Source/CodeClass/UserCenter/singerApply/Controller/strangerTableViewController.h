//
//  strangerTableViewController.h
//  乐影
//
//  Created by LiuChenhao on 16/4/25.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface strangerTableViewController : UITableViewController

//路人申请界面
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UIImageView *headImage;//图像
@property (nonatomic,strong)UIImageView *headImage1;
@property (nonatomic,strong)UILabel *nameLable;//名字
@property (nonatomic,strong)UILabel *numberLab;//编号
@property (nonatomic,strong)UILabel *numberShowLab;//编号展示
@property (nonatomic,strong)UIImageView *sexImage;//性别标签
@property (nonatomic,strong)UILabel *markLab;//标签
@property (nonatomic,strong)UIImageView *collectImage;//收藏
@property (nonatomic,strong)UIImageView *shareImage;//分享
@property (nonatomic,strong)UILabel *introduceLable;//签名



@end
