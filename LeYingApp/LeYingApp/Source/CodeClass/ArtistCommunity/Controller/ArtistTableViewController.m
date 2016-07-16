//
//  ArtistTableViewController.m
//  LeYingApp
//
//  Created by sks on 15/12/11.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "ArtistTableViewController.h"
#import "ArtistTableViewCell.h"
#import "SDCycleScrollView.h"
#import "getAboutArtistData.h"
#import "expandModel.h"
#import "getActivityList.h"
#import "getArtists.h"
#import "ArtEventDetailsViewController.h"
#import "myImageView.h"
#import "ArtistsIntroViewController.h"
#import "webViewController.h"
#import "SeachViewController.h"
#import "FindNotifyViewController.h"
#import "NotifyModel.h"
#import "CategoryViewController.h"

#import "CategoryDetailsNewCollectionViewController.h"

@interface ArtistTableViewController ()<SDCycleScrollViewDelegate,passNameDelegate>

@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UIView *midView;
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)NSMutableArray *arr7;
@property (nonatomic,strong)NSDictionary *kindDic;
@property (nonatomic,strong)NSArray *arrAy;
@property (nonatomic,strong)NSArray *expandArr;
@property (nonatomic,strong)NSArray *activityArr;
@property (nonatomic,strong)NSDictionary *artistSortArr;

@property (nonatomic,strong)NSMutableArray *myArr;
@property (nonatomic,strong)NSMutableArray *myArrPic;
@property (nonatomic,strong)NSMutableArray *detailArr;
@property (nonatomic,strong)NSMutableArray *activitArr;
@property (nonatomic,strong)NSDictionary *myDic;
@property (nonatomic,strong)NSMutableArray *myIdArr;

@property (nonatomic,strong) UIView *myView;

@property (nonatomic,strong)NSMutableArray *notifyArray;//通知数组
@end

@implementation ArtistTableViewController


-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)setAllArray{
    self.notifyArray = [NSMutableArray array];
    self.myArr = [NSMutableArray array];
    self.myArrPic = [NSMutableArray array];
    self.detailArr = [NSMutableArray array];
    self.activitArr = [NSMutableArray array];
    self.myIdArr = [NSMutableArray array];
    
    self.arrAy = [NSArray array];
    self.expandArr = [NSArray array];
    self.activityArr = [NSArray array];
    self.artistSortArr = [NSDictionary dictionary];

}
- (void)RightSetBarButton{
    SeachViewController *seachC = [[SeachViewController alloc]init];
//    UINavigationController *NC = [[UINavigationController alloc]initWithRootViewController:seach];
//    NC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:NC animated:YES];
   
    [self presentViewController:seachC animated:YES completion:nil];
}
- (void)setAllNavagationItem{
    //设置背景颜色
    NSString *navBackgroundBarImage = [[NSBundle mainBundle] pathForResource:@"sytopd"ofType:@"png"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:navBackgroundBarImage] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor colorWithRed:182/255.0f green:181/255.0f  blue:175/255.0f alpha:1.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"both1.png"] style:UIBarButtonItemStyleDone target:self action:@selector(RightSetBarButton)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAllNavagationItem];
    [self setAllArray];
    
    //tableview的分割线
    self.tableView.separatorStyle = NO;
    
    self.navigationItem.title = @"影红小镇";
    
    [self.tableView registerClass:[ArtistTableViewCell class] forCellReuseIdentifier:@"cell"];

//    [self p_reloadDataa];

    [Reach reachability:^(LYReachability status) {
        switch (status) {
            case UNKNOW_NET:
                NSLog(@"没有网");
                break;
            case NO_NET:
                break;
            case G_NET:
                [self p_reloadDataa];
                break;
            case WIFI_NET:
                [self p_reloadDataa];
                break;
            default:
                break;
        }
    }];

    
    

    
//    [self p_setupRefresh];
    
}

#pragma mark 数据处理
-(void)p_reloadDataa
{
    [DictToData showMBHUBWithContent:@"玩命加载中..." ToView:self.view];
    
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 艺人轮播
            [[getAboutArtistData shareArtistData]
             getArtistExpandWithType:@"1" WithCategoryid:@"1" Expand:^(NSArray *artistExpandArr) {
                 
                 self.expandArr = artistExpandArr;
             }];
            
            //艺人中心分类  通告列表
            [[getAboutArtistData shareArtistData] getArtistCategory:^(NSDictionary *CategoryDic) {
                
                self.artistSortArr = CategoryDic;
                
            }];
            [[getAboutArtistData shareArtistData]getNotifyExpandWithType:1 WithCategoryid:10 City:@"" Category:@"" Expand:^(NSMutableArray *notify) {
                self.notifyArray = notify;
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self setData];
                [self p_UI];
                [self.tableView reloadData];
                
                self.tableView.tableHeaderView = self.headView;
                
                
            });
        });
        
        
        
    }
}


