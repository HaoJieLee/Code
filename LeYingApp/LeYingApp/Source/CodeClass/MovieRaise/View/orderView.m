//
//  orderView.m
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "orderView.h"

@implementation orderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self p_SetupUI];
    }
    return self;
}

-(void)p_SetupUI
{
    //设置最底部Scrollow
    self.myScrView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.myScrView.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f blue:222/255.0f alpha:1.0];
    
    
    
    
    
    
    //顶部背景
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2)];
    self.topView.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f blue:222/255.0f alpha:1.0];
    [self.myScrView addSubview:_topView];
    
    //设置顶部轮播图
    self.topPic = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/4) imageURLStringsGroup:nil];
   
    
    self.topPic.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f blue:222/255.0f alpha:1.0];
    [self.topView addSubview:_topPic];
                   
  
    
    
    //设置标题
    self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(17, CGRectGetMaxY(self.topPic.frame) + 5, CGRectGetWidth(self.frame) - 20, 30)];
    [self.topView addSubview:_titLab];
    
    //详情
    self.detailWeb = [[UIWebView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titLab.frame) + 4, CGRectGetWidth(self.frame) - 20, CGRectGetHeight(self.frame) / 2 - CGRectGetMaxY(self.titLab.frame) - 23)];
//    self.detailLab.numberOfLines = 0;
    [self.topView addSubview:_detailWeb];
    
    
    self.btnShowDetail = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.detailWeb.frame) - 80, CGRectGetMaxY(self.detailWeb.frame) + 3 - 2, 60, CGRectGetHeight(self.frame) / 2 - CGRectGetMaxY(self.detailWeb.frame) - 6 + 4)];
    [self.btnShowDetail setBackgroundImage:[UIImage imageNamed:@"zhankai4.png"] forState:UIControlStateNormal];
