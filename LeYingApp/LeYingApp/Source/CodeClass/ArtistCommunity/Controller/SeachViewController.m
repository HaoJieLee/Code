//
//  SeachViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/6/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "SeachViewController.h"
#import "DropDownListView.h"
#import "SearchModel.h"
#import "ArtEventDetailsViewController.h"

#import "ArtistsIntroViewController.h"
#import "CategoryDetailNewCollectionViewCell.h"

@interface SeachViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UITextFieldDelegate
>
//
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIButton *TuiChuButton;
@property (nonatomic,strong)UIButton *searchButton;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *findDataSource;//删选分组
@property (nonatomic)int sort;//sort 排序方法 0默认值，1添加时间，2艺人资料最后修改时间，3最热  location
@property (nonatomic,copy)NSString *location;//地区
@property (nonatomic,strong)NSDictionary *myDic;
@property (nonatomic,copy)NSString *word;//关键字
@property (nonatomic,copy)NSString *category;//艺人类型
@property (nonatomic,strong)NSMutableArray *actorArray;//活动数组
@property (nonatomic)int pageNo;//页码
@property (nonatomic)int gender;//性别 1男，2女，3未指定
@property (nonatomic,strong)UIView *mTableBaseView;//加一个蒙版的View
@property (nonatomic)BOOL isRefreshing;
@end
static NSString * const reuseIdentifier = @"catedorycell";

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFindDataArray];
    [self setBasisData];
//    [self setBaseView];
    self.actorArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"both1.png"] style:UIBarButtonItemStyleDone target:self action:@selector(RightSetBarButton)];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.collectionView];
    [self p_setupRefresh];
    [self setCollectionViewDataSource];
    
    // Do any additional setup after loading the view.
}
- (void)setBasisData{
    self.pageNo = 1;
    self.sort = 0;
    self.gender = 0;
    self.location = @"";
    self.category = @"";
    self.word = @"";
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _textField.text = @"";
    [_textField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.word = textField.text;
    [self.actorArray removeAllObjects];
    [self setCollectionViewDataSource];
    [textField endEditing:YES];
    return YES;
}
- (void)RightSetBarButton{
    self.word = self.textField.text;
    [self.actorArray removeAllObjects];
    [self setCollectionViewDataSource];
    [self.textField endEditing:YES];
}
- (UIButton*)TuiChuButton{
    if (_TuiChuButton == nil) {
        _TuiChuButton = [Factory initWithFrame:CGRectMake(10, 10, 50, 40) BackColor:[UIColor clearColor] Title:@"" TintColor:[UIColor blackColor] Tag:0 ButtonType:UIButtonTypeCustom];
        [_TuiChuButton setBackgroundImage:[UIImage imageNamed:@"arrow_left"]  forState:UIControlStateNormal];
        [_TuiChuButton addTarget:self action:@selector(TuiChuView) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _TuiChuButton;
    
}
- (UIButton*)searchButton{
    if (_searchButton == nil) {
        _searchButton = [Factory initWithFrame:CGRectMake(self.view.frame.size.width-70, 10, 50, 40) BackColor:[UIColor clearColor] Title:@"搜索" TintColor:[UIColor blackColor] Tag:1 ButtonType:UIButtonTypeCustom];
        [_searchButton addTarget:self action:@selector(searchUsers) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
- (void)searchUsers{
    
    self.word = self.textField.text;
    if ([self.word isEqualToString:@""]) {
        
    }else{
        [self.actorArray removeAllObjects];
        [self setCollectionViewDataSource];
    }
    
   
}
- (void)TuiChuView{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (UITextField*)textField{
    if (_textField==nil) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, self.view.frame.size.width-140, 40)];
        _textField.delegate = self;
        _textField.placeholder = @"搜索 艺名名称/编号";
        _textField.userInteractionEnabled = YES;
        _textField.layer.cornerRadius = 1.0;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    }
    return _textField;
    
}
- (UIView *)headView{
    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 110)];
        _headView.backgroundColor = [UIColor colorWithRed:238/255.0 green:78/255.0 blue:111/255.0 alpha:1.0];
        [_headView addSubview:self.TuiChuButton];
        [_headView addSubview:self.textField];
        [_headView addSubview:self.searchButton];
        [self setDropDownListView];
    }
    return _headView;
}

/**
 
 

 */
- (UICollectionView*)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 3 - 6, 145);
        flowLayout.minimumInteritemSpacing = 3;
        flowLayout.minimumLineSpacing = 3;

        flowLayout.sectionInset = UIEdgeInsetsMake(5, 2, 15, 5);
        _collectionView =   [[UICollectionView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120) collectionViewLayout:flowLayout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.alwaysBounceVertical = YES; //垂直方向遇到边框是否总是反弹

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CategoryDetailNewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
      
        _collectionView.scrollEnabled = YES;
       
    }
    return _collectionView;
}
//加载艺人数据
- (void)setCollectionViewDataSource{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.actorArray addObjectsFromArray:[[getAboutArtistData shareArtistData]SearchExpandWithType:self.location WithCategoryid:self.word gender:self.gender Category:self.category Sort:self.sort PageNo:self.pageNo PageSize:10]];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                
                [self.collectionView reloadData];
                
               
            });
            [self.collectionView headerEndRefreshing];
        });
        
    }

}
- (void)addFindDataArray{
   
    NSArray *genderArray = @[@"性别",@"男",@"女",@"全部"];
    //排序方法、
//    ,@"模特",@"演员",@"主持",@"礼仪",@"歌舞",@"网红",@"摄影",@"其他"
    NSArray *typeArray = @[@"类别",@"默认",@"最近时间",@"最近修改",@"最热"];
    NSMutableArray *cityaArray = [NSMutableArray arrayWithObjects:@"地区", nil];
    [cityaArray addObjectsFromArray: [[getProjectData  shareProjectData] getCitys]];
    self.findDataSource = [NSMutableArray arrayWithArray:@[genderArray,typeArray,cityaArray]];
}

