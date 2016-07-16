//
//  MeViewController.m
//  YHXZ
//
//  Created by LiuChenhao on 16/6/27.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import "MeViewController.h"
#import "MeItemModel.h"
#import "MeItemCollectionViewCell.h"
#import "HeadImageViewController.h"
#import "MyMessageViewController.h"
#import "MyAttentionViewController.h"
#import "RechargeViewController.h"
#import "ShopViewController.h"
#import "BuyViewController.h"
#import "GiftViewController.h"
#import "LikeViewController.h"
#import "OptionsViewController.h"
#import "UnreadMessagesViewController.h"
#import "WithdrawalViewController.h"




@interface MeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UIView *MeView;//个人信息的View
@property (nonatomic,strong)UICollectionView *collectionView;//我的界面下面的collection
@property (nonatomic,strong)UIButton *personInformationButton;//头像
@property (nonatomic,strong)UIImageView *certifyImageView;//已认证
@property (nonatomic,strong)UIImageView *sexImageView;//性别
@property (nonatomic,strong)UILabel *MeNameLabel;//姓名

@property (nonatomic,strong)UILabel *statusLabel1;//身份（演员）
@property (nonatomic,strong)UILabel *statusLabel2;//身份（模特）
@property (nonatomic,strong)UILabel *statusLabel3;//身份（艺人）
@property (nonatomic,strong)UILabel *statusLabel4;//身份（歌手）

@property (nonatomic,strong)UILabel *personLabel1;//（性感）
@property (nonatomic,strong)UILabel *personLabel2;//优雅
@property (nonatomic,strong)UILabel *personLabel3;//高贵
@property (nonatomic,strong)UILabel *personLabel4;//纯
@property (nonatomic,strong)NSMutableArray *statusArray;//身份数组
@property (nonatomic,strong)NSMutableArray *personArray;//性格数组（性感）
@property (nonatomic,strong)NSMutableArray *collectionDataSource;//collection内容
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation MeViewController

- (UIScrollView*)scrollView{
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.userInteractionEnabled=YES;
    }
    return _scrollView;
}
- (void)presentLoginController{
   
    JoinViewController *joinVc = [[JoinViewController alloc]init];
    [self.navigationController pushViewController:joinVc animated:YES];
}

- (void)setNavagationItem{
    //消除CELL的条纹
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.navigationItem.title = @"个人中心";
    NSString *navBackgroundBarImage = [[NSBundle mainBundle] pathForResource:@"sytopd"ofType:@"png"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:navBackgroundBarImage] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:239/255.0 alpha:1.0];
    // Do any additional setup after loading the view.
    
    // 我的界面 导航栏 左信息 右设置
    //导航栏左信息按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"消息(3).png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(LeftAnswerBarButton)];
    //导航栏右设置按钮
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"设置白色.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(RightSetBarButton)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self presentLoginController];
    
    [self setNavagationItem];
    [self addDataSource];
    [self.view addSubview:self.scrollView];
    
    
    
    self.personArray = [[NSMutableArray alloc]initWithObjects:@"演员",@"模特",@"性感",@"优雅",nil];
    self.statusArray = [[NSMutableArray alloc]initWithObjects:@"高贵",nil];
    [self.scrollView addSubview:self.MeView];
    
    [self.scrollView addSubview:self.collectionView];
     self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _collectionView.frame.size.height+300);
    
    
    
}
- (void)addDataSource{
    self.collectionDataSource = [[NSMutableArray alloc]init];
    MeItemModel *model1 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_chat.png" Name:@"消息" Url:@""];
    MeItemModel *model2 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_follow.png" Name:@"关注的人" Url:@""];
    MeItemModel *model3 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_charge.png" Name:@"充值" Url:@""];
    MeItemModel *model4 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_announcement.png" Name:@"我的通告" Url:@""];
    MeItemModel *model5 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_buy.png" Name:@"我的购买" Url:@""];
    MeItemModel *model6 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_gift.png" Name:@"礼物" Url:@""];
    MeItemModel *model7 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_favorite.png" Name:@"收藏" Url:@""];
    MeItemModel *model8 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_profile.png" Name:@"修改资料" Url:@""];
    MeItemModel *model9 = [[MeItemModel alloc]initWithImageName:@"ic_me_grid_withdrawal.png" Name:@"提现" Url:@""];
    [self.collectionDataSource addObjectsFromArray:@[model1,model2,model3,model4,model5,model6,model7,model8,model9]];
}

