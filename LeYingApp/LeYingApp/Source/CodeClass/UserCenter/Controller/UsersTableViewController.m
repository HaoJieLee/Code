//
//  UsersTableViewController.m
//  LeYingApp
//
//  Created by sks on 15/12/10.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UserTableViewCell.h"
#import "MySupportTableController.h"
#import "ApplyViewController.h"
#import "orderViewController.h"
#import "AboutMianViewController.h"
#import "SetViewController.h"
#import "UNfinishDetailViewController.h"
#import "ArtApplyTableViewController.h"
#import "PicUploadCollectionViewController.h"
#import "BuyMyselfTableViewController.h"
#import "JoinViewController.h"

#import "strangerTableViewController.h"
#import "ActiveApplysTableViewController.h"
#import "movieTableViewController.h"
#import "ConfirmViewController.h"
#import "YourTestChatViewController.h"

#import "MyCollectViewController.h"
#import "MineCenterViewController.h"
#import "JoinViewController.h"
@interface UsersTableViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)UIButton *logBtn;

// 服务器返回的数据字典
@property (nonatomic,strong) NSDictionary *dictionary;
// 用户信息解析
@property (nonatomic,strong) NSDictionary *dictUserInfo;

// 是否登录
@property (nonatomic,assign) BOOL isLogin;
// 收藏个数
@property (nonatomic,strong) NSString *collectionnum;
// 订单个数
@property (nonatomic,strong) NSString *ordernum;



//修改
@property (nonatomic,weak)UIView *headView;
@property (nonatomic,weak)UIImageView *userImage;


@property (nonatomic,strong)NSString *publicToken;
@property (nonatomic,strong)NSString *myId;

@end

@implementation UsersTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *cookies;
    cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [defaults objectForKey: lsUserCookie]];
    if (cookies)
    {
        //[self removeCookie];
        [DictToData showMBHUBWithContent:@"玩命加载中..." ToView:self.view];
        self.dictUserInfo = [NSDictionary dictionary];
        self.dictionary = [NSDictionary dictionary];
        self.collectionnum = nil;
        self.ordernum = nil;
        [self setUI];
        if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
        {
            [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
        }
        else
        {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [self p_settingUpData];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setUI];
                    [self.tableView reloadData];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            });
            
            //融云相关
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                
                self.publicToken = [self getToken];
                
                [self setJoin];
                
            });
            
            
            
        }
        //加载缓存的图片，名字
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"name.png"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        if (image)
        {
            _userImage.image = image;
        }
        else
        {
            _userImage.image = [UIImage imageNamed:@"logot.png"];
        }
        
        //取出名字
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath2 = [documentPath stringByAppendingString:@"/name.txt"];
        
        NSString *avi = [NSString stringWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:nil];
        if (avi != nil)
        {
            [self.logBtn setTitle:avi forState:UIControlStateNormal];
        }
        else
        {
            [self.logBtn setTitle:@"" forState:UIControlStateNormal];
        }
        

        
    }
    else
    {
        JoinViewController *joinVC = [[JoinViewController alloc]init];
        [self.navigationController pushViewController:joinVC animated:YES];
        
    }

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dictionary = [NSDictionary dictionary];
    self.dictUserInfo = [NSDictionary dictionary];
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self p_settingUpData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUI];
                [self.tableView reloadData];
            });
        });
        
    }
    
//    [Reach reachability:^(LYReachability status) {
//        switch (status) {
//            case UNKNOW_NET:
//                NSLog(@"没有网");
//                break;
//            case NO_NET:
//                break;
//            case G_NET:
//                [self p_reloadDataa];
//                break;
//            case WIFI_NET:
//                [self p_reloadDataa];
//                break;
//            default:
//                break;
//        }
//    }];
    
    
    //设置背景颜色
    NSString *navBackgroundBarImage = [[NSBundle mainBundle] pathForResource:@"sytopd"ofType:@"png"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:navBackgroundBarImage] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"用户中心";
    
    
    //设置cell中间线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
     self.tableView.separatorColor = [UIColor colorWithRed:122/255.0f green:137/255.0f blue:142/255.0f alpha:1.0];
    
    [self.tableView registerClass:[UserTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"uitableviewcellsss"];
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // [self setUI];
}

