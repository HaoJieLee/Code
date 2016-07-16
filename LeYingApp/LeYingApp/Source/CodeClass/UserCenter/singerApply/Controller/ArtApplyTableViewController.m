
//
//  ArtApplyTableViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtApplyTableViewController.h"
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
#import "UsersTableViewController.h"
#import "MineCenterViewController.h"


@interface ArtApplyTableViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,passNameDelegate,passSexDelegate,passSelectedType,passBiaoqianDelegate,UITextViewDelegate>
@property (nonatomic,assign)BOOL intag;



/// 身高pickerview
@property (nonatomic,strong) UIPickerView *heightPickerView;
@property (nonatomic,strong) NSMutableArray *heightMutableArray;


/// 体重pickerview
@property (nonatomic,strong) UIPickerView *weightPickerView;
@property (nonatomic,strong) NSMutableArray *weightMutableArray;


/// 三围pickerview
@property (nonatomic,strong) UIPickerView *sanweiPickerView;
@property (nonatomic,strong) NSMutableArray *sanweiMutableArray;


/// 尺码pickerview
@property (nonatomic,strong) UIPickerView *chimaPickerView;
@property (nonatomic,strong) NSMutableArray *chimaMutableArray;





@property (nonatomic,strong) NSString *ArtistLifeExper;


@property (nonatomic,strong) UIView *myNewView;





@end

@implementation ArtApplyTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.heightPickerView removeFromSuperview];
    [self.weightPickerView removeFromSuperview];
    [self.sanweiPickerView removeFromSuperview];
    [self.chimaPickerView removeFromSuperview];
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 数据初始化
    
    //[self p_UI];
    self.isWeixinSelected = @"0";
    self.isTelSelected = @"0";
    
    self.tableView.scrollEnabled = NO;
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
            //[self p_isYirenDataRequest];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        });
        
    }
   
    
    
    // 初始化
    self.heightMutableArray = [NSMutableArray array];
    NSString *heightPath = [[NSBundle mainBundle] pathForResource:@"Height.txt" ofType:nil];
    NSString *heightContent = [NSString stringWithContentsOfFile:heightPath encoding:NSUTF8StringEncoding error:nil];
    self.heightMutableArray = (NSMutableArray *)[heightContent componentsSeparatedByString:@"\n"];
    
    self.weightMutableArray = [NSMutableArray array];
    NSString *weightPath = [[NSBundle mainBundle] pathForResource:@"Weight.txt" ofType:nil];
    NSString *weightContent = [NSString stringWithContentsOfFile:weightPath encoding:NSUTF8StringEncoding error:nil];
    self.weightMutableArray = (NSMutableArray *)[weightContent componentsSeparatedByString:@"\n"];
    
    self.sanweiMutableArray = [NSMutableArray array];
    NSString *sanweiPath = [[NSBundle mainBundle] pathForResource:@"Sanwei.txt" ofType:nil];
    NSString *sanweiContent = [NSString stringWithContentsOfFile:sanweiPath encoding:NSUTF8StringEncoding error:nil];
    self.sanweiMutableArray = (NSMutableArray *)[sanweiContent componentsSeparatedByString:@"\n"];
    
    self.chimaMutableArray = [NSMutableArray array];
    NSString *chimaPath = [[NSBundle mainBundle] pathForResource:@"Chima.txt" ofType:nil];
    NSString *chimaContent = [NSString stringWithContentsOfFile:chimaPath encoding:NSUTF8StringEncoding error:nil];
    self.chimaMutableArray = (NSMutableArray *)[chimaContent componentsSeparatedByString:@"\n"];
    
    
    
    [self.tableView registerClass:[ArtApplyTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[ArtApplyPhoneTableViewCell class] forCellReuseIdentifier:@"phonecell"];
    
    [self.tableView registerClass:[ArtSexTableViewCell class] forCellReuseIdentifier:@"sexcell"];
    
     [self.tableView registerClass:[ArtPublicTableViewCell class] forCellReuseIdentifier:@"publiccell"];
    
    [self.tableView registerClass:[ArtMessageTableViewCell class] forCellReuseIdentifier:@"messagecell"];
    
    [self.tableView registerClass:[ArtPersonTableViewCell class] forCellReuseIdentifier:@"personcell"];
    
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    
    /// 身高
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    _heightPickerView = pickerView;
//    [self.heightPickerView reloadAllComponents];
    self.heightPickerView.delegate = self;
    self.heightPickerView.dataSource = self;
    self.heightPickerView.tag = 1000;
    
    /// 体重
    UIPickerView *pickerView1 = [[UIPickerView alloc] init];
    _weightPickerView = pickerView1;
    self.weightPickerView.delegate = self;
    self.weightPickerView.dataSource = self;
    self.weightPickerView.tag = 1001;
    
    /// 三围
    UIPickerView *pickerView2 = [[UIPickerView alloc] init];
    _sanweiPickerView = pickerView2;
    self.sanweiPickerView.delegate = self;
    self.sanweiPickerView.dataSource = self;
    self.sanweiPickerView.tag = 1002;
    
    /// 尺码
    UIPickerView *pickerView3 = [[UIPickerView alloc] init];
    _chimaPickerView = pickerView3;
    self.chimaPickerView.delegate = self;
    self.chimaPickerView.dataSource = self;
    self.chimaPickerView.tag = 1003;


}
// 判断数字
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark 保存
/// 保存全部数据
-(void)rightBarButtonAction
{
    // 组织数据 上传数据
    NSLog(@"哈哈哈，要保存了");

    
}

