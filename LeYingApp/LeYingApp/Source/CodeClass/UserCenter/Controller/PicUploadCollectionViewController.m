//
//  PicUploadCollectionViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "PicUploadCollectionViewController.h"
#import "PicUploadCollectionViewCell.h"
#import "QBImagePickerController.h"
#import <AFNetworking.h>
#import "DictToData.h"
#import "UIImageView+WebCache.h"


@interface PicUploadCollectionViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate>

/// 上部分
@property (nonatomic,strong) UIView *topView;

/// 模特卡上传
@property (nonatomic,strong) UIView *modelCardUpload;
@property (nonatomic,strong) UILabel *lblPrompt;
@property (nonatomic,strong) UILabel *lblModelCardUpload;
@property (nonatomic,strong) UIButton *btnModelCardSelect;
@property (nonatomic,strong) UIView *backImgModelCard;
@property (nonatomic,strong) UIImageView *imgModelCardUpload;

/// 代表图上传
@property (nonatomic,strong) UIView *representativePicView;
@property (nonatomic,strong) UILabel *lblRepresentativePic;
@property (nonatomic,strong) UIButton *btnRepresentativeSelect;
@property (nonatomic,strong) UIView *backPic1;
@property (nonatomic,strong) UIImageView *imgPic1;
@property (nonatomic,strong) UIView *backPic2;
@property (nonatomic,strong) UIImageView *imgPic2;
@property (nonatomic,strong) UIView *backPic3;
@property (nonatomic,strong) UIImageView *imgPic3;

/// 更多图片上传
@property (nonatomic,strong) UIView *morePicView;
@property (nonatomic,strong) UILabel *lblMorePic;


@property (nonatomic,weak) UIImageView *currentImgView;

@property (nonatomic,weak) UIImage *imgChongyongModelCardUpload;
@property (nonatomic,weak) UIImage *imgChongyongImgPic1;



// 照片批量上传
@property (nonatomic,strong) NSMutableArray *picCountArr;


@property (nonatomic,strong) NSMutableArray *allPic;

@property (nonatomic,strong) NSData *dataNew;


// 判断成功
@property (nonatomic,assign) BOOL isclickModelBtn;
@property (nonatomic,assign) BOOL isclickPresentBtn;

// 判断添加手势
@property (nonatomic,assign) BOOL isAddTarget;

@property (nonatomic,strong) PicUploadCollectionViewCell *cell;

@property (nonatomic,assign) BOOL isHiddenBtnDelete;


@property (nonatomic,strong) NSMutableArray *imgUrlArray;





@end

@implementation PicUploadCollectionViewController

static NSString * const reuseIdentifier = @"PicUploadCollectionCell";

-(void)loadView
{
    [super loadView];
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.imgUrlArray = [NSMutableArray array];
    self.picCountArr = [NSMutableArray array];
    [self.picCountArr addObject:[UIImage imageNamed:@"xuxian.png"]];
    
    _isclickModelBtn = NO;
    _isclickPresentBtn = NO;
    _isAddTarget = NO;
    _isHiddenBtnDelete = YES;
    
    self.allPic = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self p_reloadDataFromStart];
    
   
    
    // Register cell classes
    [self.collectionView registerClass:[PicUploadCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // 头部视图注册
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"picUploadheadView"];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    
    
    //创建长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(myHandleTableviewCellLongPressed:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [self.collectionView addGestureRecognizer:longPress];
    
    _cell.btnDelete.hidden = YES;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
    
    // Do any additional setup after loading the view.
    
    
}

-(void)leftBarButtonItemAction
{
    // 保存数据
    [self p_deleteImg];
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
}


//长按事件的手势监听实现方法
- (void) myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
    
    // 长按开始
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"UIGestureRecognizerStateBegan");
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
        if (indexPath == nil) {
            NSLog(@"空");
        }else{
            NSLog(@"Section = %ld,Row = %ld",(long)indexPath.section,(long)indexPath.row);
//
            
            if (_isHiddenBtnDelete == YES) {
                // 编辑状态
                self.isHiddenBtnDelete = NO;
                NSLog(@"编辑状态");
            }
            else
            {
                // 完成状态
                self.isHiddenBtnDelete = YES;
                // 数据保存 上传
                NSLog(@"%ld",self.imgUrlArray.count);
                [self p_deleteImg];
            }
            [self.collectionView reloadData];
        }
    }
    
    // 长按改变
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"UIGestureRecognizerStateChanged");
    }
    
    // 长按结束
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
    }
}