-(void)p_reloadDataa
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self p_settingUpData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setUI];
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

// 加载数据
-(void)p_settingUpData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/Member/membercenter.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    // 数据解析
    NSString *login = [NSString stringWithFormat:@"%@",[dict objectForKey:@"login"]];
    if ([login isEqualToString:@"1"])
    {
        self.isLogin = YES;
        // 已经登录
        self.dictionary = [dict objectForKey:@"datas"];
        self.collectionnum = [_dictionary objectForKey:@"collectionnum"];
        self.ordernum = [_dictionary objectForKey:@"ordernum"];
        // 用户信息解析
        self.dictUserInfo = [_dictionary objectForKey:@"userinfo"];
        [self.tableView reloadData];
    }
    else
    {
        self.isLogin = NO;
        // 没有登录
    }
    
    
}
#pragma mark  私聊登录
-(void)setJoin
{
    [[RCIM sharedRCIM] connectWithToken:self.publicToken success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
}
#pragma mark 请求token
-(NSString *)getToken
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/Talk/gettoken.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *myToken = [[dict objectForKey:@"datas"]objectForKey:@"token"];
    NSString *myId =  [[dict objectForKey:@"datas"]objectForKey:@"userId"];
    self.myId = myId;
    NSUserDefaults *mypublicId = [NSUserDefaults standardUserDefaults];
    [mypublicId setObject:myId forKey:@"selfMyId"];
    
    // NSLog(@"%@",dict);
    NSLog(@"%@",[[dict objectForKey:@"datas"]objectForKey:@"error"]);
    return  myToken;
    
}


//设置cell分割线从最左边开始
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}






-(void)setUI
{
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 120)];
    
    //headView.backgroundColor = [UIColor colorWithRed:255/255.0f green:102/255.0f  blue:0/255.0f alpha:1.0f];
    headView.backgroundColor = [UIColor clearColor];
    _headView = headView;
    [self.view addSubview:_headView];

    UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
    userImage.layer.cornerRadius = 40.0;
    userImage.layer.masksToBounds = YES;
    //NSLog(@"=========%@",[self.dictUserInfo objectForKey:@"avatar"]);

   
    if (self.isLogin) {
        if (self.dictUserInfo == nil || self.dictUserInfo.count == 0 ||[[NSString stringWithFormat:@"%@",self.dictUserInfo] isEqualToString:@"<null>"])
        {
            userImage.image = [UIImage imageNamed:@"logot.png"];
            
        }
        else
        {
            //1.1版本修改
            userImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *PeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne)];
            userImage.userInteractionEnabled = YES;
            [userImage addGestureRecognizer:PeTap1];
            //从沙河中取出
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"name.png"];
           UIImage *image = [UIImage imageWithContentsOfFile:filePath];
            if (image)
            {
                 userImage.image = image;
            }
            else
            {
                // 显示自己的头像
               NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
                if (![str1 isEqualToString:@""])
                {
                    if ([[NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"avatar"]] isEqualToString:@"<null>"])
                    {
                        
                    }
                    else
                    {
                           [ userImage sd_setImageWithURL:[NSURL URLWithString:[str1 stringByAppendingString:[self.dictUserInfo objectForKey:@"avatar"]]]];
                    }
                    
                 
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"name.png"];   // 保存文件的名称
                    
                    [UIImagePNGRepresentation(userImage.image)writeToFile: filePath atomically:YES];
                    
                }
                else
                {
                     userImage.image = [UIImage imageNamed:@"logot.png"];
                }
                
            }
            
            //网络加载
