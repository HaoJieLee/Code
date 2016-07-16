//
//  ArtEventDetailsViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtEventDetailsViewController.h"
#import "ArtEventDetails.h"
#import "expandModel.h"
#import "ImageViewController.h"
#import "getActivityList.h"
#import "getAboutArtistData.h"
#import "DictToData.h"
#import "WXApi.h"
#import "ArtistsIntroViewController.h"
#import "webViewController.h"

@interface ArtEventDetailsViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) ArtEventDetails *detailsView;
@property (nonatomic,strong) NSArray *expandArr;
@property (nonatomic,strong) NSMutableArray *arrAct;
@property (nonatomic,strong) NSDictionary *dicAct;

@end

@implementation ArtEventDetailsViewController

-(void)loadScrollView
{
    self.dicAct = [NSDictionary dictionary];
    self.arrAct = [NSMutableArray array];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [[getAboutArtistData shareArtistData]getActivityListWithId:self.myId Artivity:^(NSDictionary *activityListDic) {
            
            self.dicAct = activityListDic;
            
        }];
    }
    
    
    NSDictionary * dictAct = [NSDictionary dictionary];
    dictAct = [self.dicAct objectForKey:@"data"];
    getActivityList * m = [[getActivityList alloc] init];
    [m setValuesForKeysWithDictionary:dictAct];
    
    [self.arrAct addObject:m];
    
    self.detailsView = [[ArtEventDetails alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height) AddPhotoArray:m.photos UserAuthentication:m.userAuthentication IisFavorite:m.isFavorite UserId:m.userId];
   
    self.detailsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.detailsView];
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
    // Do any additional setup after loading the view.
    self.expandArr = [NSArray array];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                // 数据设置
                [self loadScrollView];
                [self p_setupData];
                
                // 轮播图设置
                [self p_setupFirstImg];
                
            });
        });
        
    }

    
    // navigationItem设置
    [self p_setupNavigationItem];
    
    // 给分享图标添加点击事件
    self.detailsView.imgShare.userInteractionEnabled = YES;
    UITapGestureRecognizer *shareTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shareImageClick)];
    [self.detailsView.imgShare addGestureRecognizer:shareTap];
    
}

-(void)p_setupNavigationItem
{
    // 艺人社区
    UILabel *lblItemTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    lblItemTitle.text = @"通告详情";
    lblItemTitle.textAlignment = NSTextAlignmentCenter;
    lblItemTitle.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = lblItemTitle;
    // 重写左侧返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];

    
    //self.shareImage.hidden = YES;

}
//右侧按钮管理分享
- (void)rightBarButtonItemAction{
    NSLog(@"ddd");
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

-(void)leftBarButtonItemAction
{
    // 保存 反向传值
//    [self.delegate passName:_detailsView.lblClick.text WithIndexPath:_indexPathy];
    [self.navigationController popViewControllerAnimated:YES];
}
//分享截图
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


-(void)p_setupFirstImg
{
    // 定义pageControl的位置
    self.detailsView.firstImageView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    // 设置图片间隔
    self.detailsView.firstImageView.autoScrollTimeInterval = 3;
    
    // 设置代理
    self.detailsView.firstImageView.delegate = self;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int  i = 0; i < self.expandArr.count; i++)
    {

        [arr addObject:self.expandArr[i]];
    }

    //轮播网络图片
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.detailsView.firstImageView.imageURLStringsGroup = arr;
//            self.detailsView.firstImageView.titlesGroup = descStr;
        });
    }
   
}

// 轮播图代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    expandModel *p = self.expandArr[index];
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
    
   
    
    
    
//    ImageViewController *imageVC = [[ImageViewController alloc] init];
//    imageVC.index = index;
//    [self.navigationController pushViewController:imageVC animated:YES];
}