-(void)p_deleteImg
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/updateplimg"];
    // 提交数据
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    
    NSMutableString *myArgument = [NSMutableString stringWithFormat:@""];
    for (NSString *sss in _imgUrlArray) {
        if ([myArgument isEqualToString:@""]) {
            myArgument = (NSMutableString *)[NSString stringWithFormat:@"%@",sss];
        }
        else
        {
            myArgument = (NSMutableString *)[myArgument stringByAppendingString:@","];
            myArgument = (NSMutableString *)[myArgument stringByAppendingString:sss];
        }
    }
        // 准备参数
        NSString *argument = [NSString stringWithFormat:@"content=%@",myArgument];
        NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
        //设置URl参数
        [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"error"]);
}




-(void)p_reloadDataFromStart
{
    NSString *urlStr = @"http://leying.hivipplus.com/index.php/Home/member/imglist.html";
    // 提交数据
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
//    // 准备参数
//    NSString *argument = [NSString stringWithFormat:@"content=%@",str];
//    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
//    //设置URl参数
//    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"error"]);
    // 模特卡展示
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        UIImage *imggg = [DictToData getImageWithUrl:[NSString stringWithFormat:@"%@%@",myurl,[[dict objectForKey:@"datas"] objectForKey:@"motecard"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            self.imgModelCardUpload.image = imggg;
            _imgChongyongModelCardUpload = _imgModelCardUpload.image;
        });
    });
    
    
    // 代表图加载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        UIImage *imagee = [DictToData getImageWithUrl:[NSString stringWithFormat:@"%@%@",myurl,[[dict objectForKey:@"datas"] objectForKey:@"avatar"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            self.imgPic1.image = imagee;
            _imgChongyongImgPic1 = _imgPic1.image;
        });
    });
    
    
    // 图片批量加载
    if (![[NSString stringWithFormat:@"%@",[[dict objectForKey:@"datas"] objectForKey:@"otherpic"]] isEqualToString:@"0"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
//            NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"otherpic"]);
//            if (((NSArray *)[[dict objectForKey:@"datas"] objectForKey:@"otherpic"]).count == 1) {
//                NSLog(@"11111111111111");
//            }
            if (![[NSString stringWithFormat:@"%@",[[dict objectForKey:@"datas"] objectForKey:@"otherpic"]] isEqualToString:@"<null>"] || ![[NSString stringWithFormat:@"%@",[[dict objectForKey:@"datas"] objectForKey:@"otherpic"]] isEqualToString:@""]) {
                for (NSString *strUrl in [[dict objectForKey:@"datas"] objectForKey:@"otherpic"]) {
                    UIImage *imageNe = [[UIImage alloc] init];
                    imageNe = [DictToData getImageWithUrl:[NSString stringWithFormat:@"%@%@",myurl,strUrl]];
                    [_imgUrlArray addObject:strUrl];
                    [_picCountArr addObject:imageNe];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [self.collectionView reloadData];
            });
        });
    }
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

/// 保存
-(void)rightBarButtonAction
{
    
    // 图片准备
    // 模特卡图片的添加
    UIImage *imgModelUploadNew = self.imgModelCardUpload.image;
    // 代表图图片的添加
    UIImage *imgPresentUploadNew = self.imgPic1.image;
    // 更多图片的添加
    NSMutableArray *morePicUpload = self.picCountArr;
    [morePicUpload removeObjectAtIndex:0];
    for (UIImage *oneImg in morePicUpload) {
        [self.allPic addObject:oneImg];
    }
    
    // GCD
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    if (imgModelUploadNew != nil) {
        dispatch_group_async(group, queue, ^{
            // 模特卡图片上传
            [DictToData uploadimg:imgModelUploadNew serverUrl:@"http://leying.hivipplus.com/index.php/Home/member/piliangimg.html?type=moteka" success:^(id responseObject) {
                NSLog(@"chenggong1");
            } failure:^(NSError *error) {
                NSLog(@"shibai1");
            }];
        });
    }
    if (imgPresentUploadNew != nil) {
        dispatch_group_async(group, queue, ^{
            // 代表图图片上传
            [DictToData uploadimg:imgPresentUploadNew serverUrl:@"http://leying.hivipplus.com/index.php/Home/member/piliangimg.html?type=daibiaotu" success:^(id responseObject) {
                NSLog(@"chenggong2");
            } failure:^(NSError *error) {
                NSLog(@"shibai2");
            }];
        });
    }
    if (self.allPic.count > 0) {
        dispatch_group_async(group, queue, ^{
            // 批量图片上传
            [DictToData uploadImages:self.allPic parameters:nil success:^(id responseObject) {
                // 成功
                NSLog(@"%@",responseObject);
            } failure:^(NSError *error) {
                // 失败
                NSLog(@"%@",error.localizedDescription);
            }];
        });
    }
    // 回到主函数
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
    });
    
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
 
    
}