-(void)setData
{
    //分类数据处理
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 1; i<= 8; i++) {
        NSDictionary *dictionary = [NSDictionary new];
        
        dictionary = [[[self.artistSortArr objectForKey:@"data"]objectForKey:@"0"] objectForKey:[NSString stringWithFormat:@"%d",i]];
        [arr1 addObject:dictionary];
    }
    for (NSDictionary * dict in arr1)
    {
        getArtists * m = [[getArtists alloc] init];
        [m setValuesForKeysWithDictionary:dict];
        [self.detailArr addObject:m];
    }

    //活动通告
//    NSArray *arr2 = [NSArray array];
//    arr2 = [[self.artistSortArr objectForKey:@"datas"]objectForKey:@"announcement"];
//    
//    for (NSDictionary * dictAct in arr2)
//    {
//        getActivityList * m = [[getActivityList alloc] init];
//        [m setValuesForKeysWithDictionary:dictAct];
//        [self.activitArr addObject:m];
//    }
    
    
}

-(void)p_UI
{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/4 + 231 + 20)];
    self.headView.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f blue:222/255.0f alpha:1.0];

    
    [self.view addSubview:_headView];
    
    self.arr7 = [NSMutableArray array];
    
    
     self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) , CGRectGetHeight(self.view.frame)/4 + 20) imageURLStringsGroup:nil];
    [self.headView addSubview:_cycleScrollView];
    
    // 定义pageControl的位置
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    // 设置图片间隔
    self.cycleScrollView.autoScrollTimeInterval = 3;
    
    // 设置代理
    self.cycleScrollView.delegate = self;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int  i = 0; i < self.expandArr.count; i++)
    {

         expandModel *p = self.expandArr[i];
        NSString *str2 = p.imageUrl;
        [arr addObject:str2];
    }
    NSMutableArray *descStr = [NSMutableArray array];
    
    for (int  i = 0; i < self.expandArr.count; i++)
    {
        expandModel *p = self.expandArr[i];
        
        NSString *str2 = p.title;
        [descStr addObject:str2];
    }
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        //轮播网络图片
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _cycleScrollView.imageURLStringsGroup = arr;
            _cycleScrollView.titlesGroup = descStr;
        });
    }
   


    //艺人分类背景
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleScrollView.frame), CGRectGetWidth(self.view.frame), 192)];
    [self.headView addSubview:_myView];
    
    
    //给view设置背景图片
    UIImage *image = [UIImage imageNamed:@"shequbg.jpg"];
    self.myView.layer.contents = (id)image.CGImage;
    for (int i = 0; i < self.detailArr.count; i++)
    {
        getArtists *g = self.detailArr[i];
        [self.myArr addObject:g.title];
        [self.myArrPic addObject:g.img];
        [self.myIdArr addObject:g.Id];
     }
    

    //演员
    UIButton *image1 = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 6) /4/2-30, 10,60, 60)];
    NSString *str2 = self.myArrPic[0];
    
    [image1 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str2]]] forState:UIControlStateNormal];
    image1.layer.cornerRadius = 30;
    image1.layer.masksToBounds = YES;
    [image1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    image1.tag = [self.myIdArr[0] integerValue];
    [self.myView addSubview:image1];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(0, CGRectGetMaxY(image1.frame)  , (CGRectGetWidth(self.view.frame) - 6) /4, 30);

    [btn1 setTitle:self.myArr[0] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = [self.myIdArr[0] integerValue];
    btn1.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
    [self.myView addSubview:btn1];
//    歌舞
    UIButton *image2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame) + (CGRectGetWidth(self.view.frame) - 6) /4/2-30, CGRectGetMinY(image1.frame),60, 60)];
    NSString *str3 = self.myArrPic[1];
    [image2 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str3]]] forState:UIControlStateNormal];
    image2.layer.cornerRadius = 30;
    
    [image2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    image2.tag = [self.myIdArr[1] integerValue];
    image2.layer.masksToBounds = YES;
    [self.myView addSubview:image2];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 2, CGRectGetMaxY(image2.frame)  , (CGRectGetWidth(self.view.frame) - 6) /4, 30);
     btn2.backgroundColor = [UIColor clearColor];
    btn2.tag =  [self.myIdArr[1] integerValue];
    [btn2 setTitle:self.myArr[1] forState:UIControlStateNormal];
     [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
    [self.myView addSubview:btn2];
    
    
    
    UIButton *image3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame) + (CGRectGetWidth(self.view.frame) - 6) /4/2-30, CGRectGetMinY(image1.frame),60, 60)];
    NSString *str4 = self.myArrPic[2];
    [image3 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str4]]] forState:UIControlStateNormal];
    image3.layer.cornerRadius = 30;
    
    [image3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    image3.tag = [self.myIdArr[2] integerValue];
    image3.layer.masksToBounds = YES;
    
    
    [self.myView addSubview:image3];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.frame = CGRectMake(CGRectGetMaxX(btn2.frame) + 2, CGRectGetMaxY(image3.frame)  , (CGRectGetWidth(self.view.frame) - 6) /4, 30);
    btn3.backgroundColor = [UIColor clearColor];
     btn3.tag = [self.myIdArr[2] integerValue];
    [btn3 setTitle:self.myArr[2] forState:UIControlStateNormal];
    btn3.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
     [btn3 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myView addSubview:btn3];
    
    
    UIButton *image4 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn3.frame) + (CGRectGetWidth(self.view.frame) - 6) /4/2-30,CGRectGetMinY(image1.frame),60, 60)];
    NSString *str5 = self.myArrPic[3];
    [image4 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str5]]] forState:UIControlStateNormal];
    image4.layer.cornerRadius = 30;
    image4.tag = [self.myIdArr[3] integerValue];
    image4.layer.masksToBounds = YES;
    [image4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.myView addSubview:image4];
    
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn4.frame = CGRectMake(CGRectGetMaxX(btn3.frame) + 2, CGRectGetMaxY(image4.frame)  , (CGRectGetWidth(self.view.frame) - 6) /4, 30);
    btn4.backgroundColor = [UIColor clearColor];
    [btn4 setTitle:self.myArr[3] forState:UIControlStateNormal];
     [btn4 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
    btn4.tag = [self.myIdArr[3] integerValue];
    [self.myView addSubview:btn4];
    
    
    UIButton *image5 = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 6) /4/2-30, CGRectGetMaxY(btn1.frame),60, 60)];
    NSString *str6 = self.myArrPic[4];
    [image5 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str6]]] forState:UIControlStateNormal];
    image5.layer.cornerRadius = 30;
    image5.layer.masksToBounds = YES;
      [image5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     image5.tag = [self.myIdArr[4] integerValue];
    [self.myView addSubview:image5];
    
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn5.frame = CGRectMake(0 ,CGRectGetMaxY(image5.frame) +2 , (CGRectGetWidth(self.view.frame) - 6) /4, 30);
    btn5.backgroundColor = [UIColor clearColor];
    [btn5 setTitle:self.myArr[4] forState:UIControlStateNormal];
    btn5.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
     [btn5 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     btn5.tag = [self.myIdArr[4] integerValue];
    [self.myView addSubview:btn5];

    
    UIButton *image6 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn5.frame)+(CGRectGetWidth(self.view.frame) - 6) /4/2-30, CGRectGetMaxY(btn1.frame),60, 60)];
    NSString *str7 = self.myArrPic[5];
     [image6 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str7]]] forState:UIControlStateNormal];
    image6.layer.cornerRadius = 30;
    image6.layer.masksToBounds = YES;
      [image6 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
   image6.tag = [self.myIdArr[5] integerValue];
    [self.myView addSubview:image6];
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn6.frame = CGRectMake(CGRectGetMaxX(btn5.frame) + 2, CGRectGetMaxY(image6.frame) +2 , (CGRectGetWidth(self.view.frame) - 6) /4, 30);
    btn6.backgroundColor = [UIColor clearColor];
    [btn6 setTitle:self.myArr[5] forState:UIControlStateNormal];
    btn6.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
     [btn6 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     btn6.tag = [self.myIdArr[5] integerValue];
    [self.myView addSubview:btn6];
    
    
    UIButton *image7 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn6.frame)+(CGRectGetWidth(self.view.frame) - 6) /4/2-30, CGRectGetMaxY(btn1.frame),60, 60)];
    NSString *str8 = self.myArrPic[6];
    [image7 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str8]]] forState:UIControlStateNormal];
    image7.layer.cornerRadius = 30;
    image7.layer.masksToBounds = YES;
       [image7 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     image7.tag = [self.myIdArr[6] integerValue];
    [self.myView addSubview:image7];
    
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn7.frame = CGRectMake(CGRectGetMaxX(btn6.frame) + 2, CGRectGetMaxY(image7.frame) +2 , (CGRectGetWidth(self.view.frame) - 6) /4, 30);
    btn7.backgroundColor = [UIColor clearColor];
    [btn7 setTitle:self.myArr[6] forState:UIControlStateNormal];
    btn7.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
     [btn7 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     btn7.tag = [self.myIdArr[6] integerValue];
    [self.myView addSubview:btn7];
    
    UIButton *image8 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn7.frame)+(CGRectGetWidth(self.view.frame) - 6) /4/2-30, CGRectGetMaxY(btn1.frame),60, 60)];
    NSString *str9 = self.myArrPic[7];
   [image8 setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str9]]] forState:UIControlStateNormal];
    image8.layer.cornerRadius = 30;
    image8.layer.masksToBounds = YES;
     image8.tag = [self.myIdArr[7] integerValue];
 
    [image8 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.myView addSubview:image8];
    UIButton *btn8 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn8.frame = CGRectMake(CGRectGetMaxX(btn7.frame) + 2, CGRectGetMaxY(image8.frame) +2 , (CGRectGetWidth(self.view.frame) - 6) /4, 30);
    btn8.backgroundColor = [UIColor clearColor];
    [btn8 setTitle:self.myArr[7] forState:UIControlStateNormal];
    btn8.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
     [btn8 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     btn8.tag = [self.myIdArr[7] integerValue];
    [self.myView addSubview:btn8];
    [self actorNotify];
    
    
    //136 154  158
   
}