-(void)leftBarButtonAction:(UIBarButtonItem *)sender
{
    [self.heightPickerView removeFromSuperview];
    [self.weightPickerView removeFromSuperview];
    [self.sanweiPickerView removeFromSuperview];
    [self.chimaPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)p_UI
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    self.backView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_backView];
    
    self.myImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2 -30, 20, 60, 60)];
    self.myImage.image = [UIImage imageNamed:@"logo.png"];
    self.myImage.layer.cornerRadius = 30;
    self.myImage.layer.masksToBounds = YES;
    [self.backView addSubview:_myImage];
    
    
    
    
    
    self.tableView.tableHeaderView = _backView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    
    if (section == 0)
    {
        return 3;
    }
    if (section == 2)
    {
        return 3;
    }
    
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.userInteractionEnabled = NO;
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"艺名";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            KCellStyle;
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
        
        if (indexPath.row == 1)
        {
            ArtSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sexcell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"性别";
            cell.remindLab.text = @"(一经提交不允许修改)";
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
        if (indexPath.row == 2)
        {
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"地区";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
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
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            ArtMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messagecell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            KCellStyle;
             cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
             cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
           
            
            //设置btn
             [cell.heightBtn setBackgroundImage:[UIImage imageNamed:@"shenqing1.png"] forState:UIControlStateNormal];
            [cell.heightBtn addTarget:self action:@selector(heightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.weightBtn setBackgroundImage:[UIImage imageNamed:@"shenqing2.png"] forState:UIControlStateNormal];
            [cell.weightBtn addTarget:self action:@selector(weightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.mensurationsBtn setBackgroundImage:[UIImage imageNamed:@"shenqing3.png"] forState:UIControlStateNormal];
            [cell.mensurationsBtn addTarget:self action:@selector(mensurationsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sizeBtn setBackgroundImage:[UIImage imageNamed:@"shenqing4.png"] forState:UIControlStateNormal];
            [cell.sizeBtn addTarget:self action:@selector(sizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            /// 设置身高
            if (self.heightNew == nil) {
                cell.heightLab.text = @"";
            }
            else
            {
                cell.heightLab.text = [NSString stringWithFormat:@"%@cm",_heightNew];
            }
            /// 设置体重
            if (self.weightNew == nil) {
                cell.weightLab.text = @"";
            }
            else
            {
                cell.weightLab.text = [NSString stringWithFormat:@"%@kg",_weightNew];
            }
            /// 设置三围
            if (self.sanweiNew1 == nil && self.sanweiNew2 == nil && self.sanweiNew3 == nil) {
                cell.mensurationLab.text = @"";
            }
            else
            {
                cell.mensurationLab.text = [NSString stringWithFormat:@"%@/%@/%@",_sanweiNew1,_sanweiNew2,_sanweiNew3];
            }
            /// 设置尺码
            if (self.chimaNew == nil) {
                cell.sizeLab.text = @"";
            }
            else
            {
                cell.sizeLab.text = [NSString stringWithFormat:@"%@码",_chimaNew];
            }
            return cell;
        }
        
        if (indexPath.row == 1)
        {
            ArtPublicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publiccell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            KCellStyle;
            
             cell.backgroundColor = [UIColor colorWithRed:116/255.0f green:126/255.0f blue:124/255.0f alpha:1.0];
            cell.publicLab.text = @"不公开：前台浏览的将不显示此号码，如果微信号与手机号都不公开则显示平台的联系方式";
            return cell;
        }
        if (indexPath.row == 2)
        {
            ArtApplyPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phonecell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"微信号";
             cell.chooseLab.text = @"不公开";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            
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
        if (indexPath.row == 3)
        {
            ArtApplyPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phonecell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"手机号";
            cell.chooseLab.text = @"不公开";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
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
        if (indexPath.row == 4)
        {
            
            
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.titLable.text = @"邮箱号";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
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
        if (indexPath.row == 5)
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
        if (indexPath.row == 0)
        {
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"类型";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            
            if (self.ArtistType == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistType;
            }
            return cell;
        }
        if (indexPath.row == 1)
        {
            ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
            cell.titLable.text = @"标签";
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            if (self.ArtistBiaoqian == nil) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.ArtistBiaoqian;
            }
            return cell;
        }
        if (indexPath.row == 2)
        {
            self.artPersonTableviewCell = [tableView dequeueReusableCellWithIdentifier:@"personcell" forIndexPath:indexPath];
            self.artPersonTableviewCell.selectionStyle = UITableViewCellSeparatorStyleNone;
            self.artPersonTableviewCell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            self.artPersonTableviewCell.specificText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
            self.artPersonTableviewCell.workText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
            self.artPersonTableviewCell.lifeText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
            
            self.artPersonTableviewCell.specificLab.text = @"个性签名";
            self.artPersonTableviewCell.lifeLab.text = @"人生经历";
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
    return 0;
    
    
}


#pragma mark PickerView
/// uipickerView 代理方法
// 列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (pickerView.tag) {
        case 1000:
            /// 身高
            return 2;
            break;
        case 1001:
            // 体重
            return 2;
            break;
        case 1002:
            /// 三围
            return 3;
            break;
        case 1003:
            /// 尺寸
            return 2;
            break;
        default:
            return 0;
            break;
    }
}

// 行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1000:
            /// 身高
            if (component == 0) {
                return self.heightMutableArray.count;
            }
            else if (component == 1)
            {
                // 单位
                return 1;
            }
            else
            {
                return 0;
            }
            break;
        case 1001:
            // 体重
            if (component == 0) {
                return self.weightMutableArray.count;
            }
            else if (component == 1)
            {
                // 单位
                return 1;
            }
            else
            {
                return 0;
            }
            break;
        case 1002:
            /// 三围
            if (component == 0) {
                return self.sanweiMutableArray.count;
            }
            else if (component == 1)
            {
                return self.sanweiMutableArray.count;
            }
            else if (component == 2)
            {
                return self.sanweiMutableArray.count;
            }
            else
            {
                return 0;
            }
            break;
        case 1003:
            /// 尺寸
            if (component == 0) {
                return self.chimaMutableArray.count;
            }
            else if (component == 1)
            {
                // 单位
                return 1;
            }
            else
            {
                return 0;
            }
            break;
        default:
            return 0;
            break;
    }
}

// 每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1000:
            /// 身高
            if (component == 0) {
                return self.heightMutableArray[row];
            }
            else if (component == 1)
            {
                // 单位
                return @"厘米";
            }
            else
            {
                return nil;
            }
            break;
        case 1001:
            // 体重
            if (component == 0) {
                return self.weightMutableArray[row];
            }
            else if (component == 1)
            {
                // 单位
                return @"kg";
            }
            else
            {
                return nil;
            }
            break;
        case 1002:
            /// 三围
            if (component == 0) {
                return self.sanweiMutableArray[row];
            }
            else if (component == 1)
            {
                return self.sanweiMutableArray[row];
            }
            else if (component == 2)
            {
                return self.sanweiMutableArray[row];
            }
            else
            {
                return nil;
            }
            break;
        case 1003:
            /// 尺寸
            if (component == 0) {
                return self.chimaMutableArray[row];
            }
            else if (component == 1)
            {
                // 单位
                return @"码";
            }
            else
            {
                return nil;
            }
            break;
        default:
            return nil;
            break;
    }
}

// 是否选中某行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (pickerView.tag) {
        case 1000:
            /// 身高
            self.heightNew = self.heightMutableArray[row];
            break;
        case 1001:
            // 体重
            self.weightNew = self.weightMutableArray[row];
            break;
        case 1002:
            /// 三围
            if (component == 0) {
                self.sanweiNew1 = self.sanweiMutableArray[row];
            }
            else if (component == 1)
            {
                self.sanweiNew2 = self.sanweiMutableArray[row];
            }
            else if (component == 2)
            {
                self.sanweiNew3 = self.sanweiMutableArray[row];
            }
            else
            {
                
            }
            break;
        case 1003:
            /// 尺寸
            self.chimaNew = self.chimaMutableArray[row];
            break;
        default:
            break;
    }
}