#pragma 我的左侧消息按钮
- (void)LeftAnswerBarButton{
     UnreadMessagesViewController *UnreadMessages = [[UnreadMessagesViewController alloc]init];
    UnreadMessages.title = @"未读消息";
    UnreadMessages.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:UnreadMessages animated:YES];
    NSLog(@"左");
}

#pragma 我的右侧设置按钮
- (void)RightSetBarButton{
    NSLog(@"右");
    OptionsViewController *Options = [[OptionsViewController alloc]init];
    Options.title = @"设置";
    Options.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:Options animated:YES];
}

-(UIView*)MeView{
    if (_MeView==nil) {
        if (iPhone4s) {
            _MeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,280)];
        }else if (iPhone5){
            _MeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,300)];
        }else if (iPhone6){
            _MeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375,300)];
        }else if (iPhone6p){
            _MeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414,300)];
        }
        [self setPersonBasicInformation];
        [self addStatusArrayData];
        [self addPersonArrayData];
        
        _MeView.backgroundColor =  [UIColor colorWithRed:252/255.0 green:82/255.0 blue:117/255.0 alpha:1.0];
    }
    return _MeView;
    
 }
- (void)setPersonBasicInformation{
    
    UIImageView *headImage;
    if (iPhone4s) {
        self.personInformationButton = [[UIButton alloc]initWithFrame:CGRectMake(110, 50 , 100, 100)];
       
        self.MeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 160, 80, 35)];
        self.sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(190, 160, 30, 30)];
        headImage = [[UIImageView alloc]initWithFrame:CGRectMake(110, 50 , 100, 100)];
    }else if (iPhone5){
        self.personInformationButton = [[UIButton alloc]initWithFrame:CGRectMake(110,60, 100, 100)];
        self.MeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 170, 80, 35)];
        self.sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(190, 170, 30, 30)];
         headImage = [[UIImageView alloc]initWithFrame:CGRectMake(110, 60 , 100, 100)];
    }else if (iPhone6){
        self.personInformationButton = [[UIButton alloc]initWithFrame:CGRectMake(137, 60 , 100, 100)];
        self.MeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(127, 170, 80, 35)];
        self.sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(217, 170, 30, 30)];
         headImage = [[UIImageView alloc]initWithFrame:CGRectMake(137, 60 , 100, 100)];
    }else if (iPhone6p){
        self.personInformationButton = [[UIButton alloc]initWithFrame:CGRectMake(157,60, 100, 100)];
        self.MeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(142, 170, 80, 35)];
        self.sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(232, 170, 30, 30)];
         headImage = [[UIImageView alloc]initWithFrame:CGRectMake(157, 60 , 100, 100)];
    }
    
    self.personInformationButton.layer.cornerRadius = 34;
#pragma need 头像
    [headImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"both1.png"]];
    [self.personInformationButton setBackgroundImage:[UIImage imageNamed:@"both1"] forState:UIControlStateNormal];
 [self.personInformationButton addTarget:self action:@selector(checkPersonInformation) forControlEvents:UIControlEventTouchUpInside];
#pragma need 性别
    self.sexImageView.image = [UIImage imageNamed:@"both1.png"];
    [self.MeNameLabel setText:@"李成元"];
    self.MeNameLabel.font = [UIFont systemFontOfSize:25];
    self.MeNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.MeNameLabel setTextColor:[UIColor whiteColor]];
    [_MeView addSubview:self.personInformationButton];
    [_MeView addSubview:self.MeNameLabel];
    [_MeView addSubview:self.sexImageView];
}

#pragma 头像跳转
- (void)checkPersonInformation{
    HeadImageViewController *Tx = [[HeadImageViewController alloc]init];
    Tx.title = @"修改资料";
    Tx.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:Tx animated:YES];
    NSLog(@"ddddd");
    
}