- (void)leaveNowView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 上拉加载 下拉刷新
/////////////////////////////////////////////////////
-(void)p_setupRefresh
{
    __weak typeof(self)weakself = self;
    [self.collectionView addFooterWithCallback:^{
        weakself.pageNo++;
        
        [weakself setCollectionViewDataSource];
        

    }];
    [self.collectionView addHeaderWithCallback:^{
        weakself.pageNo = 1;
        [weakself.actorArray removeAllObjects];
        [weakself setCollectionViewDataSource];

    }];

//    [self.collectionView headerBeginRefreshing];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.collectionView.headerPullToRefreshText = @"下拉";
//    self.collectionView.headerReleaseToRefreshText = @"松开刷新";
//    self.collectionView.headerRefreshingText = @"玩命加载中...";
//    
//    self.collectionView.footerPullToRefreshText = @"上拉";
//    self.collectionView.footerReleaseToRefreshText = @"松开加载";
//    self.collectionView.footerRefreshingText = @"玩命加载中...";
}



/**加载选择按钮*/
- (void)setDropDownListView{
    DropDownListView *dropDownView = [[DropDownListView alloc]initAndWithFrame:CGRectMake(0, 60, self.view.frame.size.width-5, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.headView addSubview:dropDownView];
    
    
}
#pragma mark DropDownChooseDelegate,DropDownChoosefindDataSource
- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index{
//    性别，类别，地区 SearchExpandWithType:self.location WithCategoryid:self.word gender:self.gender Category:self.category Sort:self.sort PageNo:self.pageNo PageSize:10]]
    NSString *string = self.findDataSource[section][index];
    switch (section) {
        case 0:
        {
            if ([string isEqualToString:@"性别"]) {
                
            }else{
                [self.actorArray removeAllObjects];
                self.gender = (int)index;
                [self setCollectionViewDataSource];
            }
            
        }
            break;
        case 1:
        {
            if ([string isEqualToString:@"类别"]) {
                self.sort = 0;
            }
            else{
                self.sort = (int)index;
                [self.actorArray removeAllObjects];
                [self setCollectionViewDataSource];

            }
            
        }
            break;
        case 2:
        {
            if ([string isEqualToString:@"地区"]) {
                self.location = @"";
            }
            else{
                self.location = string;
                [self.actorArray removeAllObjects];
                [self setCollectionViewDataSource];

            }
        }
            break;
        default:
        break;
    }
}
- (NSInteger)numberOfSections{
    return self.findDataSource.count;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.findDataSource[section] count];
}
- (NSString *)titleInSection:(NSInteger)section index:(NSInteger)index{
    NSString *string = self.findDataSource[section][index];
    switch (section) {
        case 0:
        {
            self.gender = (int)index;
        }
            break;
        case 1:
        {
            self.sort = (int)index;
          }
        break;
            case 2:
        {
            if ([string isEqualToString:@"地区"]) {
                self.location = @"";
            }
            return string;
        }
            break;
        default:
            break;
    }
    return string;
}

-(NSInteger)defaultShowSection:(NSInteger)section{
    return 0;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.actorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryDetailNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.actorArray.count == 0) {
        return cell;
    }
    SearchModel *g = self.actorArray[indexPath.row];
    
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
    
  
    SearchModel *g = self.actorArray[indexPath.row];
    if ([[NSString stringWithFormat:@"%@",[self.myDic objectForKey:@"login"]] isEqualToString:@"0"])
    {
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alView.delegate = self;
        [alView show];
    }
    else
    {
        ArtistsIntroViewController *acv = [[ArtistsIntroViewController alloc]init];
        acv.actsIndex = g.ID;
        acv.InType = 0;
        UINavigationController *UNC = [[UINavigationController alloc]initWithRootViewController:acv];
        self.hidesBottomBarWhenPushed = YES;
        [self presentViewController:UNC animated:YES completion:nil];
        
        
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

@end
