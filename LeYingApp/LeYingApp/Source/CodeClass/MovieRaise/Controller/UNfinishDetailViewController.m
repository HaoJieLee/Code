//
//  UNfinishDetailViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/11.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "UNfinishDetailViewController.h"
#import "UnfinishDetailView.h"
#import "CrewCollectionViewController.h"
#import "expandModel.h"
#import "getProjectData.h"
#import "projectList.h"
#import "getAboutArtistData.h"
#import "WXApi.h"
#import "DictToData.h"
#import "GroupPhotoViewController.h"
#import "VideoViewController.h"
#import "BuyTableViewCell.h"
#import "buyModel.h"
#import "VideoWebViewController.h"
#import "JWVideoPlayer.h"
#import "WaresDetailViewController.h"

#import "PictureModel.h"


@interface UNfinishDetailViewController ()<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UnfinishDetailView *myView;
@property (nonatomic, strong) UIScrollView *scrollView;//底层scrollView
@property (nonatomic, strong) UILabel *textLabel;//介绍label

@property(nonatomic,strong)UIScrollView *BackView;//承装图片的scrollView；

//解决高度问题
@property (nonatomic,strong) CrewCollectionViewController *crewVC;
@property (nonatomic,assign) CGSize newASize;
@property (nonatomic,assign) BOOL isShowDetailsContents;


//
@property (nonatomic,strong)NSArray *expandArr;
@property (nonatomic,strong)NSMutableArray *detailArr;//详情
@property (nonatomic,strong)NSDictionary *myDic;
@property (nonatomic,strong)NSMutableArray *myPic;//剧组照片
@property (nonatomic,strong)NSMutableArray *myBuy;
@property (nonatomic,strong)NSMutableArray *myBigPicArr;//图片数组
@property (nonatomic,strong)NSString *seLog;

@property (nonatomic,strong)UIButton *btnShowDetail;//展开按钮
/// 详情
@property (nonatomic,assign) CGRect oldDetailsRect;
/// 底部view的frame
@property (nonatomic,assign) CGRect oldbottomViewRect;
/// contentsize大小
@property (nonatomic,assign) CGSize oldContentSize;
/// 展开按钮
@property (nonatomic,assign) CGRect oldBtnDetailsRect;

@property (nonatomic,strong)UIView *infoView;//活动基本信息的View
@property (nonatomic,strong)UIImageView *showImage2;//活动首图

@property (nonatomic,strong)UILabel *titLab;//标题label
@property (nonatomic,strong)UILabel *introLab;//描述的label
@property (nonatomic,strong)UILabel *endTimeLab;//@“截止时间”
@property (nonatomic,strong)UILabel *endTimeShowLab;//截止时间具体时间
@property (nonatomic,strong)UIView *VideoView;//视频的View
@property (nonatomic,strong)UIScrollView *VideoScrollView;//盛放视频的scrollView
@property (nonatomic,strong)UILabel *descripLabel;//@"简介"
@property (nonatomic,strong)UIView *ImageBackView;//图片底部视图
@property (nonatomic,strong)UILabel *imageLabel;//剧照
@property (nonatomic,strong)UILabel *VideoLabel;//@“视频label”

@property (nonatomic,strong)UITableView *tableView;//购买的tableView;

@property (nonatomic,strong)NSMutableArray *buyDataSource;//购买的数组
@property (nonatomic,strong)UIButton *VideoButton;//点击播放视频
@end

@implementation UNfinishDetailViewController