//    [self.btnShowDetail setImage:[UIImage imageNamed:@"more.png"] forState:UIControlStateNormal];
//    [self.btnShowDetail setTitle:@"展开" forState:UIControlStateNormal];
    [self.topView addSubview:_btnShowDetail];
    
    //下半部分背景view
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f blue:222/255.0f alpha:1.0];
    [self.myScrView addSubview:_bottomView];
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
    self.myView.backgroundColor = [UIColor colorWithRed:182/255.0f green:187/255.0f blue:190/255.0f alpha:1.0];
    [self.bottomView addSubview:_myView];
    
    //价格设置
    self.monLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 20, 30)];
    self.monLabel.text = @"￥";
    self.monLabel.textColor = [UIColor colorWithRed:229/255.0f green:93/255.0f  blue:8/255.0f  alpha:1.0];
    [self.bottomView addSubview:_monLabel];
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.monLabel.frame),10, CGRectGetWidth(self.frame)/ 2 - 30, 30)];
    self.priceLab.textColor = [UIColor colorWithRed:229/255.0f green:93/255.0f  blue:8/255.0f  alpha:1.0];
    self.priceLab.font = [UIFont systemFontOfSize:18];
    [self.bottomView addSubview:_priceLab];
    
    //增加减少按钮设置
    self.reduceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.reduceBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - 99, 15, 25, 25);
    
    [self.reduceBtn setBackgroundImage:[UIImage imageNamed:@"djian.png"] forState:UIControlStateNormal];
    [self.bottomView addSubview:_reduceBtn];
    
    self.mountLab  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.reduceBtn.frame) + 2, CGRectGetMinY(self.reduceBtn.frame), 30, 25)];
    self.mountLab.backgroundColor = [UIColor colorWithRed:175/255.0f green:183/255.0f blue:185/255.0f alpha:1.0];
    
    self.mountLab.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:_mountLab];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addBtn.frame = CGRectMake(CGRectGetMaxX(self.mountLab.frame) + 2, CGRectGetMinY(self.reduceBtn.frame), 25, 25);
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"djia.png"] forState:UIControlStateNormal];
        [self.bottomView addSubview:_addBtn];
    
    //收货人
    self.consigneeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.priceLab.frame) + 10, 60, 30)];
    self.consigneeLab.font = [UIFont systemFontOfSize:14];
    self.consigneeLab.backgroundColor = [UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    self.consigneeLab.text = @"  收货人:";
    self.consigneeLab.textColor = [UIColor colorWithRed:74/255.0f green:76/255.0f blue:78/255.0f alpha:1.0];
    [self.bottomView addSubview:_consigneeLab];
    
    self.consigneeText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.consigneeLab.frame), CGRectGetMinY(self.consigneeLab.frame), CGRectGetWidth(self.frame) - CGRectGetWidth(self.consigneeLab.frame) - 30, 30)];
    self.consigneeText.backgroundColor = [UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    self.consigneeText.font = [UIFont systemFontOfSize:14];
    [self.bottomView addSubview:_consigneeText];
    
    
    //手机号
    self.phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.consigneeLab.frame) + 5, 60, 30)];
    self.phoneLab.font = [UIFont systemFontOfSize:14];
    self.phoneLab.text = @"  手机号:";
    self.phoneLab.textColor = [UIColor colorWithRed:74/255.0f green:76/255.0f blue:78/255.0f alpha:1.0];
    self.phoneLab.backgroundColor = [UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    [self.bottomView addSubview:_phoneLab];
    
    self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.phoneLab.frame), CGRectGetMinY(self.phoneLab.frame), CGRectGetWidth(self.frame) - CGRectGetWidth(self.phoneLab.frame) - 30, 30)];
    self.phoneText.backgroundColor = [UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    self.phoneText.font = [UIFont systemFontOfSize:14];
    [self.bottomView addSubview:_phoneText];
    
    
    
    
    // 收货地址
    self.addressLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.phoneLab.frame) + 5, 80, 30)];
    self.addressLab.font = [UIFont systemFontOfSize:14];
    self.addressLab.text = @"  收货地址:";
    self.addressLab.textColor = [UIColor colorWithRed:74/255.0f green:76/255.0f blue:78/255.0f alpha:1.0];
    self.addressLab.backgroundColor = [UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    [self.bottomView addSubview:_addressLab];
    
    self.addressText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addressLab.frame), CGRectGetMinY(self.addressLab.frame), CGRectGetWidth(self.frame) - CGRectGetWidth(self.addressLab.frame) - 30, 30)];
    self.addressText.backgroundColor =[UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    self.addressText.font = [UIFont systemFontOfSize:14];
    [self.bottomView addSubview:_addressText ];
    
  
    //留言
    
    self.messageText = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.addressLab.frame) + 5, CGRectGetWidth(self.frame) - 30, 80)];
   
    
    
    
    self.messageText.backgroundColor = [UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    [self.bottomView addSubview:_messageText];
    self.messageText.font = [UIFont systemFontOfSize:14];
    self.playholdLab =[[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.addressLab.frame) + 10, CGRectGetWidth(self.frame) - 20, 20)];
    self.playholdLab.text = @"  给卖家留言:";
    self.playholdLab.textColor = [UIColor colorWithRed:74/255.0f green:76/255.0f blue:78/255.0f alpha:1.0];
    self.playholdLab.font = [UIFont systemFontOfSize:14];
    [self.bottomView addSubview:_playholdLab];
    
    //商品详情标注
    
    self.showMassageLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2 - 30, CGRectGetMaxY(self.messageText.frame) +5, 70, 20)];
    self.showMassageLab.font = [UIFont systemFontOfSize:15];

    self.showMassageLab.textColor = [UIColor colorWithRed:77/255.0f green:79/255.0f blue:79/255.0f alpha:1.0];
    [self.bottomView addSubview:_showMassageLab];
    
    self.totalLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -125 , CGRectGetMinY(self.showMassageLab.frame), 35, 20)];
    self.totalLab.font = [UIFont systemFontOfSize:15];
    self.totalLab.text = @"合计:";
    self.totalLab.textColor =[UIColor colorWithRed:77/255.0f green:79/255.0f blue:79/255.0f alpha:1.0];
    
    [self.bottomView addSubview:_totalLab];
    
    self.totlelab2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -90 , CGRectGetMinY(self.showMassageLab.frame), 10, 20)];
    self.totlelab2.font =[UIFont systemFontOfSize:15];
    self.totlelab2.text = @"￥";
    self.totlelab2.textColor = [UIColor colorWithRed:229/255.0f green:93/255.0f  blue:8/255.0f  alpha:1.0];
    [self.bottomView addSubview:_totlelab2];
    self.allLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -80 + 2 , CGRectGetMinY(self.showMassageLab.frame), 60, 20)];
    self.allLab .font = [UIFont systemFontOfSize:15];
    
    self.allLab.textColor =  [UIColor colorWithRed:229/255.0f green:93/255.0f  blue:8/255.0f  alpha:1.0];
    [self.bottomView addSubview:_allLab];
    

    self.affirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.affirmBtn.frame = CGRectMake(70, CGRectGetMaxY(self.allLab.frame) + 20, CGRectGetWidth(self.frame) -140, 40);
    
    [self.affirmBtn setTitle:@"确  认" forState:UIControlStateNormal];
    [self.affirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.affirmBtn.backgroundColor = [UIColor colorWithRed:181/255.0f green:186/255.0f blue:189/255.0f alpha:1.0];
    
    //设置边缘光滑
    self.affirmBtn.layer.cornerRadius = 20;
    self.clipsToBounds = YES;
    
    
    [self.bottomView addSubview:_affirmBtn];
    
    
    
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), CGRectGetWidth(self.frame), CGRectGetMaxY(self.affirmBtn.frame) + 10);
    
    
    
    
    self.myScrView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetMaxY(self.bottomView.frame) + 260);
    
    [self addSubview:_myScrView];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






@end
