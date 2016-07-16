 //
//  CategoryDetailsCollectionViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CategoryDetailsNewCollectionViewController.h"
#import "CategoryDetailNewCollectionViewCell.h"
#import "SDCycleScrollView.h"

#import "expandModel.h"
#import "ArtistsIntroViewController.h"
#import "getAboutArtistData.h"
#import "getActivityList.h"
#import "JoinViewController.h"
#import "webViewController.h"
#import "DropDownListView.h"
#import "DropDownChooseProtocol.h"

@interface CategoryDetailsNewCollectionViewController ()<SDCycleScrollViewDelegate,UIAlertViewDelegate>
{
    UIButton *_ChoseBtn;
    UIView *_ChoseView;
    
    
    UIButton *_ChoseSingeBtn;
    UIView *_ChoseSingeView;
    NSArray *_ChoseSingeArr;
}
@property(nonatomic,strong) NSMutableArray *ChoseArr;
@property (nonatomic,strong) NSArray *expandArr;
@property (nonatomic,strong)SDCycleScrollView *myCycleView;
@property (nonatomic,strong)NSDictionary *myDic;
@property (nonatomic,strong)NSMutableArray *myArr;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)NSMutableArray *artArrs;


@property (nonatomic,strong)NSString *myPage;

@property (nonatomic,strong) NSString *sexType;
// 歌舞 歌曲 舞蹈
@property (nonatomic,strong) NSString *gewuType;

@property (nonatomic,strong) NSMutableArray *myNewArr;

@property (nonatomic,strong) UICollectionReusableView *headView;
@property (nonatomic,copy)NSString *page;

@property (nonatomic,copy)NSString *ChaptersName;//其他类型
@property (nonatomic)NSString *TermName;//性别类型


@property (nonatomic,strong)NSArray *array;//性别数组
@property (nonatomic,strong)NSArray *type;//类别数组
@property (nonatomic,strong)NSArray *musicArray;//歌舞数组
@property (nonatomic)int sex;
@property (nonatomic)int typeRow;
@property (nonatomic)int music;
@end

@implementation CategoryDetailsNewCollectionViewController

static NSString * const reuseIdentifier = @"catedorycell";