#pragma mark tabbar消失出现时间
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
  
}
- (void)setArrayData{
    // 数组初始化
    self.navigationItem.title = @"详情";
    self.isShowDetailsContents = NO;
    self.detailArr = [NSMutableArray array];
    self.myBigPicArr = [NSMutableArray array];
    self.expandArr = [NSArray array];
    self.buyDataSource = [NSMutableArray array];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setArrayData];
    
    [self setBaseView];

    self.view.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f  blue:222/255.0f alpha:1.0];
    
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 子线程中加载数据
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            // 耗时的操作
//            //点击量数据处理
////            [[getProjectData shareProjectData] addClickwithID:self.index];
//        });
//        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //项目详情数据
            [[getProjectData shareProjectData]getDataListWithId:self.index passValue:^(NSDictionary *detailDic) {
                projectList *project = [[projectList alloc]init];
                [project setValuesForKeysWithDictionary:detailDic];
                for (NSDictionary *dic in project.buy) {
                    buyModel *buy = [[buyModel alloc]init];
                    [buy setValuesForKeysWithDictionary:dic];
                    [self.buyDataSource addObject:buy];
                }
                
                [self.detailArr addObject:project];
                for (NSDictionary *dic in project.photos) {
                    PictureModel *picture = [[PictureModel alloc]init];
                    [picture setValuesForKeysWithDictionary:dic];
                    [self.myBigPicArr addObject:picture];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 解析数据
                [self setData];//项目详情处理
                [self.tableView reloadData];
//                [self interfaceHandle];
            });
        });

    }
    
    
    
   
}
- (UIView*)ImageBackView{
    if (_ImageBackView == nil) {
        _ImageBackView = [[UIView alloc]init];
        _ImageBackView.frame = CGRectMake(0, CGRectGetMaxY(self.btnShowDetail.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 180);
        [_ImageBackView addSubview:self.BackView];
        [_ImageBackView addSubview:self.imageLabel];
        [_ImageBackView addSubview:self.VideoLabel];
        _ImageBackView.backgroundColor = [UIColor clearColor];
    }
    return _ImageBackView;
}
- (UILabel *)VideoLabel{
    if (_VideoLabel==nil) {
        _VideoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, 50, 30)];
        _VideoLabel.text = @"视频";
        _VideoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _VideoLabel;
}
- (UILabel*)imageLabel{
    if (_imageLabel == nil) {
        _imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
        _imageLabel.textAlignment = NSTextAlignmentLeft;
        _imageLabel.text = @"剧照";
    }
    return _imageLabel;
}
-(UILabel *)descripLabel{
    if (_descripLabel == nil) {
        _descripLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.infoView.frame), 100, 40)];
        _descripLabel.textColor = [UIColor blackColor];
        _descripLabel.textAlignment = NSTextAlignmentLeft;
        _descripLabel.text = @"简介";
    }
    return _descripLabel;
}
- (UIButton *)VideoButton{
    if (_VideoButton==nil) {
        //加载视频
        _VideoButton = [Factory initWithFrame:CGRectMake(0, 0, 180, 180) BackColor:[UIColor clearColor] Title:@"" TintColor:[UIColor blackColor] Tag:0 ButtonType:UIButtonTypeCustom];
        
        [_VideoButton addTarget:self action:@selector(intoVideoView) forControlEvents:UIControlEventTouchUpInside];

        }
    return _VideoButton;
}
-(UIScrollView*)VideoScrollView{
    if (_VideoScrollView == nil) {

        _VideoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ImageBackView.frame), CGRectGetWidth(self.view.frame), 200)];
        [_VideoScrollView addSubview:self.VideoButton];
        _VideoScrollView.backgroundColor = [UIColor whiteColor];
        _VideoScrollView.userInteractionEnabled = YES;
    }
    return _VideoScrollView;
}
- (UIScrollView*)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_scrollView addSubview:self.infoView];
        [_scrollView addSubview:self.descripLabel];
        [_scrollView addSubview:self.textLabel];
        [_scrollView addSubview:self.btnShowDetail];
        [_scrollView addSubview:self.ImageBackView];
        [_scrollView addSubview:self.VideoScrollView];
        [_scrollView addSubview:self.tableView];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(self.tableView.frame)) ;
    }
    return _scrollView;
}
- (UITableView*)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.VideoScrollView.frame)+10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellAccessoryNone;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BuyTableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableView;
}
- (UILabel*)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 320, CGRectGetWidth(self.view.frame)-10, 100)];
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}
- (UIButton*)btnShowDetail{
    if (_btnShowDetail==nil) {
        _btnShowDetail = [Factory initWithFrame:CGRectMake(CGRectGetMaxX(self.textLabel.frame)/2-30, CGRectGetMaxY(self.textLabel.frame) + 2, 60, 18) BackColor:nil Title:nil TintColor:nil Tag:0 ButtonType:UIButtonTypeCustom];
        [_btnShowDetail setBackgroundImage:[UIImage imageNamed:@"zhankai4.png"] forState:UIControlStateNormal];
        [self.btnShowDetail addTarget:self action:@selector(btnShowDetailAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnShowDetail;
}
- (void)setBaseView{
    [self.view addSubview:self.scrollView];

    // 重写左侧返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
-(UIImageView *)showImage2
{
    
    if (_showImage2 == nil)
    {
        self.showImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 170)];
    }
    return _showImage2;
}
- (UIView*)infoView{
    if (_infoView==nil) {
        
        _infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),270)];
        _infoView.backgroundColor = [UIColor whiteColor];
        [_infoView addSubview:self.showImage2];
        [_infoView addSubview:self.titLab];
        [_infoView addSubview:self.introLab];
        [_infoView addSubview:self.endTimeLab];
        [_infoView addSubview:self.endTimeShowLab];
    }
    return _infoView;
}
-(UILabel *)titLab
{
    if (_titLab == nil)
    {
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 170,CGRectGetWidth(self.view.frame) - 220, 30)];
        
        self.titLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        self.titLab.textColor = [UIColor blackColor];
    }
    return _titLab;
}
-(UILabel *)introLab
{
    if (_introLab == nil)
    {
        self.introLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 200, CGRectGetWidth(self.view.frame) - 10, 40)];
        self.introLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.introLab.numberOfLines = 2;
        self.introLab.font = [UIFont systemFontOfSize:12];
        self.introLab.textColor = [UIColor blackColor];
        //        [self.contentView addSubview:_introLab];
    }
    return _introLab;
}
-(UILabel *)endTimeShowLab
{
    if (_endTimeShowLab == nil)
    {
        self.endTimeShowLab = [[UILabel alloc]initWithFrame:CGRectMake(70, 240, 110, 30)];
        self.endTimeShowLab.textColor =  [UIColor blackColor];
        self.endTimeShowLab.font = [UIFont systemFontOfSize:12];
        
    }
    return _endTimeShowLab;
}