/// 加载模特卡事件实现
-(void)btnModelCardSelectAction:(UIButton *)btn
{
    CGRect rect = self.imgModelCardUpload.frame;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    _isclickModelBtn = YES;
    picker.delegate = self;
    picker.allowsEditing = YES;
    self.currentImgView = self.imgModelCardUpload;
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd.png"] forBarMetrics:UIBarMetricsDefault];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

// 调用相机后的代理方法
// 拍摄完成后要执行的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    
    self.currentImgView.image = image;
    
    if (_isclickModelBtn) {
        self.imgChongyongModelCardUpload = image;
        // 上传图片
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 模特卡图片上传
            [DictToData uploadimg:_imgChongyongModelCardUpload serverUrl:[NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/piliangimg.html?type=moteka"] success:^(id responseObject) {
                // 成功
            } failure:^(NSError *error) {
                // 失败
            }];
        });
        _isclickModelBtn = NO;
    }
    
    if (_isclickPresentBtn) {
        self.imgChongyongImgPic1 = image;
        // 上传图片
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 代表图图片上传
            [DictToData uploadimg:_imgChongyongImgPic1 serverUrl:[NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/piliangimg.html?type=daibiaotu"] success:^(id responseObject) {
                // 成功
            } failure:^(NSError *error) {
                // 失败
            }];
        });
        _isclickPresentBtn = NO;
    }
    
    // 模态消失
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// 点击cancel按钮后执行的代理方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



/// 加载代表照片事件实现
-(void)btnRepresentativeSelectAction:(UIButton *)btn
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.title = @"daibiao";
    _isclickPresentBtn = YES;
    picker.delegate = self;
    picker.allowsEditing = YES;
    self.currentImgView = self.imgPic1;
    
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd.png"] forBarMetrics:UIBarMetricsDefault];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
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
    return self.picCountArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 默认情况
    _cell.imgCategory.image = self.picCountArr[indexPath.row];
//    cell.imgCategory.userInteractionEnabled = YES;
//    UIGestureRecognizer *singleTap =           [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
//    [cell.imgCategory addGestureRecognizer:singleTap];
    

    [_cell.btnDelete setImage:[UIImage imageNamed:@"resizeApi.png"] forState:UIControlStateNormal];
    
    [_cell.btnDelete addTarget:self action:@selector(btnDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    _cell.btnDelete.indexPath = indexPath;
    if (_isHiddenBtnDelete) {
        _cell.btnDelete.hidden = YES;
    }
    else
    {
        
        if (indexPath.row == 0) {
            _cell.btnDelete.hidden = YES;
        }
        else
        {
            _cell.btnDelete.hidden = NO;
        }
    }
    
    
    
    if (indexPath.row == 0 && !_isAddTarget) {
        // 添加按钮
        UITapGestureRecognizer *PeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne)];
        _cell.imgCategory.userInteractionEnabled = YES;
        [_cell.imgCategory addGestureRecognizer:PeTap1];
        _cell.btnDelete.hidden = YES;
        _isAddTarget = YES;
    }
    
    
    // Configure the cell
    
    return _cell;
}

-(void)btnDeleteAction:(HMButton *)sender
{
    [self.picCountArr removeObjectAtIndex:sender.indexPath.row];
    [self.imgUrlArray removeObjectAtIndex:sender.indexPath.row - 1];
    [self.collectionView reloadData];
}

// 点击进入相册选择图片
-(void)imageActionOne
{
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.limitsMinimumNumberOfSelection = YES;
//    imagePickerController.minimumNumberOfSelection = 6;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:navigationController animated:YES completion:NULL];


}

