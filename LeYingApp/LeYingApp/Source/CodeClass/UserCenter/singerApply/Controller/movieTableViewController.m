//
//  movieTableViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/4/25.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "movieTableViewController.h"
#import "ArtApplyTableViewCell.h"
#import "ArtApplyPhoneTableViewCell.h"
#import "ArtSexTableViewCell.h"
#import "ArtPublicTableViewCell.h"
#import "ArtMessageTableViewCell.h"
#import "ArtPersonTableViewCell.h"
#import "ArtistNameViewController.h"
#import "ArtistSexViewController.h"
#import "TypeSelectedViewController.h"
#import "TypeBiaoqinViewController.h"
#import "LocalViewController.h"
#import "WeixinViewController.h"
#import "TelViewController.h"
#import "detailModel.h"
#import "EmailViewController.h"
#import "QQViewController.h"
#import "ArtApplyTableViewCell.h"
#import "ArtApplyPhoneTableViewCell.h"
#import "ArtSexTableViewCell.h"
#import "ArtPublicTableViewCell.h"
#import "ArtMessageTableViewCell.h"
#import "ArtPersonTableViewCell.h"
#import "ArtistNameViewController.h"
#import "ArtistSexViewController.h"
#import "TypeSelectedViewController.h"
#import "TypeBiaoqinViewController.h"
#import "LocalViewController.h"
#import "WeixinViewController.h"
#import "TelViewController.h"
#import "detailModel.h"
#import "EmailViewController.h"
#import "QQViewController.h"
#import "AlertShow.h"
#import "AlertShow.h"
#import "XingzhiViewController.h"
#import "GonglingViewController.h"
#import "LeixingViewController.h"
#import "QicaiViewController.h"
#import "IdentityViewController.h"

@interface movieTableViewController ()<passNameDelegate,passSexDelegate,UITextViewDelegate,UIPickerViewDataSource>







//@property (nonatomic,strong) UIView *myNewView;

@property (nonatomic,strong) NSString *mytypeNew;
@property (nonatomic,strong) NSString *myxingzhiNew;
@end

