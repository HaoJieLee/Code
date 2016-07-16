//
//  FindNotifyViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/6/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "FindNotifyViewController.h"
#import "DropDownListView.h"
#import "DropDownChooseProtocol.h"
#import "ArtistTableViewCell.h"
#import "MJRefresh.h"
#import "ArtEventDetailsViewController.h"
#import "NotifyModel.h"
#import "getProjectData.h"


@interface FindNotifyViewController ()<passNameDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *findDataSource;//删选分组
@property (nonatomic,copy)NSString *TermName;//类型
@property (nonatomic,copy)NSString *ChaptersName;//地区
@property (nonatomic,strong)NSDictionary *myDic;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *notifyArray;//活动数组
@property (nonatomic)int pageNo;//页码
@end

@implementation FindNotifyViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self setfFoundations];
    [self addFindDataArray];
    [self setDropDownListView];
    [self.view addSubview:self.tableView];
    [self tableViewFrash];
    [self addDataSource];
    // Do any additional setup after loading the view.
    
}
- (void)setfFoundations{
    self.notifyArray = [[NSMutableArray alloc]init];
    self.pageNo = 1;
    
    NSString *navBackgroundBarImage = [[NSBundle mainBundle] pathForResource:@"sytopd"ofType:@"png"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:navBackgroundBarImage] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"通告";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(leaveNowView)];
}
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[ArtistTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (void)tableViewFrash{
    __weak typeof(self) weakself = self;
    [self.tableView addHeaderWithCallback:^{
        weakself.pageNo = 1;
        [weakself.notifyArray removeAllObjects];
        [weakself addDataSource];
        
    }];
    [self.tableView addFooterWithCallback:^{
        weakself.pageNo++;
        [weakself addDataSource];
    }];
//    [self.tableView headerBeginRefreshing];
}
- (void)addDataSource{
    
    
    [DictToData showMBHUBWithContent:@"玩命加载中..." ToView:self.view];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if ([self.TermName isEqualToString:@"类别"]) {
                self.TermName = @"";
            }
            if ([self.ChaptersName isEqualToString:@"地区"]) {
                self.ChaptersName = @"";

            }
            [[getAboutArtistData shareArtistData]getNotifyExpandWithType:self.pageNo WithCategoryid:10 City:self.ChaptersName Category:self.TermName Expand:^(NSMutableArray *notify) {
                    [self.notifyArray addObjectsFromArray:notify];
                }];
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                if (self.pageNo==1) {
                    [self.tableView headerEndRefreshing];
                
                    }else{
                    [self.tableView footerEndRefreshing];
                }

                [MBProgressHUD hideHUDForView:self.view animated:YES];

                [self.tableView reloadData];
            });

        });

//    }

}
- (void)addFindDataArray{
    NSArray *typeArray = @[@"类别",@"广告待宣",@"演员招募",@"T台走秀",@"平面拍摄",@"礼仪服务",@"其他"];
    NSMutableArray *cityaArray = [NSMutableArray arrayWithObjects:@"地区", nil];
    [cityaArray addObjectsFromArray: [[getProjectData  shareProjectData] getCitys]];
    self.findDataSource = [NSMutableArray arrayWithArray:@[typeArray,cityaArray]];
}
- (void)leaveNowView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**加载选择按钮*/
- (void)setDropDownListView{
    DropDownListView *dropDownView = [[DropDownListView alloc]initAndWithFrame:CGRectMake(0, 60, self.view.frame.size.width-5, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [self.view addSubview:dropDownView];

    
}
#pragma mark DropDownChooseDelegate,DropDownChoosefindDataSource
- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index{
    [self.notifyArray removeAllObjects];
    [self addDataSource];
}
- (NSInteger)numberOfSections{
    return self.findDataSource.count;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.findDataSource[section] count];
}
- (NSString *)titleInSection:(NSInteger)section index:(NSInteger)index{
    switch (section) {
        case 0:
        {
            self.TermName = self.findDataSource[section][index];
            
            return self.TermName;
        }
            break;
        case 1:
        {
            if ([self.findDataSource[section] count] != 0) {
                self.ChaptersName = self.findDataSource[section][index];
                return self.ChaptersName;
            }
            return nil;
        }
            break;
        default:
            break;
    }
    return self.findDataSource[section][index];
}

-(NSInteger)defaultShowSection:(NSInteger)section{
    return 0;
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
    cell.lblModol.text = [NSString stringWithFormat:@"男 %ld名 女 %ld名",[p.male integerValue],[p.female integerValue]];
    cell.imgClick.image = [UIImage imageNamed:@"ziliao4"];
    //点赞人数
    cell.lblClick.text = [NSString stringWithFormat:@"%ld",[p.viewTime integerValue]];
    
    [cell.btnEventDetails setTitle:@"活动详情" forState:UIControlStateNormal];
    [cell.btnEventDetails setHidden:YES];
    cell.btnEventDetails.tag = indexPath.row;
//    [cell.btnEventDetails addTarget:self action:@selector(btnEventDetailsEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tongzhiqu.jpg"]];
    KCellStyle;
    return cell;
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
    
    
    [self.navigationController pushViewController:ArtVC animated:YES];
    
    
    
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
