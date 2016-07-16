//
//  ArtistsIntroViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtistsIntroViewController.h"

#import "ArtistsIntroView.h"
#import "ShowsModelCollectionViewController.h"
#import "ArtistsPresentTableViewController.h"
#import "getAboutArtistData.h"
#import "detailModel.h"
#import "getAboutArtistData.h"
#import "WXApi.h"

#import "ChatViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface ArtistsIntroViewController ()<LGtitleBarViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)ArtistsIntroView *artVC;


@property(nonatomic,strong)UIScrollView *BackView;
//@property (nonatomic,strong)ShowsModelCollectionViewController *showVC;
@property (nonatomic,strong)ArtistsPresentTableViewController *artistsVC;
@property (nonatomic,copy)NSString *mypicStr;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) LGtitleBarView *titleBar;


@property (nonatomic,strong)NSArray *detailArr;
@property (nonatomic,assign) CGSize newASize;
@property (nonnull,strong)NSString *myArtID;

@property (nonatomic,strong)NSString *publicToken;


@property (nonatomic,strong)NSArray *photoArray;

@end

@implementation ArtistsIntroViewController

-(void)loadView
{
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *navBackgroundBarImage = [[NSBundle mainBundle] pathForResource:@"sytopd"ofType:@"png"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithContentsOfFile:navBackgroundBarImage] forBarMetrics:UIBarMetricsDefault];

    //设置tabbar的背景图片
    self.navigationItem.title = @"详情";
    self.artVC = [[ArtistsIntroView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _artVC;
    self.artVC.backScrollView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [DictToData showMBHUBWithContent:@"玩命加载中..." ToView:self.view];
    self.detailArr = [NSArray array];
   
       if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 子线程中加载数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            
            [[getAboutArtistData shareArtistData] getRecommendWithId:self.actsIndex Recommend:^(NSArray *Recommend) {
                
                self.detailArr = [NSMutableArray arrayWithArray:Recommend] ;
            }];
           
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                
                detailModel *d = self.detailArr[0];
                self.photoArray = d.photo;
                self.mypicStr = d.moka;
                self.titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.artVC.topView.frame)-2, self.view.frame.size.width, 42)];
                //self.titleBar.backgroundColor = [UIColor blackColor];
                self.titles = @[@"照片",  @"资料"];
                
                self.titleBar.titles = _titles;
                self.titleBar.delegate = self;
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.titleBar.collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
                [self.artVC.backScrollView addSubview:_titleBar];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [self interfaceHandle];
                [self setData];
            });
        });


    }
    
    //   底部悬浮视图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenH-40, KScreenW, 40)];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    UIButton *siliaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, view.width/2, 40)];
    [siliaoBtn setTitle:@"关注" forState:UIControlStateNormal];
    [siliaoBtn addTarget:self action:@selector(guanzhuAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *guanzhuBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.width/2, 0, view.width/2, 40)];
    [guanzhuBtn setTitle:@"打个招呼" forState:UIControlStateNormal];
    [guanzhuBtn addTarget:self action:@selector(siliaoAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:siliaoBtn];
    [view addSubview:guanzhuBtn];
    [self.view addSubview:view];
    
    //重写左bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    

    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"私聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
}

#pragma mark 私聊
-(void)siliaoAction
{

    NSUserDefaults *myOtherName = [NSUserDefaults standardUserDefaults];
    NSString *myOtName = [myOtherName objectForKey:@"selfotherName"];
    
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.hidesBottomBarWhenPushed = YES;
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = self.actsIndex;
    chatVC.hidesBottomBarWhenPushed = YES;
    chatVC.title = myOtName;
    chatVC.myOtherId = self.actsIndex;
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

#pragma mark 收藏
-(void)guanzhuAction
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if ([[getAboutArtistData shareArtistData] artistCollectWithId:self.myArtID])
        {
            self.artVC.collectImage.image = [UIImage imageNamed:@"yb2h.png"];
        }
        else
        {
            self.artVC.collectImage.image = [UIImage imageNamed:@"yb2.png"];
        }
    }
}

#pragma mark 请求token

