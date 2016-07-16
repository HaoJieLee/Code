				//
//  MineCenterViewController.m
//  乐影
//
//  Created by zhaoHm on 16/4/27.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MineCenterViewController.h"
#import "ArtistsIntroView.h"
#import "ShowsModelCollectionViewController.h"
#import "ArtistsPresentTableViewController.h"
#import "getAboutArtistData.h"
#import "detailModel.h"
#import "getAboutArtistData.h"
#import "WXApi.h"

#import "PicUploadNewCollectionViewController.h"
#import "movieTableViewController.h"
#import "strangerTableViewController.h"
#import "ActiveApplysTableViewController.h"
#import "ArtApplyTableViewController.h"
#import "ArtPersonTableViewCell.h"
#import "UsersTableViewController.h"
#import <AFNetworking.h>

#import "QiniuSDK.h"
#import "getDataHand.h"

#import "CertityViewController.h"

@interface MineCenterViewController ()<LGtitleBarViewDelegate,UIScrollViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)ArtistsIntroView *artVC;


@property(nonatomic,strong)UIScrollView *BackView;
@property (nonatomic,strong)PicUploadNewCollectionViewController *picVC;
@property (nonatomic,strong)movieTableViewController *movieVC;//摄影
@property (nonatomic,strong)ActiveApplysTableViewController *activityVC;//企业
@property (nonatomic,strong)ArtApplyTableViewController *artApplyVC;//艺人
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) LGtitleBarView *titleBar;

@property (nonatomic,strong)NSMutableArray  *hTypeArr;//艺人标签数组
@property (nonatomic,strong)NSArray  *hXingArr;


@property (nonatomic,strong)NSArray  *sTypeArr;
@property (nonatomic,strong)NSArray  *sXingArr;

@property (nonatomic,assign) CGFloat newHeight;

@end

@implementation MineCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"个人信息";
    self.hTypeArr = [NSMutableArray array];
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        self.artVC = [[ArtistsIntroView alloc]initWithFrame:[UIScreen mainScreen].bounds AddDictionary:nil];
        self.view = _artVC;
        self.artVC.backScrollView.delegate = self;
        self.view.backgroundColor = [UIColor colorWithRed:182/255.0f green:181/255.0f  blue:175/255.0f alpha:1.0];
        self.titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.artVC.topView.frame)-2, self.view.frame.size.width, 42)];
        //self.titleBar.backgroundColor = [UIColor blackColor];
        self.titles = @[@"影秀",  @"资料"];
        
        self.titleBar.titles = _titles;
        self.titleBar.delegate = self;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
        [self.artVC.backScrollView addSubview:_titleBar];
        
        
        [self interfaceHandle];
   
        // 请求数据
        [self getDataForIndex];
        
        //重写左bar
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction1)];
        
        self.artVC.collectImage.hidden = YES;
        self.artVC.addressLabel.hidden = YES;
        self.artVC.numberShowLab.hidden = YES;
        self.artVC.numberLab.hidden = YES;
        self.artVC.introduceLable.hidden = YES;
        
        if (self.myImage)
        {
            self.artVC.headImage.image = _myImage;
        }
        else
        {
            self.artVC.headImage.image = [UIImage imageNamed:@"logot.png"];
            
        }
        
        self.artVC.headImage1.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap5 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction)];
        [self.artVC.headImage1 addGestureRecognizer:singleTap5];
    }
    self.artVC.certifyImage.userInteractionEnabled= YES;
    
UITapGestureRecognizer *singleTap6 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(indentityCertify)];
    [self.artVC.certifyImage addGestureRecognizer:singleTap6];
    
}
//认证资料
- (void)indentityCertify{
    CertityViewController *certity = [[CertityViewController alloc]init];
    certity.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:certity animated:YES];
}
//选择上传头像图片
-(void)singleTapAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
     self.artVC.headImage1.image = image;
    
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