- (void)actorNotify{
    UILabel *actLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myView.frame)+2, CGRectGetWidth(self.view.frame)/2, 35)];
    actLabel.textAlignment = NSTextAlignmentLeft;
    actLabel.textColor = [UIColor colorWithRed:252/255.0f green:30/255.0f  blue:94/255.0f  alpha:1.0];
    actLabel.text = @"活动通告";
    [actLabel setBackgroundColor:[UIColor whiteColor]];
    
    //actLabel.backgroundColor = [UIColor whiteColor];
    actLabel.font = [UIFont systemFontOfSize:17];
    //查找通告的button
    [self.headView addSubview:actLabel];
    UIButton *findButton =[UIButton buttonWithType:UIButtonTypeSystem];
    findButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2, CGRectGetMaxY(self.myView.frame)+2, (CGRectGetWidth(self.view.frame))/2, 35);
    findButton.backgroundColor = [UIColor whiteColor];
    [findButton setTitle:@"查找通告" forState:UIControlStateNormal];
    [findButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 100, 5, 0)];
    findButton.tintColor = [UIColor colorWithRed:53/255.0f green:108/255.0f  blue:114/255.0f alpha:1.0f];
  

    [findButton addTarget:self action:@selector(findNotify) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headView addSubview:findButton];
}
//查找通告跳转
- (void)findNotify{
    FindNotifyViewController *find = [[FindNotifyViewController alloc]init];
    UINavigationController *UNC = [[UINavigationController alloc]initWithRootViewController:find];
    [self presentViewController:UNC animated:NO completion:nil];
}
-(void)btnAction:(UIButton *)sender
{
    
//    CategoryViewController *category = [[CategoryViewController alloc]init];
//    UINavigationController *UNC = [[UINavigationController alloc]initWithRootViewController:category];
//    NSLog(@"%@",self.myArr[sender.tag-1]);
//    category.category = self.myArr[sender.tag-1];
   
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 3 - 6, 145);
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.minimumLineSpacing = 3;
    flowLayout.headerReferenceSize = CGSizeMake(0, CGRectGetHeight(self.view.frame)/4 + 30);

    
    // 新版本
    // 设置整体四周边距  上、左、下、右
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 15, 5);
    CategoryDetailsNewCollectionViewController *categoryVC = [[CategoryDetailsNewCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
     categoryVC.category = self.myArr[sender.tag-1];
    categoryVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height- 164);
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryVC animated:YES];
//    categoryVC.leixingType = self.myArr[sender.tag - 1];
//    NSLog(@"%@",self.myArr[sender.tag]);
//
//    [self presentViewController:UNC animated:NO completion:nil];
    
    
    
    //[self.navigationController pushViewController:myVC animated:YES];
}

