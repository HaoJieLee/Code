//
//  ShowsModelCollectionViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ShowsModelCollectionViewController.h"
#import "ShowsModelCollectionViewCell.h"
#import "detailModel.h"
#import "GroupPhotoViewController.h"
#import "MyViewController.h"
@interface ShowsModelCollectionViewController ()
@property (nonatomic,strong)NSMutableArray *myArr;
@property (nonatomic,strong)NSMutableArray *picArr;


// 模特卡图片
@property (nonatomic,strong) UIImageView *imgBigImage;

// 模特卡url
@property (nonatomic,strong) NSString *strUrl;

@property (nonatomic,strong) NSDictionary *dictForModel;


@end

@implementation ShowsModelCollectionViewController

static NSString * const reuseIdentifier = @"ShowsModelCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myArr = [NSMutableArray array];
    self.picArr = [NSMutableArray array];
    self.dictForModel = [NSDictionary dictionary];
    
    [self.collectionView registerClass:[ShowsModelCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // 头部视图注册
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
          [self setData];
    }

    //设置collectview的高度
    CGRect rectNew = self.collectionView.frame;
    CGFloat newHeight;
    if (![[NSString stringWithFormat:@"%@",_myArr] isEqualToString:@"<null>"]) {
        newHeight = (KScreenW / 2 - 10 + 6) * ((self.myArr.count % 2 == 0 ? self.myArr.count : self.myArr.count + 1) / 2);
    }
    self.collectionView.contentSize = CGSizeMake(rectNew.size.width, newHeight);
    self.collectionViewSizeNew = self.collectionView.contentSize;
}
-(void)setData
{
    for (NSDictionary *dict in self.photoArray)
    {
        [self.myArr addObject:[dict objectForKey:@"url"]];
        
    }
    
   
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([[NSString stringWithFormat:@"%@",self.myArr] isEqualToString:@""])
    {
        return 1;
    }
    else
    {
        if ([[NSString stringWithFormat:@"%@",_myArr] isEqualToString:@"<null>"]) {
            return 0;
        }
        else
        {
            return _myArr.count;
        }
    }

    //return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShowsModelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    NSString *str2 = self.myArr[indexPath.row];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
         [cell.imgCategory sd_setImageWithURL:[NSURL URLWithString:str2]];
    }
   

    
   // cell.imgCategory.image = [UIImage imageNamed:@"2.jpg"];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable]) {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        GroupPhotoViewController *photoVC = [[GroupPhotoViewController alloc]init];
        photoVC.myBigArr = self.myArr;
        photoVC.myIndest = indexPath.row;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:photoVC animated:YES];
    
    }
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headView" forIndexPath:indexPath];
    headView.backgroundColor = [UIColor colorWithRed:220/255.0 green:221/255.0 blue:222/255.0 alpha:0.8];
    //headView.backgroundColor = [UIColor redColor];
    
    // 设置头部内容
    UIView *newheadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headView.frame), CGRectGetHeight(headView.frame))];
    
    // 模特卡  5 + 35
    UIView *modelCardView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(newheadView.frame), 35)];
    modelCardView.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [newheadView addSubview:modelCardView];
    
    UILabel *lblModelCard = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(modelCardView.frame) - 20, CGRectGetHeight(modelCardView.frame))];
    lblModelCard.font = [UIFont systemFontOfSize:17];
    lblModelCard.textColor = [UIColor colorWithRed:85/255.0 green:86/255.0 blue:81/255.0 alpha:1];
    lblModelCard.text = @"展示卡";
    lblModelCard.textAlignment = NSTextAlignmentCenter;
    [modelCardView addSubview:lblModelCard];
    
    // 图片   5 + 210
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(modelCardView.frame) + 5, CGRectGetWidth(modelCardView.frame), 210)];
    backGroundView.backgroundColor = [UIColor colorWithRed:186/255.0 green:190/255.0 blue:194/255.0 alpha:1];
    [newheadView addSubview:backGroundView];
    
    _imgBigImage = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, CGRectGetWidth(backGroundView.frame) - 8, CGRectGetHeight(backGroundView.frame) - 8)];
    
    
   
   
    if ([_mypicStr isEqualToString:@""])
    {
        _imgBigImage.image = [UIImage imageNamed:@"mmdo.jpg"];
    }
    else
    {
         self.strUrl = self.mypicStr;
        [_imgBigImage sd_setImageWithURL:[NSURL URLWithString:self.mypicStr]];
        //image  添加点击事件
        UITapGestureRecognizer *PeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne:)];
        _imgBigImage.userInteractionEnabled = YES;
        [_imgBigImage addGestureRecognizer:PeTap1];
    }

    //imgBigImage.image = [UIImage imageNamed:@"yiren1"];
    [backGroundView addSubview:_imgBigImage];
    
    
    // 照片秀  10 + 35
    UIView *photoCardView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backGroundView.frame) + 5, CGRectGetWidth(newheadView.frame), 35)];
    photoCardView.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [newheadView addSubview:photoCardView];
    
    UILabel *lblPhotoCard = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(photoCardView.frame) - 20, CGRectGetHeight(photoCardView.frame))];
    lblPhotoCard.font = [UIFont systemFontOfSize:17];
    lblPhotoCard.textColor = [UIColor colorWithRed:85/255.0 green:86/255.0 blue:81/255.0 alpha:1];
    lblPhotoCard.text = @"照片秀";
    lblPhotoCard.textAlignment = NSTextAlignmentCenter;
    [photoCardView addSubview:lblPhotoCard];
    
    
    [headView addSubview:newheadView];
//
    return headView;
}
#pragma mark 模特卡点击放大
-(void)imageActionOne:(UIImageView *)sender
{
    MyViewController *mvc = [[MyViewController alloc] init];
    if (self.strUrl != nil) {
        mvc.imageString = self.strUrl;
    }
    // 昵称
    mvc.strMessage = [NSString stringWithFormat:@"昵称:%@",[[NSString stringWithFormat:@"%@",[self.dictForModel objectForKey:@"yiming"]] isEqualToString:@""] ? @"nicheng" : [NSString stringWithFormat:@"%@",[self.dictForModel objectForKey:@"yiming"]]];
    // 三围
    mvc.strSanweiMes = [NSString stringWithFormat:@"%@cm %@kg %@ %@码",[NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"height"]] == nil ? @"0" : [NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"height"]],[NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"weight"]] == nil ? @"0" : [NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"weight"]],[NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"bwh"]] == nil ? @"0/0/0" : [NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"bwh"]],[NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"shoesize"]] == nil ? @"0" : [NSString stringWithFormat:@"%@",[_dictForModel objectForKey:@"shoesize"]]];
    [self presentViewController:mvc animated:YES completion:nil];
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