-(UILabel *)endTimeLab
{
    if (_endTimeLab == nil)
    {
        _endTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 240, 60, 30)];
        // self.endTimeLab.backgroundColor = [UIColor brownColor];
        _endTimeLab.font = [UIFont systemFontOfSize:13];
        _endTimeLab.textColor =  [UIColor colorWithRed:111/255.0f green:111/255.0f blue:111/255.0f alpha:1.0];
        _endTimeLab.text = @"截止时间:";
    }
    return _endTimeLab;
}

- (UIScrollView*)BackView{
    if (_BackView==nil) {
        
        _BackView = [[UIScrollView alloc]init];
        
        _BackView.frame = CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), 100);
        _BackView.backgroundColor = [UIColor whiteColor];
        _BackView.delegate =self;
        _BackView.pagingEnabled = YES;

    }
    return _BackView;
}
#pragma mark 重写左baritem的点击事件
-(void)leftBarButtonItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 数据处理
-(void)setData
{
    //基本信息加载
    projectList *projiect = self.detailArr[0];
    [self.showImage2 sd_setImageWithURL:[NSURL URLWithString:projiect.coverImgUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.titLab.text = projiect.title;
    self.introLab.text = projiect.Description;
    self.endTimeShowLab.text = [Factory stringWithDataString:projiect.limitDate];
    self.textLabel.text = projiect.Description;
    //剧组图片加载
    for (int i = 0; i < self.myBigPicArr.count; i++) {
        PictureModel *picture = self.myBigPicArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(90*i+10, 10, 80, 80)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:picture.pic] placeholderImage:[UIImage imageNamed:@""]];
        [self.BackView addSubview:imageView];
    }
    self.BackView.contentSize = CGSizeMake(90*self.myBigPicArr.count+10, 100);
       UIImageView *buttonBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 180, 180)];
    [buttonBackImage sd_setImageWithURL:[NSURL URLWithString:[projiect.video objectForKey:@"imgurl"]] placeholderImage:nil];
    [self.VideoButton addSubview:buttonBackImage];

   
        // 项目详情
//    NSDictionary *dic1 = [NSDictionary dictionary];
//    dic1 = [[self.myDic objectForKey:@"datas"] objectForKey:@"info"];
//    //self.arr = [NSMutableArray array];
//    projectList * model = [[projectList alloc] init];
//    [model setValuesForKeysWithDictionary:dic1];
//    [self.detailArr addObject:model];
//    
//    
//    
//    // 剧组照片
//    NSDictionary *dic2 = [NSDictionary dictionary];
//    dic2 = [[self.myDic objectForKey:@"datas"] objectForKey:@"grouppicinfo"];
//    self.myPic = [NSMutableArray array];
//    NSArray *arr = [NSArray array];
//    arr = [dic2 objectForKey:@"piclist"];
//    NSLog(@"%@",arr);
//    if ([[NSString stringWithFormat:@"%@",arr] isEqualToString:@"0"])
//    {
//        
//    }
//    else
//    {
//        for(NSDictionary * mydict in arr)
//        {
//            projectList * model = [[projectList alloc] init];
//            [model setValuesForKeysWithDictionary:mydict];
//            [self.myPic addObject:model];
//        }
//    }
//   
//  
//
//    
//
//    //购买活动
//    NSArray *buyArr = [NSArray array];
//    buyArr = [[self.myDic objectForKey:@"datas"] objectForKey:@"buyactivitieinfo"];
//    self.seLog = [self.myDic objectForKey:@"login"];
//    self.myBuy = [NSMutableArray array];
//    for(NSDictionary * buydict in buyArr)
//    {
//        projectList * model = [[projectList alloc] init];
//        [model setValuesForKeysWithDictionary:buydict];
//        [self.myBuy addObject:model];
//        
//    }
}
//视频信息
- (void)intoVideoView{
    projectList *projiect = self.detailArr[0];

    JWVideoPlayer *Player = [[JWVideoPlayer alloc]initWithNibName:@"JWVideoPlayer" bundle:nil];
    Player.videoUrl = [projiect.video objectForKey:@"videourl"];
    [self presentViewController:Player animated:YES completion:nil];
   
}