-(void)viewWillAppear:(BOOL)animated
{

    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
/**加载选择按钮*/
- (void)setDropDownListView{
    DropDownListView *dropDownView = [[DropDownListView alloc]initAndWithFrame:CGRectMake(-2.5, CGRectGetMaxY(self.myCycleView.frame), self.headView.frame.size.width, 30) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.headView addSubview:dropDownView];
 
}
- (void)setBaseData{
    self.navigationItem.title = self.category;
    [super viewDidLoad];
    self.sex= 0;
    self.typeRow = 0;
    self.music = 0;
    _myNewArr = [[NSMutableArray alloc]init];
    self.page = @"1";
    self.sexType = @"0";
    
    self.array = @[@"性别",@"男",@"女"];//性别
    self.type = @[@"类型",@"走秀",@"平面",@"展会"];//模特类别
    self.musicArray = @[@"类型",@"歌手",@"舞蹈"];//歌舞
    
    if ([self.category isEqualToString:@"演员"]) {
        self.ChoseArr = [NSMutableArray arrayWithArray:@[self.array,_type]];
    }else if ([self.category isEqualToString:@"歌舞"]){
        self.ChoseArr = [NSMutableArray arrayWithArray: @[_array,_musicArray]];
        
    }else{
        self.ChoseArr = [NSMutableArray arrayWithArray:@[_array]];
    }
    
    
    self.myDic = [NSDictionary dictionary];
    self.myArr = [NSMutableArray array];
}
- (void)viewDidLoad
{
    [self setBaseData];
    self.collectionView.alwaysBounceVertical = YES; //垂直方向遇到边框是否总是反弹

    [self.collectionView registerClass:[CategoryDetailNewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // 头部视图注册

    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    
    self.artArrs = [NSMutableArray array];
    self.expandArr = [NSArray array];
    //
    
    
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 请求数据
            //轮播数据
            [[getAboutArtistData shareArtistData]
             getArtistExpandWithType:@"1" WithCategoryid:@"1" Expand:^(NSArray *artistExpandArr) {
                 
                 self.expandArr = artistExpandArr;
             }];
            //艺人数据
            [[getAboutArtistData shareArtistData]getArtistsWithPage:self.page getId:self.category getManorWoman:self.sexType ArtistValue:^(NSDictionary *detailDic, NSString *mypage) {
                
                self.myDic = detailDic;
                self.myPage = mypage;
                
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [self setData];
                [self p_setupRefresh];
                [self.collectionView reloadData];
                [self.collectionView headerEndRefreshing];
            });
        });
        
    }
//     self.index = 2;
   
    
    
    //重写左bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}


-(void)leftBarButtonItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 筛选条件 歌曲、舞蹈




-(void)setData
{
    NSArray *myarr = [NSArray array];
//    NSLog(@"---------%@",[[_myDic objectForKey:@"datas"] objectForKey:@"list"]);
    if (![[NSString stringWithFormat:@"%@",[[_myDic objectForKey:@"datas"] objectForKey:@"list"]] isEqualToString:@"0"]) {
        myarr = [self.myDic objectForKey:@"data"];
        
        if ([self.myPage isEqualToString:@"1"] && self.myArr.count != 0)
        {
            // 替换数组中的数据
            
            [self.myArr removeAllObjects];
            
            self.artArrs = (NSMutableArray *)myarr;
            for (NSDictionary * dicArtists in self.artArrs)
            {
                getActivityList* model = [[getActivityList alloc] init];
                [model setValuesForKeysWithDictionary:dicArtists];
                [self.myArr addObject:model];
            }
        }
        else
        {
            // 正常
            self.artArrs = (NSMutableArray *)myarr;
            
            if ([[NSString stringWithFormat:@"%@",self.artArrs] isEqualToString:@"0"])
            {
                
            }
            else
            {
                for (NSDictionary * dicArtists in self.artArrs)
                {
                    getActivityList* model = [[getActivityList alloc] init];
                    [model setValuesForKeysWithDictionary:dicArtists];
                    [self.myArr addObject:model];
                }
            }
            
        }
    }
    
}



#pragma mark - 上拉加载 下拉刷新
/////////////////////////////////////////////////////
-(void)p_setupRefresh
{
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.collectionView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.collectionView.headerPullToRefreshText = @"下拉";
//    self.collectionView.headerReleaseToRefreshText = @"松开刷新";
//    self.collectionView.headerRefreshingText = @"玩命加载中...";
//    
//    self.collectionView.footerPullToRefreshText = @"上拉";
//    self.collectionView.footerReleaseToRefreshText = @"松开加载";
//    self.collectionView.footerRefreshingText = @"玩命加载中...";
}

// 开始进入刷新状态
- (void)headerRereshing
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        self.index = 2;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[getAboutArtistData shareArtistData] getArtistsWithPage:@"1" getId:self.category getManorWoman:_sexType ArtistValue:^(NSDictionary *detailDic, NSString *mypage) {
                self.myDic = detailDic;
                self.myPage = mypage;
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setData];
                
                [self.collectionView reloadData];
                [self.collectionView headerEndRefreshing];
            });
        });
    }
    
    
}

// 开始进入加载状态
- (void)footerRereshing
{
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 1.加载更多数据

        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[getAboutArtistData shareArtistData] getArtistsWithPage:[NSString stringWithFormat:@"%ld",(long)self.index++]  getId:self.category getManorWoman:_sexType ArtistValue:^(NSDictionary *detailDic, NSString *mypage) {
                self.myDic = detailDic;
                self.myPage = mypage;
            }];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self setData];
                
                
                // 刷新表格
                [self.collectionView reloadData];
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//                [self.collectionView footerEndRefreshing];
            });
        });
    }
    
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        JoinViewController *joinVc = [[JoinViewController alloc]init];
        joinVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:joinVc animated:YES];
    }
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.myArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryDetailNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    if (self.myArr.count == 0) {
        return cell;
    }
    getActivityList *g = self.myArr[indexPath.row];