#pragma mark - QBImagePickerControllerDelegate

- (void)imgPickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    
    if(imagePickerController.allowsMultipleSelection)
    {
        NSArray *mediaInfoArray = (NSArray *)info;
        
//        UIImage *stri = [mediaInfoArray[0] objectForKey:@"UIImagePickerControllerOriginalImage"];
//        [self.picCountArr addObject:stri];
        
        
        for (int i = 0; i < mediaInfoArray.count; i++) {
            [self.picCountArr addObject:[mediaInfoArray[i] objectForKey:@"UIImagePickerControllerOriginalImage"]];
        }
        [self.collectionView reloadData];
        
//        NSLog(@"Selected %lu photos", (unsigned long)mediaInfoArray.count);
    } else {
        NSDictionary *mediaInfo = (NSDictionary *)info;
        NSLog(@"Selected: %@", mediaInfo);
    }
    
    // 图片上传
    if (self.picCountArr.count > 1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 处理选择的图片数组
            for (int j = 0; j < _picCountArr.count; j++) {
                [self.allPic addObject:_picCountArr[j]];
            }
            [_allPic removeObjectAtIndex:0];
            // 图片批量上传
            if (self.allPic.count > 0) {
                [DictToData uploadImages:self.allPic parameters:nil success:^(id responseObject) {
                    // 成功
                    //                NSLog(@"%@",responseObject);
                    NSLog(@"成功");
                } failure:^(NSError *error) {
                    // 失败
                    //                NSLog(@"%@",error.localizedDescription);
                    NSLog(@"失败%@",error);
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新界面
                    [self.collectionView reloadData];
                });
            }
        });
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imgPickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"Cancelled");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"请选择图片";
}

//- (NSString *)descriptionForDeselectingAllAssets:(QBImagePickerController *)imagePickerController
//{
//    return @"すべての写真の選択を解除";
//}

//- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
//{
//    return [NSString stringWithFormat:@"写真%lu枚", (unsigned long)numberOfPhotos];
//}

//- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
//{
//    return [NSString stringWithFormat:@"ビデオ%lu本", (unsigned long)numberOfVideos];
//}

//- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
//{
//    return [NSString stringWithFormat:@"写真%lu枚、ビデオ%lu本", (unsigned long)numberOfPhotos, (unsigned long)numberOfVideos];
//}