#pragma mark 收藏点击事件
-(void)onClickImage
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if ([[getAboutArtistData shareArtistData]leyingCollectWithId:self.index])
        {
            self.myView.collectImage.image = [UIImage imageNamed:@"yb2h.png"];
        }
        else
        {
            self.myView.collectImage.image = [UIImage imageNamed:@"yb2.png"];
        }
        
    }
   
}
#pragma mark分享点击事件  （暂时隐藏没用）
//-(void)shareImageClick
//{
//    // 拼图
//    // 拼图
//    //    UIImage *imgShare = [self p_pintu];
//    UIImage *imgShare = [DictToData imageWithHeadImageName:@"header1.jpg" WithJietuBase:self.view WithJietuRect:CGRectMake(0, 0, KScreenW, 295) WithfooterImageName:@"footer.jpg"];
//    WXMediaMessage *message = [WXMediaMessage message];
//    [message setThumbImage:[self thumbnailWithImageWithoutScale:imgShare size:CGSizeMake(imgShare.size.width/2 , imgShare.size.height/2 )]];
//    WXImageObject *imageObject = [WXImageObject object];
//    NSData *data = UIImagePNGRepresentation([self thumbnailWithImageWithoutScale:imgShare size:CGSizeMake(imgShare.size.width , imgShare.size.height )]);
//    imageObject.imageData = data;
//    message.mediaObject = imageObject;
//    
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
//    req.scene = WXSceneSession;
//    [WXApi sendReq:req];
//
//}




#pragma mark 展开按钮事件
-(void)btnShowDetailAction:(UIButton *)sender
{
    if ([self.btnShowDetail.currentBackgroundImage isEqual:[UIImage imageNamed:@"zhankai4.png"]]) {
        /// 获取到实际内容高度
        
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        CGSize size = CGSizeMake( CGRectGetWidth(self.view.frame), CGFLOAT_MAX);
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        CGSize briefSize = [self.textLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
        // 设置详情高度
        CGRect DetailWebRect = self.textLabel.frame;
        self.oldDetailsRect = DetailWebRect;
        CGRect newDetailWebRect = CGRectMake(self.oldDetailsRect.origin.x, self.oldDetailsRect.origin.y, self.oldDetailsRect.size.width,self.oldDetailsRect.origin.y/3+ self.oldDetailsRect.size.height);
        self.textLabel.frame = newDetailWebRect;
 
        // 设置展开按钮
        CGRect btnDetailRect = self.btnShowDetail.frame;
        self.oldBtnDetailsRect = btnDetailRect;
        CGRect newBtnDetailRect = CGRectMake(btnDetailRect.origin.x, CGRectGetMaxY(self.textLabel.frame) + 5, btnDetailRect.size.width, btnDetailRect.size.height);
        self.btnShowDetail.frame = newBtnDetailRect;
        [self.btnShowDetail setBackgroundImage:[UIImage imageNamed:@"zhankai1.png"] forState:UIControlStateNormal];
        

        // 设置contentsize
        CGSize oldContentSize = self.scrollView.contentSize;
        self.oldContentSize = oldContentSize;

        self.ImageBackView.frame = CGRectMake(0,CGRectGetMaxY(self.btnShowDetail.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 180);
        
        _VideoScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.ImageBackView.frame), CGRectGetWidth(self.view.frame), 200);
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(self.VideoScrollView.frame)+10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2);
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.tableView.frame));
        self.isShowDetailsContents = YES;
    }
    else
    {
        // 详情
        self.textLabel.frame = self.oldDetailsRect;
        // 按钮
        self.btnShowDetail.frame = self.oldBtnDetailsRect;
        [self.btnShowDetail setBackgroundImage:[UIImage imageNamed:@"zhankai4.png"] forState:UIControlStateNormal];
        // 底部

        self.scrollView.contentSize = self.oldContentSize;
       
        self.ImageBackView.frame = CGRectMake(0, CGRectGetMaxY(self.btnShowDetail.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 180);
        _VideoScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.ImageBackView.frame), CGRectGetWidth(self.view.frame), 200);
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(self.VideoScrollView.frame)+10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2);
        self.isShowDetailsContents = NO;
    }
}





