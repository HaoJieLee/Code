//
//  CategoryViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/6/28.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CategoryViewController.h"
#import "DropDownListView.h"
#import "DropDownChooseProtocol.h"
#import "ImageScrollBox.h"

@interface CategoryViewController ()<ImageScrollBoxDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataSource;//collection数据
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *myarrayM;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc]init];
    self.myarrayM = [[NSMutableArray alloc]init];
    [self.view addSubview:self.scrollView];
    
    // Do any additional setup after loading the view.
}

- (UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
        [self addImage];
        [self setDropDownListView];
        [_scrollView addSubview:self.collectionView];
        
    }
    return _scrollView;
}
#pragma mark - 两个轮播器
- (void)addImage{
    ImageScrollBox *imageS = [[ImageScrollBox alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 190)];
    imageS.backgroundColor = [UIColor whiteColor];
    imageS.urlImageArray = [[NSMutableArray alloc]initWithArray:self.myarrayM];
    imageS.timeInterval = 5.0f;
    imageS.sDirection = scrollDirectionHorizontalMoved;
    [self.scrollView addSubview:imageS];
    
}
- (void)setDropDownListView{
    DropDownListView *dropDownView = [[DropDownListView alloc]initAndWithFrame:CGRectMake(0, 200, self.view.frame.size.width-5, 40) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    [_scrollView addSubview:dropDownView];

    
}
- (UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 3 - 6, 145);
        flowLayout.minimumInteritemSpacing = 3;
        flowLayout.minimumLineSpacing = 3;
        flowLayout.headerReferenceSize = CGSizeMake(0, CGRectGetHeight(self.view.frame)/4 + 30);
        
        
        // 新版本
        // 设置整体四周边距  上、左、下、右
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 15, 5);
        
         _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height-250) collectionViewLayout:flowLayout];

    }
    return _collectionView;

}
-(void)p_reloadDataa
{
    [DictToData showMBHUBWithContent:@"玩命加载中..." ToView:self.view];
    
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 艺人轮播
            [[getAboutArtistData shareArtistData]
             getArtistExpandWithType:@"1" WithCategoryid:@"1" Expand:^(NSArray *artistExpandArr) {
                 [self.myarrayM addObjectsFromArray:artistExpandArr];
             }];
        });
        
        
        
        
        
    }}



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