-(NSString *)getToken
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/Artist/detail"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=19"];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *myToken = [[dict objectForKey:@"datas"]objectForKey:@"token"];
   // NSLog(@"%@",dict);
    NSLog(@"%@",[[dict objectForKey:@"datas"]objectForKey:@"error"]);
    return  myToken;
    
}

-(void)leftBarButtonItemAction
{
    if (self.InType) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
-(void)setData
{
    
    
    //上部UI
    detailModel *d = self.detailArr[0];
    
    
   
    if ([[NSString stringWithFormat:@"%@",d.avatar] isEqualToString:@"(null)"])
    {
        self.artVC.headImage.image = [UIImage imageNamed:@"mmdo.jpg"];
    }
    else
    {
        [ self.artVC.headImage sd_setImageWithURL:[NSURL URLWithString:d.avatar]];//头像
    }
    
    // 性别图片设置
    if ([d.gender isEqualToString:@"1"])
    {
        self.artVC.sexImage.image = [UIImage imageNamed:@"boy.png"];
    }
    else
    {
         self.artVC.sexImage.image = [UIImage imageNamed:@"girl.png"];
    }
    
    self.artVC.nameLable.text = d.nicename;//艺名
    //地址
    self.artVC.addressLabel.text = d.location;
    //保存昵称
    NSUserDefaults *myOtherName = [NSUserDefaults standardUserDefaults];
    [myOtherName setObject:d.nicename forKey:@"selfotherName"];
    
    
    self.artVC.markLab.text = d.subCategory;//标签
    self.artVC.introduceLable.text = d.motto;
    self.artVC.numberShowLab.text = [d.yirenno stringByAppendingString:d.shoeSize];
    self.myArtID = d.Id;
    //艺人点击量
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        
 
        [[getAboutArtistData shareArtistData]artAddclick:self.myArtID];
    }
   
    //分享
    self.artVC.shareImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *shareTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareImageClick)];
    [self.artVC.shareImage addGestureRecognizer:shareTap];
    
    //收藏初始化显示
    if ([[NSString stringWithFormat:@"%d",d.isFavorite] isEqualToString:@"1"])
    {
        self.artVC.collectImage.image = [UIImage imageNamed:@"yb2h.png"];
    }
    else
    {
        self.artVC.collectImage.image = [UIImage imageNamed:@"yb2.png"];
    }
    self.artVC.collectImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.artVC.collectImage addGestureRecognizer:singleTap];
    
}

// 收藏按钮
-(void)onClickImage
{
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if ([[getAboutArtistData shareArtistData] artistCollectWithId:self.myArtID])
        {
            self.artVC.collectImage.image = [UIImage imageNamed:@"yb2h.png"];
        }
        else
        {
            self.artVC.collectImage.image = [UIImage imageNamed:@"yb2.png"];
        }
    }
   
    
}

//分享点击事件
-(void)shareImageClick
{
    
    // 拼图
    UIImage *imgShare = [self p_pintu];
    // 微信分享图片
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[self thumbnailWithImageWithoutScale:imgShare size:CGSizeMake(imgShare.size.width/2 , imgShare.size.height/2 )]];
    WXImageObject *imageObject = [WXImageObject object];
    NSData *data = UIImagePNGRepresentation([self thumbnailWithImageWithoutScale:imgShare size:CGSizeMake(imgShare.size.width , imgShare.size.height )]);
    imageObject.imageData = data;
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
}