// 界面头部设置
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"picUploadheadView" forIndexPath:indexPath];
    headView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    
    //    /// 上部分
    /// 三张图片的宽高
    CGFloat threePicWH = (CGRectGetWidth([[UIScreen mainScreen] bounds]) - 6 - 8) / 3;
    //    @property (nonatomic,strong) UIView *topView;
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 217 + 55 + 39 + 43 + 6 + threePicWH + 30)];
    self.topView.backgroundColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
    
    
    //
    //    /// 模特卡上传
    //    @property (nonatomic,strong) UIView *modelCardUpload;
    self.modelCardUpload = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.topView.frame), 65)];
    self.modelCardUpload.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [self.topView addSubview:_modelCardUpload];
    
    //    @property (nonatomic,strong) UILabel *lblPrompt;
    self.lblPrompt = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.modelCardUpload.frame), 20)];
    self.lblPrompt.font = [UIFont systemFontOfSize:13];
    self.lblPrompt.text = @"提示：非本人照片将会禁号";
    self.lblPrompt.textColor = [UIColor colorWithRed:119 / 255.0 green:127 / 255.0 blue:127 / 255.0 alpha:1];
    [self.modelCardUpload addSubview:_lblPrompt];
    
    //    @property (nonatomic,strong) UILabel *lblModelCardUpload;
    self.lblModelCardUpload = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblPrompt.frame), CGRectGetMaxY(self.lblPrompt.frame), CGRectGetWidth(self.modelCardUpload.frame) - 85, 45)];
    self.lblModelCardUpload.textColor = [UIColor colorWithRed:82 / 255.0 green:95 / 255.0 blue:98 / 255.0 alpha:1];
    self.lblModelCardUpload.text = @"展示卡上传";
    self.lblModelCardUpload.font = [UIFont systemFontOfSize:16];
    [self.modelCardUpload addSubview:_lblModelCardUpload];
    
    //    @property (nonatomic,strong) UIButton *btnModelCardSelect;
    self.btnModelCardSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnModelCardSelect.frame = CGRectMake(CGRectGetWidth(self.modelCardUpload.frame) - 85, CGRectGetMinY(self.lblModelCardUpload.frame) + 5, 80, CGRectGetHeight(self.lblModelCardUpload.frame) - 10);
    self.btnModelCardSelect.backgroundColor = [UIColor colorWithRed:144 / 255.0 green:159 / 255.0 blue:164 / 255.0 alpha:1];
    [self.btnModelCardSelect setBackgroundImage:[UIImage imageNamed:@"butter.jpg"] forState:UIControlStateNormal];
    [self.btnModelCardSelect addTarget:self action:@selector(btnModelCardSelectAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.btnModelCardSelect setTitle:@"...." forState:UIControlStateNormal];
//    self.btnModelCardSelect.tintColor = [UIColor colorWithRed:104 / 255.0 green:120 / 255.0 blue:127 / 255.0 alpha:1];
    [self.modelCardUpload addSubview:_btnModelCardSelect];
    
    //    @property (nonatomic,strong) UIView *backImgModelCard;
    self.backImgModelCard = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.modelCardUpload.frame) + 3, CGRectGetMaxY(self.modelCardUpload.frame) + 3, CGRectGetWidth(self.modelCardUpload.frame) - 6, 214)];
    self.backImgModelCard.backgroundColor = [UIColor colorWithRed:186 / 255.0 green:191 / 255.0 blue:196 / 255.0 alpha:1];
    [self.topView addSubview:_backImgModelCard];
    //    @property (nonatomic,strong) UIImageView *imgModelCardUpload;
    self.imgModelCardUpload = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.backImgModelCard.frame) + 2, CGRectGetMinY(self.backImgModelCard.frame) + 2, CGRectGetWidth(self.backImgModelCard.frame) - 4, 210)];
    if (self.imgChongyongModelCardUpload) {
        self.imgModelCardUpload.image = self.imgChongyongModelCardUpload;
    }
    else
    {
        self.imgModelCardUpload.image = [UIImage imageNamed:@"yiren1"];
    }
    [self.topView addSubview:_imgModelCardUpload];
    //
    //    /// 代表图上传
    //    @property (nonatomic,strong) UIView *representativePicView;
    self.representativePicView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.modelCardUpload.frame), CGRectGetMaxY(self.backImgModelCard.frame) + 4, CGRectGetWidth(self.modelCardUpload.frame), CGRectGetHeight(self.modelCardUpload.frame) - 20)];
    self.representativePicView.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [self.topView addSubview:_representativePicView];
    //    @property (nonatomic,strong) UILabel *lblRepresentativePic;
    self.lblRepresentativePic = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblModelCardUpload.frame), CGRectGetMinY(self.representativePicView.frame), CGRectGetWidth(self.lblModelCardUpload.frame), CGRectGetHeight(self.lblModelCardUpload.frame))];
    self.lblRepresentativePic.textColor = [UIColor colorWithRed:82 / 255.0 green:95 / 255.0 blue:98 / 255.0 alpha:1];
    self.lblRepresentativePic.text = @"代表图上传";
    self.lblRepresentativePic.font = [UIFont systemFontOfSize:16];
    [self.topView addSubview:_lblRepresentativePic];
    
    //    @property (nonatomic,strong) UIButton *btnRepresentativeSelect;
    self.btnRepresentativeSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnRepresentativeSelect.frame = CGRectMake(CGRectGetMinX(self.btnModelCardSelect.frame), CGRectGetMinY(self.lblRepresentativePic.frame) + 5, CGRectGetWidth(self.btnModelCardSelect.frame), CGRectGetHeight(self.btnModelCardSelect.frame));
    self.btnRepresentativeSelect.backgroundColor = [UIColor colorWithRed:144 / 255.0 green:159 / 255.0 blue:164 / 255.0 alpha:1];
