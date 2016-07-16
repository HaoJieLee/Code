//
//  strangerTableViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/4/25.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "strangerTableViewController.h"
#import "ArtApplyTableViewCell.h"
#import "ArtApplyPhoneTableViewCell.h"
#import "ArtPersonTableViewCell.h"
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
#import "ZhiyeViewController.h"
#import "ArtSexTableViewCell.h"
#import <AFNetworking.h>


#import "QiniuSDK.h"


@interface strangerTableViewController ()<passNameDelegate,passSexDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) ArtPersonTableViewCell *cell;

/// 经修改后重新赋值
@property (nonatomic,strong) NSString *ArtistName;
@property (nonatomic,strong) NSString *ArtistSex;

@property (nonatomic,strong) NSString *ArtistLocal;
@property (nonatomic,strong) NSString *ArtistWeixinNumber;
@property (nonatomic,strong) NSString *ArtistTelNumber;
@property (nonatomic,strong) NSString *ArtistEmailNumber;
@property (nonatomic,strong) NSString *ArtistQQNumber;
// 职业
@property (nonatomic,strong) NSString *ArtistZhiye;
// 个性签名 主要作品 人生经历   3.31 start
@property (nonatomic,strong) NSString *ArtistSignature;


@property (nonatomic,strong)UIButton *certifyButton;
@property (nonatomic,strong) NSString *isWeixinSelected;
@property (nonatomic,strong) NSString *isTelSelected;
// 头像
@property (nonatomic,strong) UIImage *currentImg;

@end

@implementation strangerTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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
            [self p_isYirenDataRequest];
            dispatch_async(dispatch_get_main_queue(), ^{
                _nameLable.text = _ArtistName;
                _introduceLable.text = _ArtistSignature;
                [self.tableView reloadData];
            });
        });
        
    }
    
    [self.tableView registerClass:[ArtApplyTableViewCell class] forCellReuseIdentifier:@"namecell"];
    [self.tableView registerClass:[ArtSexTableViewCell class] forCellReuseIdentifier:@"sexcell"];
    [self.tableView registerClass:[ArtApplyPhoneTableViewCell class] forCellReuseIdentifier:@"phonecell"];
    [self.tableView registerClass:[ArtPersonTableViewCell class] forCellReuseIdentifier:@"personcell"];
    //设置背景
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    //设置cell中间线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithRed:122/255.0f green:137/255.0f blue:142/255.0f alpha:1.0];
    [self setUP];
    self.tableView.tableHeaderView = _topView;
    self.tableView.scrollEnabled = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    
}

#pragma mark 数据请求
// 数据请求
-(void)p_isYirenDataRequest
{
    
        NSString *string = [Factory randomlyString];
        
        NSString *timeString = [Factory TimeToDataString];
        
        NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
        NSDictionary *dict =[[getDataHand shareHandLineData] RefreshUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString  Nonce:string];
    //是否已认证
    if ([[dict objectForKey:@"authentication"] isEqualToString:@"1"]) {
        [self.certifyButton setBackgroundImage:[UIImage imageNamed:@"yb1"] forState:UIControlStateNormal];
    }else{
        [self.certifyButton setBackgroundImage:[UIImage imageNamed:@"yb1"] forState:UIControlStateNormal];
    }
    self.ArtistName = [dict objectForKey:@"nicename"];
    // 非零即为真  真为女  假为男   3.31 start   1 男   2  女
    NSLog(@"%@",[dict  objectForKey:@"gender"]);
    if ([[dict objectForKey:@"gender"] isEqualToString:@"1"]) {
        self.ArtistSex = @"男";
    }
    else
    {
        self.ArtistSex = @"女";
    }
    self.ArtistZhiye = [NSString stringWithFormat:@"%@",[dict   objectForKey:@"yingId"]];
    self.ArtistLocal = [NSString stringWithFormat:@"%@",[dict   objectForKey:@"location"]];
    self.ArtistWeixinNumber = [NSString stringWithFormat:@"%@",[dict   objectForKey:@"wechat"]];
    self.ArtistTelNumber = [NSString stringWithFormat:@"%@",[dict   objectForKey:@"phone"]];
    self.isWeixinSelected = [dict  objectForKey:@"isWechatOpen"];
    self.isTelSelected = [dict   objectForKey:@"isPhoneOpen"];
    self.ArtistEmailNumber = [NSString stringWithFormat:@"%@",[dict   objectForKey:@"email"]];
    self.ArtistQQNumber = [NSString stringWithFormat:@"%@",[dict   objectForKey:@"qq"]];
        // 个性签名设置
    self.ArtistSignature = [NSString stringWithFormat:@"%@",[dict   objectForKey:@"motto"]];
}