-(void)interfaceHandle
{
    self.BackView = [[UIScrollView alloc]init];
    self.BackView.frame = CGRectMake(0, CGRectGetMaxY(self.titleBar.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 2800);
    self.BackView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)*2, CGRectGetHeight([UIScreen mainScreen].bounds));
    //self.BackView.backgroundColor = [UIColor blueColor];
    self.BackView.delegate = self;
    [self.artVC.backScrollView addSubview:_BackView];
    self.BackView.pagingEnabled = YES;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - 10, CGRectGetWidth(self.view.frame) / 2 - 10);
    flowLayout.minimumInteritemSpacing = 3;
    // 上下间距
    flowLayout.minimumLineSpacing = 6;
    flowLayout.headerReferenceSize = CGSizeMake(0, 300);
    // 设置整体四周边距  上、左、下、右
    flowLayout.sectionInset = UIEdgeInsetsMake(2, 5, 15, 5);
    ShowsModelCollectionViewController *categoryVC = [[ShowsModelCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    categoryVC.showIndex = self.actsIndex;
    categoryVC.mypicStr = self.mypicStr;
    categoryVC.photoArray = [[NSMutableArray alloc]initWithArray:self.photoArray];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    categoryVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 10000);
    [self addChildViewController:categoryVC];
    
    [self.BackView addSubview:categoryVC.collectionView];
    
    
    self.artistsVC = [[ArtistsPresentTableViewController alloc]init];
    
    self.artistsVC.presentId = self.actsIndex;
    self.artistsVC.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, self.view.frame.size.width, 2000);
    [self addChildViewController:_artistsVC];
    [self.BackView addSubview:_artistsVC.tableView];
    
    
    
    self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, CGRectGetMaxY(self.titleBar.frame) + categoryVC.collectionViewSizeNew.height + 300 + 74);
    
    self.newASize = self.artVC.backScrollView.contentSize;

}

#pragma mark 滑动问题解决
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 2501) {
        // scrollview
        CGFloat contentSet = self.BackView.contentOffset.x / KScreenW;
        if (contentSet == 0) {
            // collectionview
            self.artVC.backScrollView.contentSize = self.newASize;
        }
        else
        {
            // tableview
            self.artVC.backScrollView.contentSize = CGSizeMake(KScreenW, CGRectGetMaxY(self.titleBar.frame) + _artistsVC.tableView.contentSize.height + 120);
            //            CGPoint LGPoint = CGPointMake(self.titleBar.frame.origin.x, self.titleBar.frame.origin.y);
            //            CGPoint point = scrollView.contentOffset;
            //            if (point.y >= LGPoint.y) {
            //                scrollView.contentOffset = CGPointMake(point.x, LGPoint.y);
            //            }
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


///////////////////////////////////////////
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    
    if (nil == image) {
        
        newimage = nil;
        
    }
    
    else{
        
        CGSize oldsize = image.size;
        
        CGRect rect;
        
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            
            rect.size.height = asize.height;
            
            rect.origin.x = (asize.width - rect.size.width)/2;
            
            rect.origin.y = 0;
            
        }
        
        else{
            
            rect.size.width = asize.width;
            
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            
            rect.origin.x = 0;
            
            rect.origin.y = (asize.height - rect.size.height)/2;
            
        }
        
        UIGraphicsBeginImageContext(asize);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
    
}
///////////////////////////////////////////

-(UIImage *)p_pintu
{
    // 底层图片view
    UIImageView *imgFatherView = [[UIImageView alloc] init];
    // 位置
    CGRect rect = CGRectZero;
    rect.origin.x = 10;
    rect.origin.y = 10;
    
    
    // 截图
    // 设置截图大小
    UIGraphicsBeginImageContext(CGSizeMake(KScreenW, 300));
    // 设置截图的裁剪区域
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    [self.drewArea.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageJie = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgBiew = [[UIImageView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, imageJie.size.width, imageJie.size.height)];
    imgBiew.image = imageJie;
    [imgFatherView addSubview:imgBiew];
    
    rect.origin.y = 300;
    for (int i = 0; i < 2; i ++) {
        //        UIImage *imgSource = [[UIImage alloc] init];
        UIImage *imgSource = [UIImage imageWithCGImage:[UIImage imageNamed:@"2.jpg"].CGImage];
        //        imgSource = [UIImage imageNamed:@"1"];
        
        CGFloat height = imgSource.size.height;
        CGFloat width = imgSource.size.width;
        rect.size.width = KScreenW - 20;
        rect.size.height = height * ((KScreenW - 20) / width);
        UIImageView *newimgView = [[UIImageView alloc] initWithFrame:rect];
        newimgView.image = imgSource;
        rect.origin.y += rect.size.height - 1;
        [imgFatherView addSubview:newimgView];
    }
    imgFatherView.frame = CGRectMake(rect.origin.x, 10, rect.size.width, rect.origin.y + 5);
    
    // 截图
    // 设置截图大小
    UIGraphicsBeginImageContext(CGSizeMake(KScreenW, imgFatherView.frame.size.height));
    // 设置截图的裁剪区域
    [imgFatherView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    [self.drewArea.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageNew;
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