//            if (![[NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"avatar"]] isEqualToString:@"<null>"])
//            {
//                // 显示自己的头像
//                NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
//                [ userImage sd_setImageWithURL:[NSURL URLWithString:[str1 stringByAppendingString:[self.dictUserInfo objectForKey:@"avatar"]]]];
//            }
//            else
//            {
//                userImage.image = [UIImage imageNamed:@"logot.png"];
//            }
        }
    }
    else
    {
        // 没有登录
        userImage.image = [UIImage imageNamed:@"logot.png"];
    }
    
    

    _userImage = userImage;
   [headView addSubview:_userImage];
        
    self.logBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    //self.logBtn.backgroundColor = [UIColor redColor];
    self.logBtn.frame = CGRectMake(CGRectGetMaxX(userImage.frame) +20, CGRectGetMaxY(userImage.frame) -55, 100, 30);
    self.logBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.logBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.logBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.logBtn addTarget:self action:@selector(logbtnAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.dictUserInfo == nil || self.dictUserInfo.count == 0)
    {
        [self.logBtn setTitle:@"立即登录/注册" forState:UIControlStateNormal];
    }
    else
    {
        
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath2 = [documentPath stringByAppendingString:@"/name.txt"];
        
        NSString *aviStr = [NSString stringWithContentsOfFile:filePath2 encoding:NSUTF8StringEncoding error:nil];
        if (aviStr == nil)
        {
            if (![[NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"market"]] isEqualToString:@"<null>"])
            {
                [self.logBtn setTitle:[self.dictUserInfo objectForKey:@"market"] forState:UIControlStateNormal];
                NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *filePath2 = [documentPath stringByAppendingString:@"/name.txt"];
                
                NSString *aviStr = self.logBtn.titleLabel.text;
                //写入
                [aviStr writeToFile:filePath2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            else
            {
                [self.logBtn setTitle:@"昵称" forState:UIControlStateNormal];
            }

        }
        else
        {
            [self.logBtn setTitle:aviStr forState:UIControlStateNormal];
        }
        
    }
        
        [headView addSubview:_logBtn];
    
   
    UILabel *mylabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 90, 45, 50, 30)];
    //mylabel.backgroundColor = [UIColor redColor];
    mylabel.text = @"主页";
    mylabel.textAlignment = NSTextAlignmentRight;
    [headView addSubview:mylabel];
    UIImageView *myImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(mylabel.frame) + 5, 50, 15, 20)];
    myImage1.image = [UIImage imageNamed:@"zhankai3.png"];
    [headView addSubview:myImage1];
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TagentAction)];
   [headView addGestureRecognizer:tapGesture];
    
    
    self.tableView.tableHeaderView = _headView;

}
-(void)TagentAction
{
    //角色选择
    
    
    
    
    NSString *myStr = [self getState];
    if ([myStr isEqualToString:@"yiren"])
    {
        MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
       mineVC.myImage = _userImage.image;
        mineVC.myindsx =1;
        
        [self.navigationController pushViewController:mineVC animated:YES];
    }
    else if ([myStr isEqualToString:@"huodongfang"])
    {
        MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
        mineVC.myImage = _userImage.image;
        mineVC.myindsx =3;
        
        [self.navigationController pushViewController:mineVC animated:YES];
    }
    else if ([myStr isEqualToString:@"sheying"])
    {
        MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
         mineVC.myImage = _userImage.image;
        mineVC.myindsx =2;
        
        [self.navigationController pushViewController:mineVC animated:YES];
    }
    else if ([myStr isEqualToString:@"putong"])
    {
        strangerTableViewController *strVC = [[strangerTableViewController alloc]init];
        [self.navigationController pushViewController:strVC animated:YES];
    }

}
-(void)imageActionOne
{
    //角色选择
    NSString *myStr = [self getState];
    if ([myStr isEqualToString:@"yiren"])
    {
        MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
        mineVC.myImage = _userImage.image;
        mineVC.myindsx =1;
        
        [self.navigationController pushViewController:mineVC animated:YES];
    }
    else if ([myStr isEqualToString:@"huodongfang"])
    {
        MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
        mineVC.myImage = _userImage.image;
        mineVC.myindsx =3;
        
        [self.navigationController pushViewController:mineVC animated:YES];
    }
    else if ([myStr isEqualToString:@"sheying"])
    {
        MineCenterViewController *mineVC = [[MineCenterViewController alloc]init];
        mineVC.myImage = _userImage.image;
        mineVC.myindsx =2;
        
        [self.navigationController pushViewController:mineVC animated:YES];
    }
    else if ([myStr isEqualToString:@"putong"])
    {
        strangerTableViewController *strVC = [[strangerTableViewController alloc]init];
        [self.navigationController pushViewController:strVC animated:YES];
    }
    
}