#pragma mark 提交数据
// 提交数据
-(void)rightAction
{
    // 普通
    NSString *string = [Factory randomlyString];
    NSString *timeString = [Factory TimeToDataString];
    NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *argument = [NSString stringWithFormat:@"nicename=%@&gender=%@&location=%@&qq=%@&email=%@&phone=%@&wechat=%@&isWechatOpen=%@&isPhoneOpen=%@&motto=%@",self.ArtistName,self.ArtistSex,self.ArtistLocal,self.ArtistQQNumber,self.ArtistEmailNumber,self.ArtistTelNumber,self.ArtistWeixinNumber,self.isWeixinSelected,self.isTelSelected,self.cell.specificText.text];
        
        //人生经历description
        NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Key:argument];
        NSLog(@"%@",[dic objectForKey:@"message"]);
        
        
           });
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



-(void)setUP
{
    //设置顶部背景
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 130)];
    //self.topView.backgroundColor = [UIColor redColor];
    self.topView.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [self.view addSubview:_topView];
    
    
    //设置头部图片
    self.headImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(self.topView.frame)/2-CGRectGetWidth(self.view.frame) *0.21/2, CGRectGetWidth(self.view.frame) *0.21, CGRectGetWidth(self.view.frame) *0.21)];
    self.headImage1.backgroundColor = [UIColor colorWithRed:232/255.0f green:227/255.0f blue:239/255.0f alpha:1.0];
    self.headImage1.layer.cornerRadius = CGRectGetWidth(self.view.frame) *0.21/2;
    self.headImage1.image = [UIImage imageNamed:@"logo.png"];
    self.headImage1.layer.masksToBounds = YES;
    [self.topView addSubview:_headImage1];
    // 给headImage1添加点击事件
    _headImage1.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTapp =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [_headImage1 addGestureRecognizer:singleTapp];
    
    //设置头部图片
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(4, 4, CGRectGetWidth(self.view.frame) *0.21 - 8, CGRectGetWidth(self.view.frame) *0.21 - 8)];
//    self.headImage.backgroundColor = [UIColor redColor];
    self.headImage.layer.cornerRadius = (CGRectGetWidth(self.view.frame) *0.21 - 8)/2;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage1 addSubview:_headImage];
    //姓名
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImage1.frame) + 8, CGRectGetHeight(self.topView.frame)/2-10, 80, 20)];
    self.nameLable.font = [UIFont systemFontOfSize:13];
    _nameLable.text = _ArtistName;
    self.nameLable.textColor = [UIColor whiteColor];
    [self.topView addSubview:_nameLable];

   //性别标签
    self.sexImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLable.frame),CGRectGetHeight(self.topView.frame)/2-10, 20, 20)];
    self.sexImage.image = [UIImage imageNamed:@"xingbie"];
    [self.topView addSubview:_sexImage];
    //认证的button
    self.certifyButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sexImage.frame)+30, CGRectGetHeight(self.topView.frame)/2-10, 60, 20)];
    [self.certifyButton addTarget:self action:@selector(certifyUsersInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.certifyButton setBackgroundImage:[UIImage imageNamed:@"yb1"] forState:UIControlStateNormal];
    [self.topView addSubview:self.certifyButton];
    
    //分享
    self.shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.topView.frame)-50,20,30, 30)];
    self.shareImage.image = [UIImage imageNamed:@"yb1"];
//    self.shareImage.hidden = YES;
    [self.topView addSubview:_shareImage];
}
/**认证用户信息*/
- (void)certifyUsersInfo{
    
}
#pragma mark   点击换头像
-(void)onClickImage
{
    // 进入相册，选择图片头像
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    //
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ///]
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

// 代理方法
// 调用相机后的代理方法
// 拍摄完成后要执行的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
     self.currentImg = image;
    NSString *Token = [[getDataHand shareHandLineData]stringPutPicture];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }params:nil checkCrc:NO cancellationSignal:nil];
    
    NSString *string = [Factory randomlyString];
    NSString *timeString = [Factory TimeToDataString];
    NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 头像图片上传
        [upManager putFile:[self getImagePath:image] key:@"avatar" token:Token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if ([resp objectForKey:@"state"]) {
                NSString *url = [NSString stringWithFormat:@"%@%@",QI_NIU,[resp objectForKey:@"url"]];
                NSString *avatar = [NSString stringWithFormat:@"%@=%@",key,url];
                NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Key:avatar];
                if ([[dic objectForKey:@"message"] isEqualToString:@"保存成功"]) {
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"头像修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alView show];
                }
            }
        } option:uploadOption];
        
    });
    _headImage.image = image;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"name.png"];   // 保存文件的名称
    
    [UIImagePNGRepresentation(image)writeToFile: filePath atomically:YES];
    // 模态消失
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
   
}