#pragma mark 数据请求
-(void)getDataForIndex
{
    // 网络判断
    // 没有网
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    // 有网
    else
    {
        NSString *string = [Factory randomlyString];
        NSString *timeString = [Factory TimeToDataString];
        NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
        NSDictionary *dict =[[getDataHand shareHandLineData] RefreshUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString  Nonce:string];
        if (_myindsx == 1) {
            // 艺人
            if (dict != nil)
            {
                // 显示自己的头像
                [self.artApplyVC.myImage sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"logo.png"]];
                self.artApplyVC.ArtistName = [dict objectForKey:@"nicename"];
                self.artVC.nameLable.text = [dict objectForKey:@"nicename"];
                // 非零即为真  真为女  假为男   3.31 start   1 男   2  女
                if ([[dict objectForKey:@"gender"] isEqualToString:@"1"]) {
                    self.artApplyVC.ArtistSex = @"男";
                    self.artVC.sexImage.image = [UIImage imageNamed:@"boy.png"];
                }
                else
                {
                    self.artApplyVC.ArtistSex = @"女";
                    self.artVC.sexImage.image = [UIImage imageNamed:@"girl.png"];
                }
                self.artApplyVC.ArtistLocal = [NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]];
                self.artApplyVC.heightNew = [dict objectForKey:@"height"];
                self.artApplyVC.weightNew = [dict objectForKey:@"weight"];
                self.artApplyVC.chimaNew = [dict objectForKey:@"shoeSize"];
                
                if ([ [dict objectForKey:@"bwh"] rangeOfString:@"|"].location != NSNotFound) {
                    NSArray *sanweiArr = [[dict objectForKey:@"bwh"]componentsSeparatedByString:@"|"];
                    self.artApplyVC.sanweiNew1 = sanweiArr[0];
                    self.artApplyVC.sanweiNew2 = sanweiArr[1];
                    self.artApplyVC.sanweiNew3 = sanweiArr[2];
  
                }else
                {
                    NSArray *sanweiArr = [[dict objectForKey:@"bwh"]componentsSeparatedByString:@"/"];
                    self.artApplyVC.sanweiNew1 = sanweiArr[0];
                    self.artApplyVC.sanweiNew2 = sanweiArr[1];
                    self.artApplyVC.sanweiNew3 = sanweiArr[2];
                }

                self.artApplyVC.ArtistWeixinNumber =[dict objectForKey:@"wechat"];
                self.artApplyVC.isWeixinSelected = [dict objectForKey:@"isWechatOpen"];
                
                self.artApplyVC.ArtistTelNumber = [dict objectForKey:@"phone"] ;
                self.artApplyVC.isTelSelected = [dict objectForKey:@"isPhoneOpen"];
                
                self.artApplyVC.ArtistEmailNumber = [dict objectForKey:@"email"];
                self.artApplyVC.ArtistQQNumber = [dict objectForKey:@"qq"];
                // 类型
                self.artApplyVC.ArtistType = [dict objectForKey:@"category"];
                self.artApplyVC.ArtistTypeId = [dict objectForKey:@"subCategory"];
                
                self.artApplyVC.ArtistBiaoqian = [dict objectForKey:@"tag"];
                self.artApplyVC.ArtistBiaoqianId = nil;
                self.artVC.markLab.text = _artApplyVC.ArtistBiaoqian;
                // 个性签名设置
                self.artApplyVC.ArtistSignature = [dict objectForKey:@"motto"] ;
                self.artVC.introduceLable.text = _artApplyVC.ArtistSignature;
                //人生经历
                self.artApplyVC.ArtistLifeExperience =[dict objectForKey:@"description"];
            }
            else
            {
                // 没有数据
            }
        }
        
        //摄影
        else if (_myindsx == 2)
        {
            if(dict != nil)
            {
                //tag值
                self.artVC.markLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"tag"]];
                //艺名(昵称)
                self.movieVC.ArtistName = [dict objectForKey:@"nicename"];
                self.artVC.nameLable.text = _movieVC.ArtistName;
                //男女性别判断非零为真 真为女 假为男
                if([[dict objectForKey:@"gender"] isEqualToString:@"1"]){
                    self.movieVC.ArtistSex = @"男";
                    self.artVC.sexImage.image = [UIImage imageNamed:@"boy.png"];
                }else{
                    self.movieVC.ArtistSex = @"女";
                    self.artVC.sexImage.image = [UIImage imageNamed:@"girl.png"];
                }
                //地区
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]] isEqualToString:@"<null>"]){
                    self.movieVC.ArtistLocal = [NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]];
                    
                }else{
                    self.movieVC.ArtistLocal = @"";
                }
                
                //等级
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"level"]]isEqualToString:@"<null>"]){
                    self.movieVC.ArtistGongling = [NSString stringWithFormat:@"%@",[dict objectForKey:@"level"]];
                    
                }else{
                    self.movieVC.ArtistGongling = @"";
                }
                
                //性质
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"category"]]isEqualToString:@"<null>"]){
                    self.movieVC.ArtistXingzhi = [NSString stringWithFormat:@"%@",[dict objectForKey:@"category"]];
                }else{
                    self.movieVC.ArtistXingzhi = @"";
                }
                
                //类型
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"category"]]isEqualToString:@"<unll>"]){
                    self.movieVC.ArtistLeixing = [NSString stringWithFormat:@"%@",[dict objectForKey:@"category"]];
                }else{
                    self.movieVC.ArtistLeixing = @"";
                }
                
                //器材
                if (![[NSString stringWithFormat:@"%@", [dict objectForKey:@"device"]]isEqualToString:@"<unll>"]){
                    self.movieVC.ArtistQicai = [NSString stringWithFormat:@"%@",[dict objectForKey:@"device"]];
                }else{
                    self.movieVC.ArtistQicai = @"";
                }
                
                //微信
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"wechat"]]isEqualToString:@"<unll>"]){
                    self.movieVC.ArtistWeixinNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"wechat"]];
                }else{
                    self.movieVC.ArtistWeixinNumber = @"";
                }
                
                //电话
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"phone"]]isEqualToString:@"<null>"]){
                    self.movieVC.ArtistEmailNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"phone"]];
                }else{
                    self.movieVC.ArtistEmailNumber = @"";
                }
                
                self.movieVC.isWeixinSelected = [dict objectForKey:@"isWechatOpen"];
                self.movieVC.isTelSelected = [dict objectForKey:@"isPhoneOpen"];
                
                //邮箱
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]] isEqualToString:@"<null>"]){
                    self.movieVC.ArtistEmailNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]];
                }else{
                    self.movieVC.ArtistEmailNumber = @"";
                }
                
                //QQ
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"qq"]]isEqualToString:@"<null>"]){
                    self.movieVC.ArtistQQNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qq"]];
                }else{
                    self.movieVC.ArtistQQNumber = @"";
                }
                
                //个人签名
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"motto"]]isEqualToString:@"<null>"]){
                    self.movieVC.ArtistSignature = [NSString stringWithFormat:@"%@",[dict objectForKey:@"motto"]];
                }else{
                    self.movieVC.ArtistSignature = @"";
                }
                
                self.artVC.introduceLable.text = _movieVC.ArtistSignature;
                
                //人生经历设置
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@""]]isEqualToString:@"<null>"]){
                    self.movieVC.ArtistLifeExperience = [NSString stringWithFormat:@"%@",[dict objectForKey:@"description"]];
                }else{
                    self.movieVC.ArtistLifeExperience = @"description";
                }
            }else{
                
                //没有数据
                
            }
        }else{
            
            //企业
            //有数据
            //名称
            if (dict != nil) {
                // 非零即为真  真为女  假为男   3.31 start   1 男   2  女
                if ([[dict objectForKey:@"gender"] isEqualToString:@"1"]) {
                    self.artApplyVC.ArtistSex = @"男";
                    self.artVC.sexImage.image = [UIImage imageNamed:@"boy.png"];
                }
                else
                {
                    self.artApplyVC.ArtistSex = @"女";
                    self.artVC.sexImage.image = [UIImage imageNamed:@"girl.png"];
                }
                self.artVC.numberShowLab.text = [NSString stringWithFormat:@"%@%@",@"ly",[dict  objectForKey:@"memberid"]];
                self.artVC.markLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]];
                
                self.activityVC.ArtistName = [dict objectForKey:@"nicename"];
                self.artVC.nameLable.text = _activityVC.ArtistName;

                // 地区
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]] isEqualToString:@"<null>"]) {
                    self.activityVC.ArtistLocal = [NSString stringWithFormat:@"%@",[dict objectForKey:@"location"]];
                }
                else
                {
                    self.activityVC.ArtistLocal = @"";
                }
                //性别
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"gender"]]isEqualToString:@"<null>"]){
                    self.activityVC.gender = [NSString stringWithFormat:@"%@",[dict objectForKey:@"gender"]];
                }else{
                    self.activityVC.gender = @"";
                }
                
                //类型
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"category"]]isEqualToString:@"<null>"]){
                    self.activityVC.ArtistXingzhi = [NSString stringWithFormat:@"%@",[dict objectForKey:@"category"]];
                }else{
                    self.activityVC.ArtistXingzhi = @"";
                    
                }
                
                //微信
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"wechat"]]isEqualToString:@"<null>"]) {
                    self.activityVC.ArtistWeixinNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"wechat"]];
                }else{
                    self.activityVC.ArtistWeixinNumber = @"";
                }
                
                //电话
                if (![[NSString stringWithFormat: @"%@",[dict objectForKey:@"phone"]]isEqualToString:@"<null>"]) {
                    self.activityVC.ArtistTelNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"phone"]];
                }else{
                    self.activityVC.ArtistTelNumber = @"";
                }
                
                //邮箱
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]]isEqualToString:@"null"]) {
                    self.activityVC.ArtistEmailNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]];
                }else{
                    self.activityVC.ArtistEmailNumber = @"";
                }
                
                //QQ
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"qq"]]isEqualToString:@"<null>"]){
                    self.activityVC.ArtistQQNumber = [NSString stringWithFormat:@"%@",[dict objectForKey:@"qq"]];
                }else{
                    self.activityVC.ArtistQQNumber = @"";
                }
                //个性签名
                if (![[NSString stringWithFormat:@"%@",[dict objectForKey:@"motto"]]isEqualToString:@"<null>"]) {
                    self.activityVC.ArtistSignature = [NSString stringWithFormat:@"%@",[dict objectForKey:@"motto"]];
                }else{
                    self.activityVC.ArtistSignature = @"";
                }
                self.artVC.introduceLable.text = _activityVC.ArtistSignature;
            }else{
                //没有数据
            }
        }
    }
}