//    [self.btnRepresentativeSelect setBackgroundImage:[UIImage imageNamed:@"butter"] forState:UIControlStateNormal];
    [_btnRepresentativeSelect setImage:[UIImage imageNamed:@"butter.jpg"] forState:UIControlStateNormal];
    [self.btnRepresentativeSelect addTarget:self action:@selector(btnRepresentativeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.btnRepresentativeSelect setTitle:@"...." forState:UIControlStateNormal];
//    self.btnRepresentativeSelect.tintColor = [UIColor colorWithRed:104 / 255.0 green:120 / 255.0 blue:127 / 255.0 alpha:1];
    [self.topView addSubview:_btnRepresentativeSelect];
    
    //    @property (nonatomic,strong) UIView *backPic1;
    self.backPic1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.representativePicView.frame) + 3, CGRectGetMaxY(self.representativePicView.frame) + 6, threePicWH, threePicWH)];
    self.backPic1.backgroundColor = [UIColor colorWithRed:179 / 255.0 green:184 / 255.0 blue:189 / 255.0 alpha:1];
    [self.topView addSubview:_backPic1];
    
    //    @property (nonatomic,strong) UIImageView *imgPic1;
    self.imgPic1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.backPic1.frame) + 2, CGRectGetMinY(self.backPic1.frame) + 2, CGRectGetWidth(self.backPic1.frame) - 4, CGRectGetHeight(self.backPic1.frame) - 4)];
    if (self.imgChongyongImgPic1) {
        self.imgPic1.image = self.imgChongyongImgPic1;
    }
    else
    {
        self.imgPic1.image = [UIImage imageNamed:@"yiren2"];
    }
    [self.topView addSubview:_imgPic1];
    
    //    @property (nonatomic,strong) UIView *backPic2;
    self.backPic2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.backPic1.frame) + 4, CGRectGetMinY(self.backPic1.frame), CGRectGetWidth(self.backPic1.frame), CGRectGetHeight(self.backPic1.frame))];
    self.backPic2.backgroundColor = [UIColor colorWithRed:179 / 255.0 green:184 / 255.0 blue:189 / 255.0 alpha:1];
    [self.topView addSubview:_backPic2];
    
    //    @property (nonatomic,strong) UIImageView *imgPic2;
    self.imgPic2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.backPic2.frame) + 2, CGRectGetMinY(self.backPic2.frame) + 2, CGRectGetWidth(self.imgPic1.frame), CGRectGetHeight(self.imgPic1.frame))];
    self.imgPic2.image = [UIImage imageNamed:@"yiren3"];
    [self.topView addSubview:_imgPic2];
    
    //    @property (nonatomic,strong) UIView *backPic3;
    self.backPic3 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.backPic2.frame) + 4, CGRectGetMinY(self.backPic2.frame), CGRectGetWidth(self.backPic2.frame), CGRectGetHeight(self.backPic2.frame))];
    self.backPic3.backgroundColor = [UIColor colorWithRed:179 / 255.0 green:184 / 255.0 blue:189 / 255.0 alpha:1];
    [self.topView addSubview:_backPic3];
    
    //    @property (nonatomic,strong) UIImageView *imgPic3;
    self.imgPic3 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.backPic3.frame) + 2, CGRectGetMinY(self.imgPic2.frame), CGRectGetWidth(self.imgPic2.frame), CGRectGetHeight(self.imgPic2.frame))];
    self.imgPic3.image = [UIImage imageNamed:@"yiren3"];
    [self.topView addSubview:_imgPic3];
    
    //
    //    /// 更多图片上传
    //    @property (nonatomic,strong) UIView *morePicView;
    self.morePicView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.modelCardUpload.frame), CGRectGetMaxY(self.backPic3.frame) + 8, CGRectGetWidth(self.modelCardUpload.frame), CGRectGetHeight(self.representativePicView.frame))];
    self.morePicView.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [self.topView addSubview:_morePicView];
    
    //    @property (nonatomic,strong) UILabel *lblMorePic;
    self.lblMorePic = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.lblRepresentativePic.frame), CGRectGetMinY(self.morePicView.frame), CGRectGetWidth(self.lblRepresentativePic.frame), CGRectGetHeight(self.lblRepresentativePic.frame))];
    self.lblMorePic.textColor = [UIColor colorWithRed:82 / 255.0 green:95 / 255.0 blue:98 / 255.0 alpha:1];
    self.lblMorePic.text = @"更多图片上传(长按进行编辑)";
    self.lblMorePic.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:_lblMorePic];
    
    
    
    [headView addSubview:_topView];
    
    
    return headView;
}

#pragma mark 编辑按钮事件
-(void)btnEditAction:(UIButton *)sender
{
    self.isHiddenBtnDelete = YES;
    sender.hidden = YES;
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
