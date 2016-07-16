//
//  ArtistPhotoCollectionViewController.m
//  LeYingApp
//
//  Created by sks on 16/1/13.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtistPhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoViewController.h"
#import "getArtists.h"

@interface ArtistPhotoCollectionViewController ()
@property (nonatomic,strong)NSArray *Arr;


@end

@implementation ArtistPhotoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f  blue:245/255.0f alpha:1.0f];
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
     getArtists *g = self.photoArr[self.photoIndex];
     self.Arr = [NSArray array];
    self.Arr = g.photos;
    
    
    
    
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return self.Arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.photoImage.backgroundColor = [UIColor whiteColor];
    
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"http://www.leychina.com/static/upload/"];
    NSString *str2 = [self.Arr[indexPath.row] objectForKey:@"path"];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:[str1 stringByAppendingString:str2]]];
    
    UITapGestureRecognizer *PeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction)];
    [cell.photoImage addGestureRecognizer:PeTap];
    cell.photoImage.userInteractionEnabled = YES;
    
    return cell;
}



-(void)imageAction
{
    PhotoViewController *photoVC = [[PhotoViewController alloc]init];
    photoVC.allPhotoArr = self.Arr;
    [self.navigationController pushViewController:photoVC animated:YES];
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