// 分类请求数据


// 轮播图的实现

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //ReiseDetailViewController *reiseVC = [[ReiseDetailViewController alloc]init];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
//        expandModel *p = self.expandArr[index];
//        if ([p.jumptype isEqualToString:@"1"])
//        {
//            ArtistsIntroViewController * artVC = [[ArtistsIntroViewController alloc]init];
//            artVC.actsIndex = p.y_id;
//            [self.navigationController pushViewController:artVC animated:YES];
        
//        }
//        else
//        {
//            webViewController *webVC = [[webViewController alloc]init];
//            webVC.myWebStr = p.jumpurl;
//            [self.navigationController pushViewController:webVC animated:YES];
//        }
//        
//        
//        
    }
//
   
    
    //[self.navigationController pushViewController:reiseVC animated:YES];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.notifyArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArtistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NotifyModel *p = self.notifyArray[indexPath.row];
//    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
    cell.backgroundColor = [UIColor colorWithRed:189/255.0f green:197/255.0f blue:197/255.0f alpha:1.0];
//    NSString *str2 = p.titlepic;
//
//
//    NSString *str3 =[str1 stringByAppendingString:str2];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [cell.artImage sd_setImageWithURL:[NSURL URLWithString:p.coverImgUrl]];
    }
    cell.backgroundColor = [UIColor whiteColor];
    //活动标题
    cell.titleLable.text = p.title;
    cell.imgTime.image = [UIImage imageNamed:@"ziliao1"];