#pragma mark 保存数据
-(void)rightAction1
{
    
    NSLog(@"提交数据");
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if (self.myindsx == 1) {
            // 艺人
            NSString *string = [Factory randomlyString];
            NSString *timeString = [Factory TimeToDataString];
            NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *BWHstring = [NSString stringWithFormat:@"%@|%@|%@",self.artApplyVC.sanweiNew1,self.artApplyVC.sanweiNew2,self.artApplyVC.sanweiNew3];
                if ([self.artApplyVC.ArtistSex isEqualToString:@"男"]) {
                    self.artApplyVC.ArtistSex = @"1";
                }else{
                    self.artApplyVC.ArtistSex = @"2";
                }
                 NSString *argument = [NSString stringWithFormat:@"nicename=%@&username=%@&gender=%@&location=%@&height=%@&weight=%@&shoeSize=%@&qq=%@&email=%@&phone=%@&wechat=%@&bwh=%@&isWechatOpen=%@&isPhoneOpen=%@&tag=%@&tag=%@&motto=%@",self.artApplyVC.ArtistName,
                                       self.artVC.nameLable.text,
                                       self.artApplyVC.ArtistSex,
                                       self.artApplyVC.ArtistLocal,
                                       self.artApplyVC.heightNew,
                                       self.artApplyVC.weightNew,
                                       self.artApplyVC.chimaNew,
                                       self.artApplyVC.ArtistQQNumber,
                                       self.artApplyVC.ArtistEmailNumber,
                                       self.artApplyVC.ArtistTelNumber,
                                       self.artApplyVC.ArtistWeixinNumber,
                                       BWHstring,
                                       self.artApplyVC.isWeixinSelected,
                                       self.artApplyVC.isTelSelected,
                                       self.artApplyVC.ArtistBiaoqian,
                                       self.artVC.markLab.text,
                                       self.artVC.introduceLable.text];
                //人生经历description
                NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Key:argument];
                NSLog(@"%@",[dic objectForKey:@"message"]);
            });
        }
        else if (self.myindsx == 2)
        {
            // 影视
            NSString *string = [Factory randomlyString];
            NSString *timeString = [Factory TimeToDataString];
            NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if ([self.artApplyVC.ArtistSex isEqualToString:@"男"]) {
                    self.artApplyVC.ArtistSex = @"1";
                }else{
                    self.artApplyVC.ArtistSex = @"2";
                }
            NSString *argument = [NSString stringWithFormat:@"nicename=%@&gender=%@&location=%@&tag=%@&level=%d&category=%@&device=%@&qq=%@&email=%@&phone=%@&wechat=%@&isWechatOpen=%@&isPhoneOpen=%@&motto=%@&description=%@",
                                  self.movieVC.ArtistName,
                                  self.movieVC.ArtistSex,
                                  self.movieVC.ArtistLocal,
                                  self.movieVC.ArtistXingzhi,
                                  [self.movieVC.ArtistGongling intValue],
                                  self.movieVC.ArtistLeixing,
                                  self.movieVC.ArtistQicai,
                                  self.movieVC.ArtistQQNumber,
                                  self.movieVC.ArtistEmailNumber,
                                  self.movieVC.ArtistTelNumber,
                                  self.movieVC.ArtistWeixinNumber,
                                  self.movieVC.isWeixinSelected,
                                  self.movieVC.isTelSelected,
                                  self.movieVC.artPersonTableviewCell.specificText.text,
                                  self.movieVC.artPersonTableviewCell.lifeText.text];
                //人生经历description
                NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Key:argument];
                NSLog(@"%@",[dic objectForKey:@"message"]);
            });
        }
        else
        {
            // 活动方
            NSString *string = [Factory randomlyString];
            NSString *timeString = [Factory TimeToDataString];
            NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if ([self.artApplyVC.ArtistSex isEqualToString:@"男"]) {
                    self.artApplyVC.ArtistSex = @"1";
                }else{
                    self.artApplyVC.ArtistSex = @"2";
                }
                
                NSString *argument = [NSString stringWithFormat:@"nicename=%@&location=%@&geder=%@&category=%@&qq=%@&email=%@&phone=%@&wechat=%@&isWechatOpen=%@&isPhoneOpen=%@&motto=%@",
                                      self.activityVC.ArtistName,
                                      self.activityVC.ArtistLocal,
                                      self.activityVC.gender,
                                      self.activityVC.ArtistXingzhi,
                                      self.activityVC.ArtistQQNumber,
                                      self.activityVC.ArtistEmailNumber,
                                      self.activityVC.ArtistTelNumber,
                                      self.activityVC.ArtistWeixinNumber,
                                      self.activityVC.isWeixinSelected,
                                      self.activityVC.isTelSelected,
                                      self.activityVC.artPersonTableviewCell.specificText.text];
                //人生经历description
                NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Key:argument];
                NSLog(@"%@",[dic objectForKey:@"message"]);
            });
        }
        
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)leftBarButtonItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 视图设置
// 视图设置
-(void)interfaceHandle
{
    self.BackView = [[UIScrollView alloc]init];
//    self.BackView.backgroundColor = [UIColor colorWithRed:182/255.0f green:181/255.0f  blue:175/255.0f alpha:1.0];
    self.BackView.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f blue:222/255.0f alpha:1.0];
