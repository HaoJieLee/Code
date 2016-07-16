//
//  CrewCollectionViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CrewCollectionViewController.h"
#import "CrewPhCollectionViewCell.h"
#import "projectList.h"
#import "PhotoViewController.h"
@interface CrewCollectionViewController ()

@end

@implementation CrewCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.collectionView registerClass:[CrewPhCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f  blue:222/255.0f alpha:1.0];
    
    CGRect rectNew = self.collectionView.frame;
    CGFloat newHeight = ((KScreenW - 15) / 2 + 5) * ((self.myArr.count % 2 == 0 ? self.myArr.count : self.myArr.count + 1) / 2);
    self.collectionView.contentSize = CGSizeMake(rectNew.size.width, newHeight);
    self.collectionViewSizeNew = self.collectionView.contentSize.height;
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
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return self.myArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CrewPhCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    projectList *p = self.myArr[indexPath.row];
    
    
   
    cell.backgroundColor = [UIColor colorWithRed:220/255.0f green:221/255.0f  blue:222/255.0f alpha:1.0];
   // cell.backgroundColor = [UIColor yellowColor];
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
    
//    NSString *str2 = p.pic;
//
//    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:[str1 stringByAppendingString:str2]]];
//
    
    

    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        PhotoViewController *photoVC = [[PhotoViewController alloc]init];
        photoVC.allPhotoArr = self.myArr;
        photoVC.myIndss = indexPath.row;
        
        self.hidesBottomBarWhenPushed = YES;
        
        
        [self.navigationController pushViewController:photoVC animated:YES];
    }
  
    
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