-(void)p_setupData
{

    
        getActivityList *g = self.arrAct[0];
    self.expandArr = [NSArray arrayWithObjects:g.coverImgUrl, nil];
    NSString *string = [NSString stringWithFormat:@"%@时 - %@时",[Factory stringWithDataString:g.startTime],[Factory stringWithDataString:g.endTime]];
    self.detailsView.notifyTime.text = [NSString stringWithFormat:@"%@时",[Factory stringWithDataString:g.publishTime]];
    self.detailsView.lblTime.text = string;
    self.detailsView.lblLocation.text = [NSString stringWithFormat:@"%@-%@" ,g.city,g.address];
    self.detailsView.lblPrice.text = [NSString stringWithFormat:@"%@/%@",g.reward,g.rewardUnit];
    self.detailsView.lblTitle.text = g.title;
    self.detailsView.photoArray = [NSMutableArray arrayWithArray:g.photos];
//    self.detailsView.lblDetails.text = g.content;
    // 详情加载
    self.detailsView.lblDetails.text = g.DDescription;
    
    [self.detailsView.lblDetails sizeToFit];
    
    self.detailsView.lblClick.text = [NSString stringWithFormat:@"男%ld名 女%ld名",[g.male integerValue],[g.female integerValue]];
    
    self.detailsView.lblModol.text = g.viewTime;
    [self.detailsView.userHeadImage sd_setImageWithURL:[NSURL URLWithString:g.userAvatar] placeholderImage:[UIImage imageNamed:@"both1.png"]];
    self.detailsView.userNameLabel.text = g.userName;
    self.detailsView.userWorkLabel.text = g.userIdentity;
    
    __weak typeof(self)weakself = self;
    self.detailsView.block = ^(NSString *string){
        [weakself TelUserWith:g.contact];
    };
    self.detailsView.userBlock = ^(){
        [weakself InfoUserInformation:g.userId];
    };
}
- (void)TelUserWith:(NSString *)tel{
    NSLog(@"ddd");
        NSString *cellnumber = [NSString stringWithFormat:@"tel:%@",tel];//tel电话字符串（从网络获取的内容）
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cellnumber]];
}
- (void)InfoUserInformation:(NSString*)userId{
    ArtistsIntroViewController *artists = [[ArtistsIntroViewController alloc]init];
    artists.actsIndex = userId;
    artists.InType = 0;
    UINavigationController *UNC = [[UINavigationController alloc]initWithRootViewController:artists];
    [self presentViewController:UNC animated:YES completion:nil];
}
#pragma mark 滑动问题解决
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 2550) {
        // webview
        CGPoint point = scrollView.contentOffset;
        if (point.y > 0) {
            scrollView.contentOffset = CGPointMake(point.x, 0);//这里不要设置为CGPointMake(0, point.y)，这样我们在文章下面左右滑动的时候，就跳到文章的起始位置，不科学
        }
        if (point.y < 0) {
            scrollView.contentOffset = CGPointMake(point.x, 0);
        }
    }
}

#pragma mark ---   webView设置
///////////////////////////////////////////////////////
- (NSString *)showInfoWithWebviewByHtml:(NSString *)htmlStr
{
    NSMutableParagraphStyle *html = [[NSMutableParagraphStyle alloc] init];
    html.lineSpacing = 10;// 字体的行间距
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ,NSParagraphStyleAttributeName:html} documentAttributes:nil error:nil];
//    CGFloat width = KScreenW * 0.9;
//    CGFloat height = KScreenW * 0.6;
//    NSMutableString *html = [NSMutableString string];
//    [html appendString:@"<html>"];
//    [html appendString:@"<head>"];
//    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"night.css" withExtension:nil]];
//    [html appendString:@"<style type = \"text/css\">"];
//    [html appendString:[NSString stringWithFormat:@"img{width:%f;height:%f;}",width,height]];
//    [html appendString:@"</style>"];
//    [html appendString:@"</head>"];
//    [html appendString:@"<body style='background-color:rgb(222,222,222)'>"];
//    [html appendString:htmlStr];
//    [html appendString:@"</body>"];
//    [html appendString:@"</html>"];
    
    return (NSString*)attributedString;
}

#pragma mark --- 分享按钮功能实现
-(void)shareImageClick
{
    // 拼图
    //    UIImage *imgShare = [self p_pintu];
    
//    UIImage *imgShare = [DictToData imageWithHeadImageName:@"header2.jpg" WithJietuBase:self.view WithJietuSize:CGSizeMake(KScreenW, CGRectGetMaxY(self.detailsView.lblDetails.frame) - CGRectGetMaxY(self.detailsView.firstImageView.frame)) WithfooterImageName:@"footer.jpg"];    // 微信分享图片
    UIImage *imgShare = [DictToData imageWithHeadImageName:@"header2.jpg" WithJietuBase:self.view WithJietuRect:CGRectMake(0, CGRectGetMaxY(self.detailsView.firstImageView.frame), KScreenW, CGRectGetMaxY(self.detailsView.lblDetails.frame) - CGRectGetMaxY(self.detailsView.firstImageView.frame)) WithfooterImageName:@"footer.jpg"];
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
