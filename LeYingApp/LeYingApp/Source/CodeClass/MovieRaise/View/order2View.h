//
//  order2View.h
//  乐影
//
//  Created by LiuChenhao on 16/3/30.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface order2View : UIView


@property (nonatomic,strong)SDCycleScrollView *topPic;

@property (nonatomic,strong)UIScrollView *myScrView;

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)UIImageView *topImage;

@property (nonatomic,strong)UILabel *titLab;
//@property (nonatomic,strong)UILabel *detailLab;

// 自适应高度
@property (nonatomic,strong) UIWebView *detailWeb;
// 展开按钮
@property (nonatomic,strong) UIButton *btnShowDetail;


@property (nonatomic,strong)UILabel *monLabel;
@property (nonatomic,strong)UIButton *moreBtn;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)UIButton *reduceBtn;
@property (nonatomic,strong)UILabel *mountLab;
@property (nonatomic,strong)UIButton *addBtn;
@property (nonatomic,strong)UILabel *consigneeLab;
@property (nonatomic,strong)UITextField *consigneeText;
@property (nonatomic,strong)UILabel *phoneLab;
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UILabel *addressLab;
@property (nonatomic,strong)UITextField *addressText;

@property (nonatomic,strong)UITextView *messageText;
@property (nonatomic,strong)UILabel *playholdLab;
@property (nonatomic,strong)UILabel *totlelab2;
@property (nonatomic,strong)UILabel *showMassageLab;
@property (nonatomic,strong)UILabel *totalLab;
@property (nonatomic,strong)UILabel *allLab;
@property (nonatomic,strong)UIButton *affirmBtn;



@end