/**照片获取本地路径转换*/
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 0.01);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return 9;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0)
    {
        
        ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"namecell" forIndexPath:indexPath];
        //cell.userInteractionEnabled = NO;
        KCellStyle;
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
        cell.titLable.text = @"昵称";
        // 设置艺名
        if (self.ArtistName == nil) {
            cell.showLab.text = @"";
        }
        else
        {
            cell.showLab.text = self.ArtistName;
        }
        cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
        KCellStyle;
        
        return cell;
    }
    if (indexPath.row == 1)
    {
        ArtSexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sexcell" forIndexPath:indexPath];
        //cell.userInteractionEnabled = NO;
        KCellStyle;
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
        cell.titLable.text = @"性别";
        cell.remindLab.text = @"(性别一经提交不允许修改)";
        cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
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
        ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"namecell" forIndexPath:indexPath];
        //cell.userInteractionEnabled = NO;
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
    if (indexPath.row == 3)
    {
        ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"namecell" forIndexPath:indexPath];
        cell.userInteractionEnabled = NO;
        KCellStyle;
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
        cell.titLable.text = @"影红号";

        // 设置影红号
        if (self.ArtistZhiye == nil) {
            cell.showLab.text = @"";
        }
        else
        {
            cell.showLab.text = self.ArtistZhiye;
        }
        
        return cell;
    }
    if (indexPath.row == 4)
    {
        ArtApplyPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phonecell" forIndexPath:indexPath];
        KCellStyle;
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
        cell.titLable.text = @"微信号";
        cell.chooseLab.text = @"不公开";
        [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
        [cell.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = 101;
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
    if (indexPath.row == 5)
    {
        ArtApplyPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phonecell" forIndexPath:indexPath];
        KCellStyle;
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
        cell.titLable.text = @"手机号";
        cell.chooseLab.text = @"不公开";
        [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"checked2.png"] forState:UIControlStateNormal];
        [cell.chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.chooseBtn.tag = 101;
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
    if (indexPath.row == 6)
    {
        ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"namecell" forIndexPath:indexPath];
        //cell.userInteractionEnabled = NO;
        KCellStyle;
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
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
    if (indexPath.row == 7)
    {
        ArtApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"namecell" forIndexPath:indexPath];
        //cell.userInteractionEnabled = NO;
        KCellStyle;
        cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        cell.starImage.image = [UIImage imageNamed:@"xinghao.png"];
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
    if (indexPath.row == 8)
    {
        _cell = [tableView dequeueReusableCellWithIdentifier:@"personcell" forIndexPath:indexPath];
        //cell.userInteractionEnabled = NO;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
        _cell.specificLab.text = @"个性签名";
        
        if (_ArtistSignature == nil) {
            _cell.specificText.text = @"我就是我，不一样的烟火";
        }
        else
        {
            _cell.specificText.text = _ArtistSignature;
        }
        _cell.specificText.backgroundColor = [UIColor colorWithRed:141/255.0f green:156/255.0f  blue:160/255.0f  alpha:0.5];
        
        return _cell;
    }

    return 0;
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
    
//    if (sender.isTel && [sender.currentBackgroundImage isEqual:[UIImage imageNamed:@"checked2.png"]]) {
//        self.isTelSelected = @"1";
//    }
//    
//    if (sender.isWeixin && [sender.currentBackgroundImage isEqual:[UIImage imageNamed:@"checked2.png"]]) {
//        self.isWeixinSelected = @"1";
//    }
    
    
}
//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 8)
    {
        return 80;
    }
    return 40;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    else if (indexPath.row == 3)
    {
        // 职业
        ZhiyeViewController *zhiyeVC = [[ZhiyeViewController alloc] init];
        zhiyeVC.mBlock = ^(NSString *str)
        {
            self.ArtistZhiye = str;
            [self.tableView reloadData];
        };
        zhiyeVC.strZhiye = self.ArtistZhiye;
        [self.navigationController pushViewController:zhiyeVC animated:YES];
    }
    else if (indexPath.row == 4)
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
    else if (indexPath.row == 5)
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
    else if (indexPath.row == 6)
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
    else if (indexPath.row == 7)
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
        // 个性签名
    }
}


#pragma mark -------------代理传值----------------

/// 代理方法
-(void)passName:(NSString *)aName
{
    self.ArtistName = aName;
    self.nameLable.text = aName;
    [self.tableView reloadData];
}

-(void)passSex:(NSString *)sex
{
    self.ArtistSex = sex;
    [self.tableView reloadData];
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