//    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
   
    NSString *str2 = g.avatar;
    NSLog(@"%@",str2);
    if ([[NSString stringWithFormat:@"%@",str2]isEqualToString:@"(null)"])
    {
        cell.imgCategory.image = [UIImage imageNamed:@"mmdo.jpg"];
        cell.lblName.text = g.nicename;
        cell.imgSee.image = [UIImage imageNamed:@"-liulan11.png"];
                
//        cell.lblSee.text = [NSString stringWithFormat:@"%d",[[NSString stringWithFormat:@"%@",g.clicknum] intValue] + [[NSString stringWithFormat:@"%@",g.clicknums] intValue]];
    }
    else
    {
        if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
        {
            [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
        }
        else
        {
            [cell.imgCategory sd_setImageWithURL:[NSURL URLWithString:str2]];
            
        }
        cell.lblName.text = g.nicename;
        cell.imgSee.image = [UIImage imageNamed:@"liulan3.png"];
        //NSInteger myinte = [NSString stringWithFormat:@"%@",g.clicknum];
        
//        cell.lblSee.text = [NSString stringWithFormat:@"%d",[[NSString stringWithFormat:@"%@",g.clicknum] intValue] + [[NSString stringWithFormat:@"%@",g.clicknums] intValue]];
       
    }
   
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _ChoseView.hidden = YES;
    _ChoseSingeView.hidden = YES;
    
    getActivityList *g = self.myArr[indexPath.row];
    if ([[NSString stringWithFormat:@"%@",[self.myDic objectForKey:@"login"]] isEqualToString:@"0"])
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alView.delegate = self;
        [alView show];
    }
    else
    {
        ArtistsIntroViewController *acv = [[ArtistsIntroViewController alloc]init];
        acv.actsIndex = g.Id;
        acv.InType = 1;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:acv animated:YES];
        
    }
    
    
    
    
    
    
}
//collectView的headView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    _headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headView" forIndexPath:indexPath];
    _headView.backgroundColor = [UIColor clearColor];
   
    self.myCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/4) imageURLStringsGroup:nil];
    
//    // 定义pageControl的位置
    self.myCycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    // 设置图片间隔
    self.myCycleView.autoScrollTimeInterval = 3;
    
    // 设置代理
    self.myCycleView.delegate = self;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int  i = 0; i < self.expandArr.count; i++)
    {
        expandModel *p = self.expandArr[i];
        NSString *str2 = p.imageUrl;
        [arr addObject: str2];
    }
    NSMutableArray *descStr = [NSMutableArray array];
    for (int  i = 0; i < self.expandArr.count; i++)
    {
        expandModel *p = self.expandArr[i];
        
        NSString *str2 = p.title;
        [descStr addObject:str2];
    }
    //轮播网络图片
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.myCycleView.imageURLStringsGroup = arr;
            self.myCycleView.titlesGroup = descStr;
        });
        
    }
    
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.myCycleView.frame), KScreenW, 30)];
    myView.backgroundColor = [UIColor clearColor];
    
    [_headView addSubview:myView];
    [_headView addSubview:_myCycleView];
    
//
    [self setDropDownListView];
    return _headView;
}

//轮播图点击事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //ReiseDetailViewController *reiseVC = [[ReiseDetailViewController alloc]init];
    _ChoseView.hidden = YES;
    _ChoseSingeView.hidden = YES;
    
    expandModel *p = self.expandArr[index];
    
//    if ([p.jumptype isEqualToString:@"1"])
//    {
//        ArtistsIntroViewController * artVC = [[ArtistsIntroViewController alloc]init];
//        artVC.actsIndex = p.y_id;
//        [self.navigationController pushViewController:artVC animated:YES];
//
//    }
//    else
//    {
//        webViewController *webVC = [[webViewController alloc]init];
//        webVC.myWebStr = p.jumpurl;
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
    
    
    
   
    
    
    //[self.navigationController pushViewController:reiseVC animated:YES];
    
}
#pragma mark DropDownChooseDelegate,DropDownChooseChoseArr
- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index{
    switch (section) {
        case 0:
        {
            switch (index) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    self.sexType = @"1";

                }
                    break;
                case 2:
                {
                     self.sexType = @"2";
                }
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
//    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
//    {
//        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
//    }
//    else
//    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 请求数据
            //艺人数据
            [[getAboutArtistData shareArtistData]getArtistsWithPage:self.page getId:self.category getManorWoman:self.sexType ArtistValue:^(NSDictionary *detailDic, NSString *mypage) {
                
                self.myDic = detailDic;
                self.myPage = mypage;
                
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [self setData];
//                [self p_setupRefresh];
                [self.collectionView reloadData];
            });
        });
        
//    }

}



- (NSInteger)numberOfSections{
    return self.ChoseArr.count;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
   

    return [self.ChoseArr[section] count];
}
- (NSString *)titleInSection:(NSInteger)section index:(NSInteger)index{
    switch (section) {
        case 0:
        {
            self.sex = (int)index;
            self.TermName = self.ChoseArr[section][index];
            self.sexType= [NSString stringWithFormat:@"%ld",index];
            return self.TermName;
        }
        break;
        case 1:
        {
            self.music = (int)index;
            if ([self.ChoseArr[section] count] != 0) {
                self.ChaptersName = self.ChoseArr[section][index];
                return self.ChaptersName;
            }
        }
        break;
        default:
        break;
    }
    return self.ChoseArr[section][index];
}

-(NSInteger)defaultShowSection:(NSInteger)section{
    if (section==0) {
        return self.sex;
    }else{
        return self.music;
    }
    return 0;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