//-----------------------------
    // 左右滑动的scrollview
    self.BackView.frame = CGRectMake(0, CGRectGetMaxY(self.titleBar.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 100000);
//-----------------------------
    self.BackView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)*2, CGRectGetHeight([UIScreen mainScreen].bounds));
    //self.BackView.backgroundColor = [UIColor blueColor];
    self.BackView.delegate = self;
    [self.artVC.backScrollView addSubview:_BackView];
    self.BackView.pagingEnabled = YES;
    
    
    // 艺人
    if (self.myindsx == 1)
    {
        self.artApplyVC = [[ArtApplyTableViewController alloc]init];
        self.artApplyVC.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height-155 + 500 + 10000);
        [self addChildViewController:_artApplyVC];
        [self.BackView addSubview:_artApplyVC.tableView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - 10, 158);
        flowLayout.minimumInteritemSpacing = 3;
        // 上下间距
        flowLayout.minimumLineSpacing = 6;
        flowLayout.headerReferenceSize = CGSizeMake(0, 330);
        // 设置整体四周边距  上、左、下、右
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 15, 5);
        self.picVC = [[PicUploadNewCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        self.picVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 108  + 500 + 100000);
        [self addChildViewController:_picVC];
        [self.BackView addSubview:_picVC.collectionView];
    }
    // 影视机构
    else if (self.myindsx == 2)
    {
        self.movieVC = [[movieTableViewController alloc]init];
        self.movieVC.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height-155 + 500 + 10000);
        
        _movieVC.myXingzhi = self.sXingArr;
        [self addChildViewController:_movieVC];
        [self.BackView addSubview:_movieVC.tableView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - 10, 158);
        flowLayout.minimumInteritemSpacing = 3;
        // 上下间距
        flowLayout.minimumLineSpacing = 6;
        flowLayout.headerReferenceSize = CGSizeMake(0,300);
        // 设置整体四周边距  上、左、下、右
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 15, 5);
        self.picVC = [[PicUploadNewCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        self.picVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 108+ 500 + 100000);
        [self addChildViewController:_picVC];
        [self.BackView addSubview:_picVC.collectionView];
    }
    // 企业
    else if (self.myindsx == 3)
    {
        self.activityVC = [[ActiveApplysTableViewController alloc]init];
        self.activityVC.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, self.view.frame.size.width, self.view.frame.size.height-155 + 500 + 10000);
        _activityVC.HdType = self.hTypeArr;
        _activityVC.HdXingzhi = self.hXingArr;
        [self addChildViewController:_activityVC];
        [self.BackView addSubview:_activityVC.tableView];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - 10, 158);
        flowLayout.minimumInteritemSpacing = 3;
        // 上下间距
        flowLayout.minimumLineSpacing = 6;
        flowLayout.headerReferenceSize = CGSizeMake(0, 300);
        // 设置整体四周边距  上、左、下、右
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 15, 5);
        self.picVC = [[PicUploadNewCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        self.picVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 108 + 500 + 100000);
        [self addChildViewController:_picVC];
        [self.BackView addSubview:_picVC.collectionView];
    }

    self.picVC.collectionView.contentSize = CGSizeMake(KScreenW, KScreenH);
    _newHeight = KScreenH + _picVC.collectionViewSizeNew.height;
    self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, _newHeight);
   
}

