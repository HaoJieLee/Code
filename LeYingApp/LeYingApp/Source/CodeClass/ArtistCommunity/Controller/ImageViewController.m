//
//  ImageViewController.m
//  SeeWorld
//
//  Created by LZZ on 15/10/19.
//  Copyright (c) 2015年 LZZ. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

//@property (nonatomic,strong) ImageScrollModel *scrollModel;


@property (nonatomic,strong) UIView *bigView;
@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UILabel *lblPage;
@property (nonatomic,strong) UIScrollView *scrollViewText;
@property (nonatomic,strong) UILabel *lblDetals;


@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 请求数据
//    [self p_RequestData];
    
    // 设置图片排版
    [self p_setupImgView];
    
    // 详情显示
//    [self p_setupScrollViewContent];
    
    
    self.scrollView.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
    // 隐藏导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bargound.png"] forBarMetrics:UIBarMetricsDefault];
    // 导航栏底部线
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"nav_bargound.png"];
}

// 请求数据
//-(void)p_RequestData
//{
//    GetImageDataTools *dataTools = [[GetImageDataTools alloc] init];
//    [dataTools getDataWithNumber:self.number scrollM:^(ImageScrollModel *model) {
//        self.scrollModel = model;
//    }];
//}

-(void)p_setupImgView
{
    // imgMainView
    self.scrollView = [[UIScrollView alloc] init];
    CGFloat scrX = 0;
    CGFloat scrY = 0;
    CGFloat scrW = KScreenW;
    CGFloat scrH = KScreenH;
    self.scrollView.frame = CGRectMake(scrX, scrY, scrW, scrH);
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_scrollView];
    
    // 图片布局
    CGFloat imgY = 0;
    CGFloat imgW = KScreenW;
    CGFloat imgH = KScreenH;
    // 图片数据展示
//    for (int i = 0; i < self.scrollModel.photos.count; i ++) {
//        CGFloat imgX = KScreenW * i;
//        UIImageView *imgView = [[UIImageView alloc] init];
//        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
//        ImageChildModel *childModel = self.scrollModel.photos[i];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:childModel.imgurl]];
//        imgView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.scrollView addSubview:imgView];
//    }
//    self.scrollView.contentSize = CGSizeMake(KScreenW * self.scrollModel.photos.count, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
}



//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    self.lblTitle.text = self.scrollModel.setname;
//    self.lblPage.text = [NSString stringWithFormat:@"%ld/%ld",[self getCurrentPage:*targetContentOffset],self.scrollModel.photos.count];
//    // 自适应高度
//    CGRect rect = self.lblDetals.frame;
//    rect.size.height = [((ImageChildModel *)self.scrollModel.photos[[self getCurrentPage:*targetContentOffset] - 1]).note sizeOfTextWithMaxSize:CGSizeMake(CGRectGetWidth(self.scrollViewText.frame), 10000) font:[UIFont systemFontOfSize:14]].height;
//    self.lblDetals.frame = rect;
//    self.scrollViewText.contentSize = CGSizeMake(0, self.lblDetals.frame.size.height);
//    self.lblDetals.text = ((ImageChildModel *)self.scrollModel.photos[[self getCurrentPage:*targetContentOffset] - 1]).note;
//    
//}

// 获取当前页码
-(NSInteger)getCurrentPage:(CGPoint)contentOffset
{
    CGPoint point = contentOffset;
    NSLog(@"%f,%f",point.x,point.y);
    NSInteger currentPage = (point.x + CGRectGetWidth(self.scrollView.frame) / 2) / CGRectGetWidth(self.scrollView.frame);
    NSLog(@"%ld",currentPage);
    return currentPage + 1;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
    // 导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd"] forBarMetrics:UIBarMetricsDefault];
    
    // 导航栏底部线
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@""];
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