-(NSString *)getState
{
    NSString *urlStr1 = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/member/playjuese.html"];
    NSURL *url1 = [NSURL URLWithString:urlStr1];
    
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc]initWithURL:url1];
    
    [request1 setHTTPMethod:@"POST"];
    
    NSData *data1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
    
    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
   
    NSString *str = [[dict1 objectForKey:@"datas"]objectForKey:@"juese"];

    return str;
}



-(void)logbtnAction:(UIButton *)sender
{
    if ([self.logBtn.titleLabel.text isEqualToString:@"立即登录/注册"])
    {
        JoinViewController *joinVc = [[JoinViewController alloc]init];
        [self.navigationController pushViewController:joinVc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view 分组

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Incomplete implementation, return the number of sections
    return 3;
}
#pragma mark tableview 分组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0)
    {
        return 4;
    }
    if(section == 1)
    {
    
        return 3;
    
    }
    else
    {
    
        return 1;
    }
    
}
//表头高度
#pragma mark 设置标题头的宽度

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    
    return 10;
    
}

#pragma mark 设置标题尾的宽度

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    
    return 5;
    
}
#pragma mark 返回tableview高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
#pragma mark tableview 赋值等
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            KCellStyle;
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            cell.textLabel.text = @"我的收藏";
            cell.titLable.text = @"我的收藏";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            
            if (self.collectionnum == nil)
            {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.collectionnum;
            }
            return cell;
        }
        else if (indexPath.row == 1)
        {
            UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            KCellStyle;
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
//            cell.textLabel.text = @"我的购买";
            cell.titLable.text = @"我的购买";
             cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            if (self.ordernum == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ordernum;
            }
            return cell;
        }
        else if (indexPath.row == 2)
        {
            UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            KCellStyle;
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            if (![[NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"isyiren"]] isEqualToString:@"0"])
            {
//                cell.textLabel.text = @"艺人编辑";
                cell.titLable.text = @"艺人编辑";
            }
            else
            {
//                cell.textLabel.text = @"艺人申请";
                cell.titLable.text = @"艺人申请";
            }
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            return cell;
        }
        else
        {
//            cell.textLabel.text = @"我的收藏3";
            UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            KCellStyle;
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.titLable.text = @"我的聊天";
             cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            return cell;
        }
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
//            cell.textLabel.text = @"我的收藏4";
            UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.titLable.text = @"系统设置";
             cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            return cell;
        }
        else if (indexPath.row == 1)
        {
//            cell.textLabel.text = @"我的收藏5";
            UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            
            cell.titLable.text = @"关于我们";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            return cell;
        }
        else
        {
//            cell.textLabel.text = @"我的收藏6";
            UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.titLable.text = @"联系客服";
             cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            return cell;
        }