#pragma mark 滑动问题解决
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 2701) {
        // scrollview
        CGFloat contentSet = self.BackView.contentOffset.x / KScreenW;
        if (contentSet == 0) {
            // collectionview
            self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, _newHeight);
        }
        else
        {
            // tableview
//            self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, CGRectGetMaxY(self.titleBar.frame) + _movieVC.tableView.contentSize.height + 120);
            if (self.myindsx == 1) {
                // 艺人
                self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, CGRectGetMaxY(self.titleBar.frame) + _artApplyVC.tableView.contentSize.height - 220 + 274);
            }
            else if (self.myindsx == 2)
            {
                // 影视机构
                self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, CGRectGetMaxY(self.titleBar.frame) + _movieVC.tableView.contentSize.height - 220);
            }
            else
            {
                // 企业
                self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, CGRectGetMaxY(self.titleBar.frame) + _activityVC.tableView.contentSize.height - 220);
            }
        }
    }
    else
    {
        
        
    }
    
}

-(void)LGtitleBarView:(LGtitleBarView *)titleBarView didSelectedItem:(int)index
{
    CGFloat x = index * self.BackView.bounds.size.width;
    [self.BackView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger integer = self.BackView.contentOffset.x/CGRectGetWidth(self.view.frame);
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:integer inSection:0];
    
    LGcollectionCell * cell =(LGcollectionCell *) [self.titleBar.collection cellForItemAtIndexPath:indexPath];
    
    [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition: UICollectionViewScrollPositionCenteredHorizontally];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.titleBar.bottomView.frame = CGRectMake(cell.frame.origin.x, cell.frame.size.height-2, cell.frame.size.width - 4, 2);
        
        
    }];
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