//    活动时间
    cell.lblTime.text = [NSString stringWithFormat:@"%@ ¥ / %@",p.reward,p.rewardUnit];
    cell.imgLocation.image = [UIImage imageNamed:@"ziliao2"];
    //活动地点
    cell.lblLocation.text = p.city;
    cell.imgModol.image = [UIImage imageNamed:@"ziliao3"];
    //活动人数
    cell.lblModol.text = [NSString stringWithFormat:@"男 %ld 女 %ld",[p.male integerValue],[p.female integerValue]];
    cell.imgClick.image = [UIImage imageNamed:@"ziliao4"];
    //点赞人数
    cell.lblClick.text = [NSString stringWithFormat:@"%ld",[p.viewTime integerValue]];
    
    [cell.btnEventDetails setTitle:@"活动详情" forState:UIControlStateNormal];
    [cell.btnEventDetails setHidden:YES];
    cell.btnEventDetails.tag = indexPath.row;
    [cell.btnEventDetails addTarget:self action:@selector(btnEventDetailsEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tongzhiqu.jpg"]];
    KCellStyle;
    return cell;
}

// 活动详情 按钮点击事件
-(void)btnEventDetailsEvent:(UIButton *)sender
{
    getActivityList *p = self.activitArr[sender.tag];
    ArtEventDetailsViewController *ArtVC = [[ArtEventDetailsViewController alloc] init];
    ArtVC.myId = p.Id;
    //数据处理
   
    
    [self.navigationController pushViewController:ArtVC animated:YES];

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotifyModel *p = self.notifyArray[indexPath.row];
    ArtEventDetailsViewController *ArtVC = [[ArtEventDetailsViewController alloc] init];
    ArtVC.delegate = self;
    ArtVC.indexPathy = indexPath;
    ArtVC.myId = p.ID;
    //数据处理
    self.myDic = [NSDictionary dictionary];
   
    ArtVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ArtVC animated:YES];
    

    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)passName:(NSString *)aName WithIndexPath:(NSIndexPath *)index
{
//    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
//    {
//        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
//    }
//    else
//    {
////        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////            // 耗时的操作
////            //艺人中心分类  通告列表
////            [[getAboutArtistData shareArtistData] getArtistCategory:^(NSDictionary *CategoryDic) {
////                
////                self.artistSortArr = CategoryDic;
////                
////            }];
////            dispatch_async(dispatch_get_main_queue(), ^{
////                //一个cell刷新
////                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
////                
////            });
////        });
//        
//        
////        [[getAboutArtistData shareArtistData] getArtistCategory:^(NSDictionary *CategoryDic) {
////            
////            self.artistSortArr = CategoryDic;
////            
////        }];
//    }
//    
//    NSLog(@"**************************");
//    NSLog(@"%ld,%ld",index.section,index.row);
}

@end