//        if (indexPath.row == 3)
//        {
//            cell.titLable.text = @"退出登录";
//            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
//        }
       
    }
    else
    {
//        if (indexPath.row == 0)
//        {
//          
//       }
        UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:@"uitableviewcellsss" forIndexPath:indexPath];
        //cells.backgroundColor = [UIColor clearColor];
        cells.textLabel.textColor = [UIColor colorWithRed:92 / 255.0  green:108 / 255.0 blue:107 / 255.0 alpha:1];
        cells.textLabel.text = @"退出登录";
        cells.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cells.textLabel.textAlignment = NSTextAlignmentCenter;
        cells.textLabel.backgroundColor = [UIColor clearColor];
        
        return cells;
        
    }
    
    // cell.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tongzhiqu.jpg"]];
   
}
#pragma mark cell点击事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        // 收藏
        if (indexPath.row == 0)
        {
            // 登录判断
            if (self.isLogin == NO)
            {
                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                 alView.tag = 1;
                alView.delegate =self;
                
                [alView show];
            }
            else
            {
                // 个数判断
                if ([_collectionnum isEqualToString:@"0"]) {
                    // 个数为0  请先进行收藏
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"还未收藏，请先收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    
                    [alView show];
                }
                else
                {
                    MyCollectViewController * myVC = [[MyCollectViewController alloc]init];
                    
                    [self.navigationController pushViewController:myVC animated:YES];
                }
                
            }
            
        }
        // 购买
        if (indexPath.row == 1)
        {
            //BuyMyselfTableViewController *buyMyselfVC = [[BuyMyselfTableViewController alloc] init];
            // 登录判断
            if (self.isLogin == NO)
            {
                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                 alView.tag = 1;
                alView.delegate =self;
                [alView show];
            }
            else
            {
                if ([_ordernum isEqualToString:@"0"]) {
                    // 没有购买记录
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您现在还没有购买记录呢" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    
                    [alView show];
                }
                else
                {
                    orderViewController *ordVC = [[orderViewController alloc]init];
                    [self.navigationController pushViewController:ordVC animated:YES];
                }
                
            }
            
            
            
            
        }
        if (indexPath.row == 2)
        {
            
            if (self.isLogin == NO)
            {
                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                 alView.tag = 1;
                alView.delegate =self;
                [alView show];
            }
            else
            {
//                ArtApplyTableViewController *applyVC = [[ArtApplyTableViewController alloc]init];
////                if ([[[self.dictionary objectForKey:@"userinfo"] objectForKey:@"isyiren"] isEqualToString:@"1"])
//                if (![[NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"isyiren"]] isEqualToString:@"0"])
//                {
//                    applyVC.isYiren = YES;
//                    applyVC.myPic = [[self.dictionary objectForKey:@"userinfo"] objectForKey:@"avatar"];
//                }
//                else
//                {
//                    applyVC.isYiren = NO;
//                }
//                [self.navigationController pushViewController:applyVC animated:YES];
                //角色选择
                [self TagentAction];
                

            }
        }
        if (indexPath.row == 3)
        {
            if (self.isLogin == NO)
            {
                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alView.tag = 1;
                [alView show];
            }
            else
            {
//                if (![[NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"isyiren"]] isEqualToString:@"0"]) {
//                    // 是艺人
//                    // 图片上传
//                    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//                    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - 10, 158);
//                    flowLayout.minimumInteritemSpacing = 3;
//                    // 上下间距
//                    flowLayout.minimumLineSpacing = 6;
//                    flowLayout.headerReferenceSize = CGSizeMake(0, 217 + 55 + 39 + 43 + 6 + (KScreenW - 6 - 8) / 3 + 30);
//                    // 设置整体四周边距  上、左、下、右
//                    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 15, 5);
//                    PicUploadCollectionViewController *picUploadVC = [[PicUploadCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
//                    [self.navigationController pushViewController:picUploadVC animated:YES];
                
                
                
             
                
                
             
//                
//                }
//                else
//                {
//                    // 不是艺人
//                    [AlertShow alertShowWithContent:@"您还不是艺人呢，请先申请成为艺人再来上传您的美照吧" Seconds:3];
//                }
                
                   YourTestChatViewController * youVC = [[YourTestChatViewController alloc]init];
                //聊天列表测试
                // ChatListViewController *chatListVC = [[ChatListViewController alloc] init];
                [self.navigationController pushViewController:youVC animated:YES];
                
                
            }
        }
     
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            if (self.isLogin == NO)
            {
                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                 alView.tag = 1;
                alView.delegate =self;
                [alView show];
            }
            else
            {
                NSLog(@"%@",[self.dictUserInfo objectForKey:@"avatar"] );
                SetViewController *setVC = [[SetViewController alloc]init];
                // 图片
                if ([[NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"avatar"]] isEqualToString:@"<null>"])
                {
                    
                }
                else
                {
                    setVC.picString = [NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"avatar"]];
                    setVC.nameString = [NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"market"]];
                    setVC.userName = [NSString stringWithFormat:@"%@",[self.dictUserInfo objectForKey:@"username"]];
                }
                
                [self.navigationController pushViewController:setVC animated:YES];
                
            }
           
        }
        if (indexPath.row == 1)
        {
//            if (self.isLogin == NO)
//            {
//                UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                alView.tag = 1;
//                alView.delegate =self;
//                [alView show];
//            }
//            else
//            {
//                AboutMianViewController *aboutVC = [[AboutMianViewController alloc]init];
//                
//                [self.navigationController pushViewController:aboutVC animated:YES];
//            }
            
            
            
//           //路人测试
//           // strangerTableViewController *myTab = [[strangerTableViewController alloc]init];
//            //活动方
//            //ActiveApplysTableViewController *myTab = [[ActiveApplysTableViewController alloc]init];
//            //影视方
//           // movieTableViewController *myTab = [[movieTableViewController alloc]init];
//            //角色选择
//            ConfirmViewController *myTab = [[ConfirmViewController alloc]init];
           // [self.navigationController pushViewController:myTab animated:YES];
            
            
            //聊天列表测试
            YourTestChatViewController *chatList = [[YourTestChatViewController alloc] init];
            [self.navigationController pushViewController:chatList animated:YES];
            
        }
        if (indexPath.row == 2)
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"是否拨打客服服务电话" message:@"0571-86752003" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            view.delegate = self;
            [view show];
        }
        
    }
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            [self.tableView reloadData];
            if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
            {
                [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
            }
            else
            {
                UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"注销" message:@"注销成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                
                [view show];
                [self outLogin];
                 [self removeCookie];
                //删除沙河缓存文件  、、 图像
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"name.png"];   // 保存文件的名称
                NSFileManager *manager = [NSFileManager defaultManager];
                [manager removeItemAtPath:filePath error:nil];
                  //昵称
                NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                NSString *filePath2 = [documentPath stringByAppendingString:@"/name.txt"];
                [manager removeItemAtPath:filePath2 error:nil];
              
                
                
                
                JoinViewController *jovc = [[JoinViewController alloc]init];
                //jovc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:jovc animated:YES];
            }
            
//            self.dictionary = nil;
//            self.dictUserInfo = nil;
//            self.collectionnum =nil;
//            self.ordernum = nil;
            //[self.logBtn setTitle:@"立即登录" forState:UIControlStateNormal];
           
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
        JoinViewController *joinVc = [[JoinViewController alloc]init];
        joinVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:joinVc animated:YES];
    }
    
    if (buttonIndex == 1)
    {
        if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
        {
            [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
        }
        else
        {
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *telURL =[NSURL URLWithString:@"tel:0571-86752003"];// 貌似tel:// 或者 tel: 都行
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            //记得添加到view上
            [self.view addSubview:callWebview];
        }
      
    }
 
}

-(void)outLogin
{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/outlogin.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //    // 准备参数
    //    NSString *argument = [NSString stringWithFormat:@"id=%@",artistId];
    //    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //    //设置URl参数
    //    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    

 
    //self.myIntro = [[dict objectForKey:@"datas"] objectForKey:@"info"];
    

}

- (void)loadCookies
{
    
    //判断是否存在
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *cookies;
    cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [defaults objectForKey: lsUserCookie]];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
}
-(void)removeCookie{
    //移除登录
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:lsUserCookie];
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

@end