//#pragma mark 截图拼接事件
//- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
//
//{
//    
//    UIImage *newimage;
//    
//    if (nil == image) {
//        
//        newimage = nil;
//        
//    }
//    
//    else{
//        
//        CGSize oldsize = image.size;
//        
//        CGRect rect;
//        
//        if (asize.width/asize.height > oldsize.width/oldsize.height) {
//            
//            rect.size.width = asize.height*oldsize.width/oldsize.height;
//            
//            rect.size.height = asize.height;
//            
//            rect.origin.x = (asize.width - rect.size.width)/2;
//            
//            rect.origin.y = 0;
//            
//        }
//        
//        else{
//            
//            rect.size.width = asize.width;
//            
//            rect.size.height = asize.width*oldsize.height/oldsize.width;
//            
//            rect.origin.x = 0;
//            
//            rect.origin.y = (asize.height - rect.size.height)/2;
//            
//        }
//        
//        UIGraphicsBeginImageContext(asize);
//        
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//        
//        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
//        
//        [image drawInRect:rect];
//        
//        newimage = UIGraphicsGetImageFromCurrentImageContext();
//        
//        UIGraphicsEndImageContext();
//        
//    }
//    
//    return newimage;
//    
//}
/////////////////////////////////////////////
//
//-(UIImage *)p_pintu
//{
//    // 底层图片view
//    UIImageView *imgFatherView = [[UIImageView alloc] init];
//    // 位置
//    CGRect rect = CGRectZero;
//    rect.origin.x = 10;
//    rect.origin.y = 10;
//    
//    
//    // 截图
//    // 设置截图大小
//    UIGraphicsBeginImageContext(CGSizeMake(KScreenW, 300));
//    // 设置截图的裁剪区域
//    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    //    [self.drewArea.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *imageJie = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView *imgBiew = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, imageJie.size.width, imageJie.size.height)];
//    imgBiew.image = imageJie;
//    [imgFatherView addSubview:imgBiew];
//    
//    rect.origin.y = 300;
//    for (int i = 0; i < 2; i ++) {
//        //        UIImage *imgSource = [[UIImage alloc] init];
//        UIImage *imgSource = [UIImage imageWithCGImage:[UIImage imageNamed:@"2.jpg"].CGImage];
//        //        imgSource = [UIImage imageNamed:@"1"];
//        
//        CGFloat height = imgSource.size.height;
//        CGFloat width = imgSource.size.width;
//        rect.size.width = KScreenW - 20;
//        rect.size.height = height * ((KScreenW - 20) / width);
//        UIImageView *newimgView = [[UIImageView alloc] initWithFrame:rect];
//        newimgView.image = imgSource;
//        rect.origin.y += rect.size.height - 1;
//        [imgFatherView addSubview:newimgView];
//    }
//    imgFatherView.frame = CGRectMake(rect.origin.x, 10, rect.size.width, rect.origin.y + 5);
//    
//    // 截图
//    // 设置截图大小
//    UIGraphicsBeginImageContext(CGSizeMake(KScreenW, imgFatherView.frame.size.height));
//    // 设置截图的裁剪区域
//    [imgFatherView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    //    [self.drewArea.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    // 保存到系统相册库中
//    //        UIImageWriteToSavedPhotosAlbum(imageNew, self, nil, nil);
//    // block反向传值
//    //    self.drawView(image);
//    return imageNew;
//}
//


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.buyDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    buyModel *buy = self.buyDataSource[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setWaresDataSourceWithModel:buy];
    if (self.type == 1) {
        cell.waresDetailBtn.hidden = YES;
    }else{
        cell.button = ^(){
            [self setWaresDetailViewWithDic:buy];
        };
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyTableViewCell *cell = (BuyTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
//点击进入购买界面
- (void)setWaresDetailViewWithDic:(buyModel*)dic{
    
    WaresDetailViewController *waresDetail = [[WaresDetailViewController alloc]init];
    waresDetail.buyId = dic.buyId;
    waresDetail.buytype = dic.buytype;
    waresDetail.imgUrl = dic.imgUrl;
    waresDetail.title = dic.title;
    waresDetail.remain = dic.remain;
    waresDetail.price = dic.price;
    
    UINavigationController *UNC = [[UINavigationController alloc]initWithRootViewController:waresDetail];
    UNC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:UNC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
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
