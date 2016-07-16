//
//  MineArtistCollectionViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/16.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MineArtistCollectionViewController.h"
#import "MineArtistCollectionViewCell.h"
#import "userMessage.h"
#import "ArtistsIntroViewController.h"
@interface MineArtistCollectionViewController ()

@property (nonatomic,strong)NSMutableArray  *colectArr;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,strong)NSMutableArray *leyArr;



@end

@implementation MineArtistCollectionViewController

static NSString * const reuseIdentifier = @"MineArtistCollectionViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    
    [self.collectionView registerClass:[MineArtistCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    self.leyArr = [NSMutableArray array];
     self.colectArr = [NSMutableArray array];
    
   
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        
         [self getArtcollectWithpage:@"1" Type:@"2"];
        
        [self.collectionView reloadData];
         self.index = 2;
        [self p_setupRefresh];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self getArtcollectWithpage:@"1" Type:@"2"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.collectionView reloadData];
//            });
//        });
        
        
        
    }
    
}


#pragma mark - 上拉加载 下拉刷新
/////////////////////////////////////////////////////
-(void)p_setupRefresh
{
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [self.collectionView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
//    self.collectionView.headerPullToRefreshText = @"下拉";
//    self.collectionView.headerReleaseToRefreshText = @"松开刷新";
//    self.collectionView.headerRefreshingText = @"玩命加载中...";
//    
//    self.collectionView.footerPullToRefreshText = @"上拉";
//    self.collectionView.footerReleaseToRefreshText = @"松开加载";
//    self.collectionView.footerRefreshingText = @"玩命加载中...";
}

// 开始进入刷新状态
- (void)headerRereshing
{
    self.index = 2;
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        self.leyArr = [NSMutableArray array];
        [self getArtcollectWithpage:@"1" Type:@"2"];
        [self.collectionView reloadData];
        [self.collectionView headerEndRefreshing];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//            dispatch_async(dispatch_get_main_queue(), ^{
//               
//            });
//        });
    }
    
    
}

// 开始进入加载状态
- (void)footerRereshing
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 1.加载更多数据
        
        
       [self getArtcollectWithpage:[NSString stringWithFormat:@"%ld",(long)self.index++] Type:@"2"];
        [self.collectionView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionView footerEndRefreshing];
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self getArtcollectWithpage:[NSString stringWithFormat:@"%ld",(long)self.index++] Type:@"2"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.collectionView reloadData];
//                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
//                [self.collectionView footerEndRefreshing];
//            });
//        });
    }
    
    
    
}


-(void)getArtcollectWithpage:(NSString *)myPage Type:(NSString *)mytype
{
 
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/shoucanglist.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"page=%@&type=%@",myPage,mytype];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [[dict objectForKey:@"datas"]objectForKey:@"list"];
    
   self.colectArr = [NSMutableArray array];
    
    
    
    if (![[NSString stringWithFormat:@"%@",[[dict objectForKey:@"datas"]objectForKey:@"list"]] isEqualToString:@"0"])
    {
        NSLog(@"%@",[[dict objectForKey:@"datas"]objectForKey:@"list"]);
        for (NSDictionary * dict in arr)
        {
            userMessage * m = [[userMessage alloc] init];
            [m setValuesForKeysWithDictionary:dict];
            [self.colectArr addObject:m];
        }
        
        
        if ([myPage isEqualToString:@"1"])
        {
            
            self.leyArr = _colectArr;
        }
        else
        {
            // 赋值
            for (int i = 0; i < _colectArr.count; i++)
            {
                [_leyArr addObject:_colectArr[i]];
            }
        }

    }
    else
    {
        
        if (self.leyArr.count != 1)
        {
            // 是上拉加载page没有请求到数据
            
        }
        else
        {
            [self.leyArr removeAllObjects];
        }
    }

   
    
   //
//
//    if ([[NSString stringWithFormat:@"%@",arr]isEqualToString:@"0"])
//    {
//        
//    }
//    else
//    {
//        for (NSDictionary * dict in arr)
//        {
//            userMessage * m = [[userMessage alloc] init];
//            [m setValuesForKeysWithDictionary:dict];
//            [self.colectArr addObject:m];
//        }
//    }
//    
//    if (self.colectArr.count > 0)
//    {
//      
//    }
//   

  
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.leyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MineArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    userMessage *u = self.leyArr[indexPath.row];
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
    if ([u.avatar isEqualToString:@""])
    {
         cell.imgShows.image = [UIImage imageNamed:@"yiren2"];
    }
    else
    {
        NSString *str2 = u.avatar;
        [cell.imgShows sd_setImageWithURL:[NSURL URLWithString:[str1 stringByAppendingString:str2]]];
        
    }
  
    cell.lblTitle.text = u.yiming;
    [cell.imgDelete setImage:[UIImage imageNamed:@"huishou1"] forState:UIControlStateNormal];
    [cell.imgDelete addTarget:self action:@selector(delImageClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.imgDelete.tag = [u.Id integerValue];
    
    // Configure the cell...
    
    return cell;
}
//删除收藏
-(void)delImageClick:(UIButton *)sender
{
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        if ([self getDelcollectWithId: [NSString stringWithFormat:@"%ld",(long)sender.tag] Type:@"2"]) {
            // 删除成功
        }
        else
        {
            // 删除失败
        }
        if (self.leyArr.count == 1)
        {
            [self.leyArr removeAllObjects];
            [self.collectionView reloadData];
        }
      
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              [self getArtcollectWithpage:@"1" Type:@"2"];
            dispatch_async(dispatch_get_main_queue(), ^{
        
               [self.collectionView reloadData];
            });
        });
    }
    
    
}

-(BOOL)getDelcollectWithId:(NSString *)myId Type:(NSString *)mytype
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/delshoucang.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"id=%@&type=%@",myId,mytype];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ( [[NSString stringWithFormat:@"%@",[[dict objectForKey:@"datas"] objectForKey:@"success"]] isEqualToString:@"1"])
    {
        // 删除成功
        return YES;
    }
    else
    {
        // 删除失败
        return NO;
    }
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    userMessage *u = self.leyArr[indexPath.row];
    ArtistsIntroViewController *artvc = [[ArtistsIntroViewController alloc]init];
    artvc.actsIndex = u.memberid;
    [self.navigationController pushViewController:artvc animated:YES];
}




#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