@implementation movieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isWeixinSelected = @"0";
    self.isTelSelected = @"0";
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 子线程中加载数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 设置初始化数据
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
        
    }
    
    
    
    self.tableView.scrollEnabled = NO;
    
    [self.tableView registerClass:[ArtApplyTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[ArtApplyPhoneTableViewCell class] forCellReuseIdentifier:@"phonecell"];
    
    [self.tableView registerClass:[ArtSexTableViewCell class] forCellReuseIdentifier:@"sexcell"];
    
    [self.tableView registerClass:[ArtPublicTableViewCell class] forCellReuseIdentifier:@"publiccell"];
    
    [self.tableView registerClass:[ArtMessageTableViewCell class] forCellReuseIdentifier:@"messagecell"];
    
    [self.tableView registerClass:[ArtPersonTableViewCell class] forCellReuseIdentifier:@"personcell"];

    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    self.tableView.scrollEnabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {
        return 3;
    }
    else if (section == 1)
    {
        return 9;
    }
    else
    {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"昵称";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            KCellStyle;
            cell.showLab.text = @"磊磊";
            // 设置艺名
            if (self.ArtistName == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistName;
            }
            return cell;
        }
        else if (indexPath.row == 1)
        {
            ArtSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sexcell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"性别";
            cell.remindLab.text = @"(性别一经提交不允许修改)";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            KCellStyle;
            // 设置性别
            if (self.ArtistSex == nil) {
                cell.showLab.text = @"男";
            }
            else
            {
                cell.showLab.text = self.ArtistSex;
            }
            return cell;
            
            
        }
        else if (indexPath.row == 2)
        {
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"地区";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            cell.showLab.text = @"浙江-杭州";
            // 设置地区
            if (self.ArtistLocal == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistLocal;
            }
            
            return cell;
        }
       
        else
        {
            return nil;
        }
    }
    if (indexPath.section == 1)
    {
        // 信息
        if (indexPath.row == 0)
        {
            // 性质
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.userInteractionEnabled = YES;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"身份";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            KCellStyle;

            // 设置性质
            if (self.ArtistXingzhi == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistXingzhi;
            }
            return cell;
        }
        else if (indexPath.row == 1)
        {
            // 工龄
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            //cell.userInteractionEnabled = NO;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"工龄";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            KCellStyle;
            //cell.showLab.text = @"磊磊";
            // 设置工龄
            if (self.ArtistGongling == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistGongling;
            }

            return cell;
        }
        else if (indexPath.row == 2)
        {
            // 类型
           ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            return cell;
        }
        else if (indexPath.row == 3)
        {
            // 器材
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            //cell.userInteractionEnabled = NO;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"器材";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            KCellStyle;
            //cell.showLab.text = @"磊磊";
            // 设置器材
            if (self.ArtistQicai == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistQicai;
            }
            
            return cell;
        }
        else if (indexPath.row == 4)
        {
            ArtPublicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publiccell" forIndexPath:indexPath];
            KCellStyle;
            
            cell.backgroundColor = [UIColor colorWithRed:116/255.0f green:126/255.0f blue:124/255.0f alpha:1.0];
            cell.publicLab.text = @"不公开：前台浏览的将不显示此号码，如果微信号与手机号都不公开则显示平台的联系方式";
            return cell;
        }
        else if (indexPath.row == 5)
        {
            ArtApplyPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phonecell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"微信号";
            cell.chooseLab.text = @"不公开";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            cell.showLab.text = @"123456";
            cell.chooseBtn.isWeixin = YES;
            [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
            [cell.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.chooseBtn.tag = 101;

            
            // 设置微信号
            if (self.ArtistWeixinNumber == nil) {
                cell.showLab.text = @"";
                cell.chooseBtn.isWeixin = YES;
            }
            else
            {
                cell.showLab.text = self.ArtistWeixinNumber;
                cell.chooseBtn.isWeixin = YES;
            }
            
            if ([self.isTelSelected isEqualToString:@"0"]) {
                [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
            }
            [cell.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.chooseBtn.tag = 101;
            return cell;
            
            
            
        }
        else if (indexPath.row == 6)
        {
            ArtApplyPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phonecell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"手机号";
            cell.chooseLab.text = @"不公开";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            cell.showLab.text = @"123456";
            cell.chooseBtn.isTel = YES;
            [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
            [cell.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.chooseBtn.tag = 101;

            // 设置手机号
            if (self.ArtistTelNumber == nil) {
                cell.showLab.text = @"";
                cell.chooseBtn.isTel = YES;
            }
            else
            {
                cell.showLab.text = self.ArtistTelNumber;
                cell.chooseBtn.isTel = YES;
            }
            
            if ([self.isTelSelected isEqualToString:@"0"]) {
                [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
            }
            [cell.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.chooseBtn.tag = 101;
            return cell;
            
            
        }
        else if (indexPath.row == 7)
        {
            
            
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.titLable.text = @"邮箱号";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            cell.showLab.text = @"123456";
            // 设置邮箱
            if (self.ArtistEmailNumber == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistEmailNumber;
            }
            return cell;
            
        }
        else
        {
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.titLable.text = @"QQ号";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            // 设置QQ号
            if (self.ArtistQQNumber == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistQQNumber;
            }
            
            return cell;
        }
    }
    else
    {
        self.artPersonTableviewCell = [tableView dequeueReusableCellWithIdentifier:@"personcell" forIndexPath:indexPath];
        // KCellStyle;
        self.artPersonTableviewCell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        
        self.artPersonTableviewCell.specificLab.text = @"个性签名";
        self.artPersonTableviewCell.workLab.text = @"主要作品";
        self.artPersonTableviewCell.lifeLab.text = @"人生经历";
          self.artPersonTableviewCell.specificText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
        self.artPersonTableviewCell.workText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
        self.artPersonTableviewCell.lifeText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
        // 个性签名 主要作品 人生经历  3.31  start
        if (self.ArtistSignature == nil)
        {
            
        }
        else
        {
            self.artPersonTableviewCell.specificText.text = self.ArtistSignature;
            self.artPersonTableviewCell.specificText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
            self.artPersonTableviewCell.specificText.layer.cornerRadius = 5;
            
        }
        
        if (self.ArtistMainWorks == nil) {
            
        }
        else
        {
            self.artPersonTableviewCell.workText.text = self.ArtistMainWorks;
            self.artPersonTableviewCell.workText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
            self.artPersonTableviewCell.workText.layer.cornerRadius = 5;
        }
        
        if (self.ArtistLifeExperience == nil) {
            self.artPersonTableviewCell.lifeText.text = @" ";
        }
        else
        {
            self.artPersonTableviewCell.lifeText.text = self.ArtistLifeExperience;
            self.artPersonTableviewCell.lifeText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
            self.artPersonTableviewCell.lifeText.layer.cornerRadius = 5;
            
        }
        self.artPersonTableviewCell.lifeText.delegate = self;
        
        
        return _artPersonTableviewCell;

    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 昵称
            ArtistNameViewController *artistNameVC = [[ArtistNameViewController alloc] init];
            artistNameVC.delegate = self;
            artistNameVC.strName = _ArtistName;
            [self.navigationController pushViewController:artistNameVC animated:YES];
        }
        else if (indexPath.row == 1)
        {
            // 性别
            ArtistSexViewController *artistSexVC = [[ArtistSexViewController alloc] init];
            artistSexVC.delegate = self;
            artistSexVC.strSex = self.ArtistSex;
            [self.navigationController pushViewController:artistSexVC animated:YES];
        }
        else
        {
            // 地区
            LocalViewController *localVC = [[LocalViewController alloc] init];
            localVC.mBlock = ^(NSString *str)
            {
                self.ArtistLocal = str;
                [self.tableView reloadData];
            };
            localVC.strLocation = self.ArtistLocal;
            [self.navigationController pushViewController:localVC animated:YES];
        }
    }
    else if (indexPath.section == 1)
    {
       
        if (indexPath.row == 0) {
            
            IdentityViewController *identity = [[IdentityViewController alloc]init];
            identity.block = ^(NSString *string){
                self.ArtistXingzhi = string;
                [self.tableView reloadData];
            };
            identity.identityString = self.ArtistXingzhi;
            identity.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:identity animated:YES];
        }
        else if (indexPath.row == 1)
        {
            // 工龄
            GonglingViewController *gonglingVC = [[GonglingViewController alloc] init];
            gonglingVC.mBlock = ^(NSString *str)
            {
                self.ArtistGongling = str;
                [self.tableView reloadData];
            };
            gonglingVC.strGongling = self.ArtistGongling;
            [self.navigationController pushViewController:gonglingVC animated:YES];
        }
        else if (indexPath.row == 2)
        {

        }
        else if (indexPath.row == 3)
        {
            // 器材
            QicaiViewController *qicaiVC = [[QicaiViewController alloc] init];
            qicaiVC.mBlock = ^(NSString *str)
            {
                self.ArtistQicai = str;
                [self.tableView reloadData];
            };
            qicaiVC.strQicai = self.ArtistQicai;
            [self.navigationController pushViewController:qicaiVC animated:YES];
        }
        else if (indexPath.row == 4)
        {
            // 提示信息
        }
        else if (indexPath.row == 5)
        {
            // 微信号
            WeixinViewController *weixinVC = [[WeixinViewController alloc] init];
            weixinVC.mBlock = ^(NSString *str)
            {
                self.ArtistWeixinNumber = str;
                [self.tableView reloadData];
            };
            weixinVC.strWeixin = self.ArtistWeixinNumber;
            [self.navigationController pushViewController:weixinVC animated:YES];
        }
        else if (indexPath.row == 6)
        {
            // 手机号
            TelViewController *telVC = [[TelViewController alloc] init];
            telVC.mBlock = ^(NSString *str)
            {
                self.ArtistTelNumber = str;
                [self.tableView reloadData];
            };
            telVC.strTel = self.ArtistTelNumber;
            [self.navigationController pushViewController:telVC animated:YES];
        }
        else if (indexPath.row == 7)
        {
            // 邮箱号
            EmailViewController *emailVC = [[EmailViewController alloc] init];
            emailVC.mBlock = ^(NSString *str)
            {
                self.ArtistEmailNumber = str;
                [self.tableView reloadData];
            };
            emailVC.strEmail = self.ArtistEmailNumber;
            [self.navigationController pushViewController:emailVC animated:YES];
        }
        else
        {
            // QQ号
            // QQ号
            QQViewController *qqVC = [[QQViewController alloc] init];
            qqVC.mBlock = ^(NSString *str)
            {
                self.ArtistQQNumber = str;
                [self.tableView reloadData];
            };
            qqVC.strQQ = _ArtistQQNumber;
            [self.navigationController pushViewController:qqVC animated:YES];
        }
    }
    else
    {
        
    }
}


-(void)chooseBtnAction:(HMButton *)sender
{
    if (sender.tag == 101)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        sender.tag = 102;
    }
    
    else  if (sender.tag == 102)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
        sender.tag = 101;
    }
    else
    {
        
    }
    
        if (sender.isTel && [sender.currentBackgroundImage isEqual:[UIImage imageNamed:@"checked2.png"]]) {
            self.isTelSelected = @"1";
        }
    
        if (sender.isWeixin && [sender.currentBackgroundImage isEqual:[UIImage imageNamed:@"checked2.png"]]) {
            self.isWeixinSelected = @"1";
        }
    
    
}
//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if (indexPath.row==2) {
            return 0;
        }
        if (indexPath.row == 4)
        {
            return 50;
        }
    }
    if (indexPath.section == 2)
    {
        return 480;
    }
    
    
    return 45;
}


/// 代理方法
-(void)passName:(NSString *)aName
{
    self.ArtistName = aName;
    [self.tableView reloadData];
}

-(void)passSex:(NSString *)sex
{
    self.ArtistSex = sex;
    [self.tableView reloadData];
}

@end