//

/// 身高
-(void)heightBtnAction:(UIButton *)sender
{
    // 设置默认值
    self.heightNew = self.heightMutableArray[0];
    // 首先隐藏其他的pickerview
//    self.weightPickerView.hidden = YES;
//    self.sanweiPickerView.hidden = YES;
//    self.chimaPickerView.hidden = YES;
//    self.heightPickerView.hidden = NO;
    [self.weightPickerView removeFromSuperview];
    [self.sanweiPickerView removeFromSuperview];
    [self.chimaPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    // 设置自己的pickerview
    self.heightPickerView.frame = CGRectMake(0, KScreenH - 162, KScreenW, 162);
    self.heightPickerView.backgroundColor = KPickerColor;
//    [self.view addSubview:_heightPickerView];
    [self.tableView.superview.superview.superview addSubview:_heightPickerView];
    self.myNewView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.heightPickerView.frame) - 30, KScreenW, 30)];
    self.myNewView.backgroundColor = KPickerColor;
    [self.tableView.superview.superview.superview addSubview:_myNewView];
    
    UIButton *btnHeight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHeight.frame = CGRectMake(KScreenW - 10 - 100, 4, 100, 22);
    [btnHeight setTitle:@"完成" forState:UIControlStateNormal];
    [btnHeight addTarget:self action:@selector(btnHeightAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnHeight setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnHeight];
    UIButton *btnHeightCancle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHeightCancle.frame = CGRectMake(10, CGRectGetMinY(btnHeight.frame), 100, 22);
    [btnHeightCancle setTitle:@"取消" forState:UIControlStateNormal];
    [btnHeightCancle addTarget:self action:@selector(btnHeightCancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnHeightCancle setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnHeightCancle];
}

// 完成  按钮事件
-(void)btnHeightAction:(UIButton *)sender
{
    [self.myNewView removeFromSuperview];
    [self.heightPickerView removeFromSuperview];
//    // 隐藏
//    self.heightPickerView.hidden = YES;
//    sender.hidden = YES;
//    self.myNewView.hidden = YES;
    // 修改值
    [self.tableView reloadData];
}

-(void)btnHeightCancleAction:(UIButton *)sender
{
    // 回复原先值
    self.heightNew = nil;
    // 隐藏
//    self.heightPickerView.hidden = YES;
//    sender.hidden = YES;
//    self.myNewView.hidden = YES;
    [self.heightPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
}

/// 体重
-(void)weightBtnAction:(UIButton *)sender
{
    NSLog(@"体重体重");
    // 设置默认值
    self.weightNew = self.weightMutableArray[0];
    // 首先隐藏其他的pickerview
//    self.heightPickerView.hidden = YES;
//    self.sanweiPickerView.hidden = YES;
//    self.chimaPickerView.hidden = YES;
//    self.weightPickerView.hidden = NO;
    [self.heightPickerView removeFromSuperview];
    [self.sanweiPickerView removeFromSuperview];
    [self.chimaPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    // 设置自己的pickerview
    self.weightPickerView.frame = CGRectMake(0, KScreenH - 162, KScreenW, 162);
    self.weightPickerView.backgroundColor = KPickerColor;
    [self.tableView.superview.superview.superview addSubview:_weightPickerView];
    
    self.myNewView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.weightPickerView.frame) - 30, KScreenW, 30)];
    self.myNewView.backgroundColor = KPickerColor;
//    self.myNewView.backgroundColor = [UIColor redColor];
    [self.tableView.superview.superview.superview addSubview:_myNewView];
    
    UIButton *btnWeight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnWeight.frame = CGRectMake(KScreenW - 10 - 100, 4, 100, 22);
    [btnWeight setTitle:@"完成" forState:UIControlStateNormal];
    [btnWeight addTarget:self action:@selector(btnWeightAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnWeight setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnWeight];
    UIButton *btnWeightCancle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnWeightCancle.frame = CGRectMake(10, CGRectGetMinY(btnWeight.frame), 100, 22);
    [btnWeightCancle setTitle:@"取消" forState:UIControlStateNormal];
    [btnWeightCancle addTarget:self action:@selector(btnWeightCancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnWeightCancle setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnWeightCancle];
}

/// 体重确定按钮
-(void)btnWeightAction:(UIButton *)sender
{
    // 隐藏
//    self.weightPickerView.hidden = YES;
//    sender.hidden = YES;
//    self.myNewView.hidden = YES;
    [self.weightPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    // 修改值
    [self.tableView reloadData];
}
/// 体重取消按钮
-(void)btnWeightCancleAction:(UIButton *)sender
{
    // 回复默认值
    self.weightNew = nil;
    // 隐藏
//    self.weightPickerView.hidden = YES;
//    sender.hidden = YES;
//    self.myNewView.hidden = YES;
    [self.weightPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
}

/// 三围
-(void)mensurationsBtnAction:(UIButton *)sender
{
    // 设置默认值
    self.sanweiNew1 = self.sanweiMutableArray[0];
    self.sanweiNew2 = self.sanweiMutableArray[0];
    self.sanweiNew3 = self.sanweiMutableArray[0];
    // 首先隐藏其他的pickerview
//    self.heightPickerView.hidden = YES;
//    self.sanweiPickerView.hidden = NO;
//    self.chimaPickerView.hidden = YES;
//    self.weightPickerView.hidden = YES;
    [self.heightPickerView removeFromSuperview];
    [self.chimaPickerView removeFromSuperview];
    [self.weightPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    // 设置自己的pickerview
    self.sanweiPickerView.frame = CGRectMake(0, KScreenH - 162, KScreenW, 162);
    self.sanweiPickerView.backgroundColor = KPickerColor;
    [self.tableView.superview.superview.superview addSubview:_sanweiPickerView];
    
    self.myNewView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.sanweiPickerView.frame) - 30, KScreenW, 30)];
    self.myNewView.backgroundColor = KPickerColor;
    [self.tableView.superview.superview.superview addSubview:_myNewView];
    
    UIButton *btnSanwei = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSanwei.frame = CGRectMake(KScreenW - 10 - 100, 4, 100, 22);
    [btnSanwei setTitle:@"完成" forState:UIControlStateNormal];
    [btnSanwei addTarget:self action:@selector(btnSanweiAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnSanwei setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnSanwei];
    UIButton *btnSanweiCancle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSanweiCancle.frame = CGRectMake(10, CGRectGetMinY(btnSanwei.frame), 100, 22);
    [btnSanweiCancle setTitle:@"取消" forState:UIControlStateNormal];
    [btnSanweiCancle addTarget:self action:@selector(btnSanweiCancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnSanweiCancle setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnSanweiCancle];
}

/// 确定按钮事件
-(void)btnSanweiAction:(UIButton *)sender
{
    // 隐藏
//    self.sanweiPickerView.hidden = YES;
//    sender.hidden = YES;
//    self.myNewView.hidden = YES;
    [self.sanweiPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    // 修改值
    [self.tableView reloadData];
}

/// 取消按钮事件
-(void)btnSanweiCancleAction:(UIButton *)sender
{
    // 回复默认值
    self.sanweiNew1 = nil;
    self.sanweiNew2 = nil;
    self.sanweiNew3 = nil;
    // 隐藏
//    self.sanweiPickerView.hidden = YES;
//    sender.hidden = YES;
//    self.myNewView.hidden = YES;
    [self.sanweiPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
}

/// 尺寸
-(void)sizeBtnAction:(UIButton *)sender
{
    // 设置默认值
    self.chimaNew = self.chimaMutableArray[0];
    // 首先隐藏其他的pickerview

    [self.heightPickerView removeFromSuperview];
    [self.sanweiPickerView removeFromSuperview];
    [self.weightPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    // 设置自己的pickerview
    self.chimaPickerView.frame = CGRectMake(0, KScreenH - 162, KScreenW, 162);
    self.chimaPickerView.backgroundColor = KPickerColor;
    [self.tableView.superview.superview.superview addSubview:_chimaPickerView];
    
    self.myNewView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(self.sanweiPickerView.frame) - 30, KScreenW, 30)];
    self.myNewView.backgroundColor = KPickerColor;
    [self.tableView.superview.superview.superview addSubview:_myNewView];
    
    UIButton *btnChima = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChima.frame = CGRectMake(KScreenW - 10 - 100, 4, 100, 22);
    [btnChima setTitle:@"完成" forState:UIControlStateNormal];
    [btnChima addTarget:self action:@selector(btnChimaAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnChima setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnChima];
    UIButton *btnChimaCancle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChimaCancle.frame = CGRectMake(10, CGRectGetMinY(btnChima.frame), 100, 22);
    [btnChimaCancle setTitle:@"取消" forState:UIControlStateNormal];
    [btnChimaCancle addTarget:self action:@selector(btnChimaCancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnChimaCancle setTitleColor:KPickerFontColor forState:UIControlStateNormal];
    [_myNewView addSubview:btnChimaCancle];
}

/// 确定按钮事件
-(void)btnChimaAction:(UIButton *)sender
{
    // 隐藏
//    self.chimaPickerView.hidden = YES;
//    sender.hidden = YES;
//    self.myNewView.hidden = YES;
    [self.chimaPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
    // 修改值
    [self.tableView reloadData];
}

/// 取消按钮事件
-(void)btnChimaCancleAction:(UIButton *)sender
{
    // 回复默认值
    self.chimaNew = nil;
    // 移除
    [self.chimaPickerView removeFromSuperview];
    [self.myNewView removeFromSuperview];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 艺名
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
        else if (indexPath.row == 2)
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
        else
        {
            
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            // 身高三围cell
        }
        else if (indexPath.row == 1)
        {
            // 注释cell
        }
        else if (indexPath.row == 2)
        {
            // 微信
            WeixinViewController *weixinVC = [[WeixinViewController alloc] init];
            weixinVC.mBlock = ^(NSString *str)
            {
                self.ArtistWeixinNumber = str;
                [self.tableView reloadData];
            };
            weixinVC.strWeixin = self.ArtistWeixinNumber;
            [self.navigationController pushViewController:weixinVC animated:YES];
        }
        else if (indexPath.row == 3)
        {
            // 手机
            TelViewController *telVC = [[TelViewController alloc] init];
            telVC.mBlock = ^(NSString *str)
            {
                self.ArtistTelNumber = str;
                [self.tableView reloadData];
            };
            telVC.strTel = self.ArtistTelNumber;
            [self.navigationController pushViewController:telVC animated:YES];
        }
        else if (indexPath.row == 4)
        {
            // 邮箱
            EmailViewController *emailVC = [[EmailViewController alloc] init];
            emailVC.mBlock = ^(NSString *str)
            {
                self.ArtistEmailNumber = str;
                [self.tableView reloadData];
            };
            emailVC.strEmail = self.ArtistEmailNumber;
            [self.navigationController pushViewController:emailVC animated:YES];
        }
        else if (indexPath.row == 5)
        {
            // QQ
            QQViewController *qqVC = [[QQViewController alloc] init];
            qqVC.mBlock = ^(NSString *str)
            {
                self.ArtistQQNumber = str;
                [self.tableView reloadData];
            };
            qqVC.strQQ = _ArtistQQNumber;
            [self.navigationController pushViewController:qqVC animated:YES];
        }
        else
        {
            // 有错
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            // 类型
            TypeSelectedViewController *typeSelectVC = [[TypeSelectedViewController alloc] init];
            typeSelectVC.delegate = self;

            if (self.ArtistType != nil) {
                typeSelectVC.typeidStr = self.ArtistTypeId;
            }
            [self.navigationController pushViewController:typeSelectVC animated:YES];
        }
        else if (indexPath.row == 1)
        {
            // 标签
            TypeBiaoqinViewController *typeBiaoqianVC = [[TypeBiaoqinViewController alloc] init];
            typeBiaoqianVC.delegate = self;
            if (![self.ArtistBiaoqian isEqualToString:@""]) {
                typeBiaoqianVC.biaoqianIdStr = self.ArtistBiaoqianId;
            }
            [self.navigationController pushViewController:typeBiaoqianVC animated:YES];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    if (section == 0)
    {
        view.backgroundColor = [UIColor colorWithRed:139/255.0f green:139/255.0f blue:130/255.0f alpha:1.0];
    }
    
    //view.backgroundColor = [UIColor redColor];
    return view;
}

//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            return 110;
        }
        if (indexPath.row == 1)
        {
            return 50;
        }
    }
    if (indexPath.section == 2)
    {
        if (indexPath.row == 2)
        {
            return 250;
        }
    }
    
    
    return 45;
}

//返回tableview  表头高度

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0 )
    {
        return 0;
    }
    else
    {
          return 6;
    }
    
    
  
   
}


#pragma -------------代理传值----------------

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

-(void)passBiaoqian:(NSString *)aBiaoqian
{
    self.ArtistBiaoqian = aBiaoqian;
    [self.tableView reloadData];
}

-(void)passBiaoqianId:(NSString *)aid
{
    self.ArtistBiaoqianId = aid;
    [self.tableView reloadData];
}

-(void)passType:(NSString *)aType
{
    self.ArtistType = aType;
    [self.tableView reloadData];
}

-(void)passtypeId:(NSArray *)aid
{
    self.ArtistTypeId = aid;
    [self.tableView reloadData];
}



@end