//用户身份信息
- (void)addPersonArrayData{
    NSArray *array = [NSArray arrayWithArray:self.personArray];
    int viewHeight;
    float weithScne = 0.0;
    //标签高起始位置
    if (iPhone4s) {
        viewHeight=200;
    }else{
        viewHeight=250;
    }
    //标签宽起始位置
    
    if (iPhone4s || iPhone5) {
        weithScne =1;
    }else if (iPhone6){
        weithScne = 375.0/320.0;
    }else if (iPhone6p){
        weithScne = 414.0/320.0;
    }
    switch (array.count) {
        case 1:
        {
            self.personLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(145*weithScne, viewHeight, 30, 30)];
            
            self.personLabel1.text= @"演员";
            self.personLabel1.font = [UIFont systemFontOfSize:14];
            [self.personLabel1 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.personLabel1];
        }
            break;
        case 2:
        {
            self.personLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(119*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(159*weithScne, viewHeight, 2, 30)];
            self.personLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(171, viewHeight, 30, 30)];
            [self.personLabel1 setText:@"演员"];
            self.personLabel1.font = [UIFont systemFontOfSize:14];
            [self.personLabel1 setTextColor:[UIColor whiteColor]];
            
            [self.personLabel2 setText:@"演员"];
            self.personLabel2.font = [UIFont systemFontOfSize:14];
            [self.personLabel2 setTextColor:[UIColor whiteColor]];

            [_MeView addSubview:self.personLabel1];
            [_MeView addSubview:lineImage];
            [_MeView addSubview:self.personLabel2];

        }
            break;
        case 3:
        {
            self.personLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(94*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(134*weithScne, viewHeight, 2, 30)];
            self.personLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(146*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(186*weithScne, viewHeight, 2, 30)];
            self.personLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(198*weithScne, viewHeight, 30, 30)];
            [self.personLabel1 setText:@"演员"];
            self.statusLabel1.font = [UIFont systemFontOfSize:14];
            [self.personLabel1 setTextColor:[UIColor whiteColor]];

            [self.personLabel2 setText:@"演员"];
            self.personLabel2.font = [UIFont systemFontOfSize:14];

            [self.personLabel2 setTextColor:[UIColor whiteColor]];
            
            [self.personLabel3 setText:@"演员"];
            self.personLabel3.font = [UIFont systemFontOfSize:14];
            [self.personLabel3 setTextColor:[UIColor whiteColor]];

            [_MeView addSubview:self.personLabel1];
            [_MeView addSubview:lineImage1];
            [_MeView addSubview:self.personLabel2];
            [_MeView addSubview:lineImage2];
            [_MeView addSubview:self.personLabel3];
        }
            break;
        case 4:
        {
            self.personLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(67*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(107*weithScne, viewHeight, 2, 30)];
            self.personLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(119*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(159*weithScne, viewHeight, 2, 30)];
            self.personLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(171*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(211*weithScne, viewHeight, 2, 30)];
            self.personLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(223*weithScne, viewHeight, 30, 30)];
            
            [self.personLabel1 setText:@"演员"];
            self.personLabel1.font = [UIFont systemFontOfSize:14];
            [self.personLabel1 setTextColor:[UIColor whiteColor]];

            [self.personLabel2 setText:@"演员"];
            self.personLabel2.font = [UIFont systemFontOfSize:14];
            [self.personLabel2 setTextColor:[UIColor whiteColor]];

            [self.personLabel3 setText:@"演员"];
            self.personLabel3.font = [UIFont systemFontOfSize:14];
            [self.personLabel3 setTextColor:[UIColor whiteColor]];

            [self.personLabel4 setText:@"演员"];
            self.personLabel4.font = [UIFont systemFontOfSize:14];
            [self.personLabel4 setTextColor:[UIColor whiteColor]];

            [_MeView addSubview:self.personLabel1];
            [_MeView addSubview:lineImage1];
            [_MeView addSubview:self.personLabel2];
            [_MeView addSubview:lineImage2];
            [_MeView addSubview:self.personLabel3];
            [_MeView addSubview:lineImage3];
            [_MeView addSubview:self.personLabel4];
            
        }
            break;
            
        default:
            break;
    }
    

}
#pragma mark 用户个性信息
- (void)addStatusArrayData{
    NSArray *array = [NSArray arrayWithArray:self.statusArray];
    int viewHeight;
    double weithScne = 0.000000;
    //标签高起始位置
    if (iPhone4s) {
        viewHeight=200;
    }else{
        viewHeight=210;
    }
    //标签宽起始位置
    
    if (iPhone4s || iPhone5) {
        weithScne =1;
    }else if (iPhone6){
        weithScne = 375.0/320.0;
    }else if (iPhone6p){
        weithScne = 414.0/320.0;
    }
    switch (array.count) {
        case 1:
        {
            self.statusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(140*weithScne, viewHeight, 30, 30)];
            [self.statusLabel1 setText:@"演员"];
            self.statusLabel1.font = [UIFont systemFontOfSize:14];

            [self.statusLabel1 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel1];
            
//我的界面竖杠
            UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(185,255,1,20)];
            blackView.backgroundColor = [UIColor whiteColor];
            [_MeView addSubview:blackView];
            

        }
            break;
            
        case 2:
        {
            self.statusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(119*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(159*weithScne, viewHeight, 2, 30)];
            
            self.statusLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(171, viewHeight, 30, 30)];
            [self.statusLabel1 setText:@"演员"];
            self.statusLabel1.font = [UIFont systemFontOfSize:14];

            [self.statusLabel1 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel1];
            [_MeView addSubview:lineImage];
            
            [self.statusLabel2 setText:@"演员"];
            self.statusLabel2.font = [UIFont systemFontOfSize:14];

            [self.statusLabel2 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel2];

        }
            break;
            
        case 3:
        {
            self.statusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(94*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(134*weithScne, viewHeight, 2, 30)];
            self.statusLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(146*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(186*weithScne, viewHeight, 2, 30)];
            self.statusLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(198*weithScne, viewHeight, 30, 30)];
            [self.statusLabel1 setText:@"演员"];
            self.statusLabel1.font = [UIFont systemFontOfSize:14];
            
            [self.statusLabel1 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel1];
            [_MeView addSubview:lineImage1];
            
            UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(171,viewHeight,30,30)];
            whiteView.backgroundColor = [UIColor blackColor];
            [_MeView addSubview:whiteView];

            [self.statusLabel2 setText:@"演员"];
            self.statusLabel2.font = [UIFont systemFontOfSize:14];

            [self.statusLabel2 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel2];
            [_MeView addSubview:lineImage2];
            [self.statusLabel3 setText:@"演员"];
            self.statusLabel3.font = [UIFont systemFontOfSize:14];

            [self.statusLabel3 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel3];
        }
            break;
            
        case 4:
        {
            self.statusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(67*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(107*weithScne, viewHeight, 2, 30)];
            lineImage1.image = [[UIImage imageNamed:@"黑色竖条.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            
            self.statusLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(119*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(159*weithScne, viewHeight, 2, 30)];
            self.statusLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(171*weithScne, viewHeight, 30, 30)];
            UIImageView *lineImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(211*weithScne, viewHeight, 2, 30)];
            self.statusLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(223*weithScne, viewHeight, 30, 30)];
            [self.statusLabel1 setText:@"演员"];
            self.statusLabel1.font = [UIFont systemFontOfSize:14];
            [self.statusLabel1 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel1];
            [_MeView addSubview:lineImage1];
            [self.statusLabel2 setText:@"演员"];
            self.statusLabel2.font = [UIFont systemFontOfSize:14];
            [self.statusLabel2 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel2];
            [_MeView addSubview:lineImage2];
            [self.statusLabel3 setText:@"演员"];
            self.statusLabel3.font = [UIFont systemFontOfSize:14];

            [self.statusLabel3 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel3];
            [_MeView addSubview:lineImage3];
            [self.statusLabel4 setText:@"演员"];
            self.statusLabel4.font = [UIFont systemFontOfSize:14];

            [self.statusLabel4 setTextColor:[UIColor whiteColor]];
            [_MeView addSubview:self.statusLabel4];
        }
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark 下面的collection
- (UICollectionView *)collectionView{
    NSInteger count = self.collectionDataSource.count;
    NSInteger i ;
    if (count%3==0) {
        i = count/3+1;
    }else{
        i = count/3+2;
    }
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        if (iPhone4s) {
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 295, 320, 108*i) collectionViewLayout:flowLayout];
            _collectionView.alwaysBounceVertical = YES;
            _collectionView.delegate   = self;
            _collectionView.dataSource = self;
            _collectionView.bounces    = NO;
        }
        else if (iPhone5){
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 305, 320, 108*i) collectionViewLayout:flowLayout];
            _collectionView.alwaysBounceVertical = YES;
            _collectionView.delegate   = self;
            _collectionView.dataSource = self;
            _collectionView.bounces    = NO;

        }
        else if (iPhone6){
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 305, 375, 126*i) collectionViewLayout:flowLayout];
            _collectionView.alwaysBounceVertical = YES;
            _collectionView.delegate   = self;
            _collectionView.dataSource = self;
            _collectionView.bounces    = NO;

        }
        else if (iPhone6p){
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 305, 414, 137*i) collectionViewLayout:flowLayout];
            _collectionView.alwaysBounceVertical = YES;
            _collectionView.delegate   = self;
            _collectionView.dataSource = self;
            _collectionView.bounces    = NO;

        }
        _collectionView.backgroundColor = [UIColor colorWithRed:237/255.0 green:238/255.0 blue:239/255.0 alpha:1.0];
        [self addCollectionViewCell];
    }
   
    return _collectionView;
}
- (void)addCollectionViewCell{
    [_collectionView registerClass:[MeItemCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
}
#pragma UICollectionViewDelegate,UICollectionViewDataSource;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionDataSource.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MeItemCollectionViewCell *ItemCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    //隐藏我的1数组
    ItemCell.MessageCount.hidden = YES;
//    [ItemCell sizeToFit];
    MeItemModel *model = [self.collectionDataSource objectAtIndex:indexPath.row];
    [ItemCell setCollectionViewCellData:model];
    return ItemCell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (iPhone4s||iPhone5) {
        return CGSizeMake(105, 105);
    }else if (iPhone6){
        return CGSizeMake(124, 124);
    }else if (iPhone6p){
        return CGSizeMake(137, 137);
    }
    return CGSizeMake(0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1.0f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0f;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
       MyMessageViewController *Message = [[MyMessageViewController alloc]init];
       Message.title = @"消息";
        Message.hidesBottomBarWhenPushed=YES;
        
       [self.navigationController pushViewController:Message animated:YES];
    }
    
    if(indexPath.row == 1){
        
        MyAttentionViewController *Attention = [[MyAttentionViewController alloc]init];
        Attention.title = @"关注的人";
        Attention.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Attention animated:YES];
    }
    
    if(indexPath.row == 2){
        
        RechargeViewController *Recharge = [[RechargeViewController alloc]init];
        Recharge.title = @"充值";
        Recharge.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Recharge animated:YES];
    }
    
    if(indexPath.row == 3){
        
        ShopViewController *Shop = [[ShopViewController alloc]init];
        Shop.title = @"我的通告";
        Shop.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Shop animated:YES];
    }
    
    
    if(indexPath.row == 4){
        
        BuyViewController *Buy = [[BuyViewController alloc]init];
        Buy.title = @"我的购买";
        Buy.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Buy animated:YES];
    }
    
    if(indexPath.row == 5){
        
        GiftViewController *Gift = [[GiftViewController alloc]init];
        Gift.title = @"礼物";
        Gift.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Gift animated:YES];
    }
    
    if(indexPath.row == 6){
        
        LikeViewController *Like = [[LikeViewController alloc]init];
        Like.title = @"收藏";
        Like.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Like animated:YES];
    }
    
    if(indexPath.row == 7){
        
        HeadImageViewController *Head = [[HeadImageViewController alloc]init];
        Head.title = @"修改资料";
        Head.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Head animated:YES];
    }
    
    if(indexPath.row == 8){
        
        WithdrawalViewController *Withdrawa = [[WithdrawalViewController alloc]init];
        Withdrawa.title = @"提现";
        Withdrawa.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:Withdrawa animated:YES];
    }
    
    NSLog(@"puchME");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
