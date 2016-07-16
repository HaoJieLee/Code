//
//  PicUploadCollectionViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "HeadImageViewControllerView.h"
#import "PicUploadNewCollectionViewCell.h"
#import "QBImagePickerController.h"
#import <AFNetworking.h>
#import "DictToData.h"
#import "UIImageView+WebCache.h"
#import "UsersTableViewController.h"
#import "getDataHand.h"
#import "QiniuSDK.h"


@interface HeadImageViewControllerView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate,UIAlertViewDelegate>

/// 上部分
@property (nonatomic,strong) UIView *topView;

/// 模特卡上传
@property (nonatomic,strong) UIView *modelCardUpload;
@property (nonatomic,strong) UILabel *lblPrompt;
@property (nonatomic,strong) UILabel *lblModelCardUpload;
@property (nonatomic,strong) UIButton *btnModelCardSelect;
@property (nonatomic,strong) UIView *backImgModelCard;
@property (nonatomic,strong) UIImageView *imgModelCardUpload;//模特卡

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


@property (nonatomic,copy)NSString *imageURL;//模卡地址
@property (nonatomic,strong) NSMutableArray *picCountArr;//图片数组
@property (nonatomic,strong)NSMutableArray *videoArray;//视频数组
@property (nonatomic,strong) NSMutableArray *imgUrlArray;//从网络获取的图片数组

// 照片批量上传

@property (nonatomic,strong) NSMutableArray *allPic;
@property (nonatomic,strong) NSData *dataNew;


// 判断成功
@property (nonatomic,assign) BOOL isclickModelBtn;
@property (nonatomic,assign) BOOL isclickPresentBtn;

// 判断添加手势
@property (nonatomic,assign) BOOL isAddTarget;
@property (nonatomic,strong) PicUploadNewCollectionViewCell *cell;
@property (nonatomic,assign) BOOL isHiddenBtnDelete;


@property (nonatomic,strong)UITextField *descriptionText;
// 新版本
@property (nonatomic,strong) UIImageView *imgXiaoxierensheng;//大写你的人生图片

@property (nonatomic,strong) UIImageView *imgDaxierensheng;


@end

@implementation HeadImageViewControllerView

static NSString * const reuseIdentifier = @"PicUploadNewCollectionCell";
static NSString * const reuseIdentifierCell = @"PicUploadAddCollectionCell";

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
-(void)addAllArray{
    self.imgUrlArray = [NSMutableArray array];
    self.picCountArr = [NSMutableArray array];
    [self.picCountArr addObject:[UIImage imageNamed:@"xuxian.png"]];
    
    _isclickModelBtn = NO;
    _isclickPresentBtn = NO;
    _isAddTarget = NO;
    _isHiddenBtnDelete = YES;
    
    self.allPic = [NSMutableArray array];
    self.collectionView.scrollEnabled = NO;
}
-(void)setCollectionViewHead{
    [self.collectionView registerClass:[PicUploadNewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[PicUploadNewCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifierCell];
    
    
    // 头部视图注册
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"picUploadheadView"];
    self.collectionView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllArray];
    [self setCollectionViewHead];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 耗时的操作
        [self p_reloadDataFromStart];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [self.collectionView reloadData];
        });
    });
    
    // 获取新的内容高度
    [self getNewHeightForCollectionContent];
    
    //创建长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                               action:@selector(myHandleTableviewCellLongPressed:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [self.collectionView addGestureRecognizer:longPress];
    
    _cell.btnDelete.hidden = YES;
        
}

-(void)leftBarButtonItemAction
{
    // 保存数据
//    [self p_deleteImg];
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
}

//长按事件的手势监听实现方法
- (void) myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
    
    // 长按开始
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
      
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



-(void)p_reloadDataFromStart
{
    [self.imgUrlArray addObjectsFromArray:[[getDataHand shareHandLineData]getUsersAllPhotosWithUserId:[loginModel grobleLoginModel].userId]];
    
    // 模特卡展示
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            if (!self.mokaImageString) {
                // 没有值
                _imgDaxierensheng.hidden = NO;
            }
            else
            {// 获取到值
                [self.imgModelCardUpload sd_setImageWithURL:[NSURL URLWithString:self.mokaImageString]];
                _imgChongyongModelCardUpload = _imgModelCardUpload.image;
                _imgDaxierensheng.hidden = YES;
                [_imgDaxierensheng removeFromSuperview];
            }
            [self.picCountArr removeAllObjects];
            for (NSDictionary *dic in self.imgUrlArray) {
                NSURL *url = [NSURL URLWithString:[dic objectForKey:@"url"]];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData: imageData];
                [self.picCountArr addObject:image];
            }
            // 更新界面
            [self.collectionView reloadData];
        });
    });
   
}

/// 获取内容高度
-(void)getNewHeightForCollectionContent
{
    //设置collectview的高度
    CGRect rectNew = self.collectionView.frame;
    CGFloat newHeight;
    NSLog(@"_picCountArr:%@",[NSString stringWithFormat:@"%@",_picCountArr]);
//    if (![[NSString stringWithFormat:@"%@",_picCountArr] isEqualToString:@"<null>"]) {
    
//    }
    if (_picCountArr.count > 4) {
        newHeight = (KScreenW / 2 - 10 + 6) * ((_picCountArr.count % 2 == 0 ? _picCountArr.count : _picCountArr.count + 1) / 2);
    }
    else
    {
        newHeight = (KScreenW / 2 - 10 + 6) * (_picCountArr.count) + 160;
    }
    NSLog(@"newHeight:%f",newHeight);
    self.collectionView.contentSize = CGSizeMake(rectNew.size.width, newHeight);
    self.collectionViewSizeNew = self.collectionView.contentSize;
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

/// 加载模特卡事件实现
-(void)btnModelCardSelectAction:(UIButton *)btn
{

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
    self.imgChongyongModelCardUpload=image;
    //获取上传图片的Token
    NSString *Token = [[getDataHand shareHandLineData]stringPutPicture];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
        params:nil checkCrc:NO cancellationSignal:nil];
   
    NSString *string = [Factory randomlyString];
    NSString *timeString = [Factory TimeToDataString];
    NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
       self.currentImgView.image = image;
    
    if (_isclickModelBtn) {
        self.imgChongyongModelCardUpload = image;
        // 上传图片
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 模特卡图片上传
            [upManager putFile:[self getImagePath:self.imgChongyongModelCardUpload] key:@"moka" token:Token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                if ([resp objectForKey:@"state"]) {
                    NSString *url = [NSString stringWithFormat:@"moka=%@%@",QI_NIU,[resp objectForKey:@"url"]];
                    NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Key:url];
                    if ([[dic objectForKey:@"message"] isEqualToString:@"保存成功"]) {
//                        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"模特卡%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                        [alView show];
                    }
                }
            } option:uploadOption];
            
            
        });
        _isclickModelBtn = NO;
    }
    // 模态消失
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/**添加相片描述*/
-(void)addImageDescription{
    UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"描述" message:@"请填写相册描述" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"添加",nil];
    
    alerView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    alerView.delegate = self;
    
    self.descriptionText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    
    self.descriptionText.tag = 1001;
    
    [alerView addSubview:self.descriptionText];
    
    [alerView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSLog(@"%@",self.descriptionText.text);
    }
}

/**照片获取本地路径转换*/
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 0.01);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
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



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return _picCountArr.count+1;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (_picCountArr.count > 4) {
        // 图片个数大于4
        
        if (indexPath.row == _picCountArr.count) {
            // 添加图片显示
            PicUploadNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierCell forIndexPath:indexPath];
            cell.imgCategory.image = [UIImage imageNamed:@"xuxian.png"];
            // 添加点击事件
            // 添加按钮
            UITapGestureRecognizer *PeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne)];
            cell.imgCategory.userInteractionEnabled = YES;
            [cell.imgCategory addGestureRecognizer:PeTap1];
            cell.btnDelete.hidden = YES;
            _isAddTarget = YES;
            
            return cell;
        }
        else
        {
            _cell.imgCategory.image = self.picCountArr[indexPath.row];
        }
    }
    else
    {

        if (indexPath.row == _picCountArr.count) {
            // 添加图片显示
            PicUploadNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierCell forIndexPath:indexPath];
            cell.imgCategory.image = [UIImage imageNamed:@"xuxian.png"];
            // 添加点击事件
            // 添加按钮
            UITapGestureRecognizer *PeTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageActionOne)];
            cell.imgCategory.userInteractionEnabled = YES;
            [cell.imgCategory addGestureRecognizer:PeTap1];
            cell.btnDelete.hidden = YES;
            _isAddTarget = YES;
            
            return cell;
        }
        else
        {
            if (indexPath.row < (_picCountArr.count)) {
                NSLog(@"%@",self.picCountArr[indexPath.row]);
                _cell.imgCategory.image = self.picCountArr[indexPath.row];


            }
        }
    }

    // 删除按钮
    [_cell.btnDelete setImage:[UIImage imageNamed:@"resizeApi.png"] forState:UIControlStateNormal];
    
    [_cell.btnDelete addTarget:self action:@selector(btnDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    _cell.btnDelete.indexPath = indexPath;
    if (_isHiddenBtnDelete) {
        _cell.btnDelete.hidden = YES;
    }
    else
    {
        if (indexPath.row < _picCountArr.count ) {
            _cell.btnDelete.hidden = NO;
        }
        else
        {
            _cell.btnDelete.hidden = YES;
        }
        }
    
    return _cell;
}

-(BOOL)isLastObject:(UIImage *)lastObject WithMutableArray:(NSMutableArray *)arr
{
    if ([arr lastObject] == lastObject) {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)btnDeleteAction:(HMButton *)sender
{
    if (sender.indexPath.row < _picCountArr.count) {
        [self.picCountArr removeObjectAtIndex:sender.indexPath.row];
       NSString *imagIdString = [[self.imgUrlArray objectAtIndex:sender.indexPath.row] objectForKey:@"id"];
       
        NSString *string = [Factory randomlyString];
        NSString *timeString = [Factory TimeToDataString];
        NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
        NSString *dic =[[getDataHand shareHandLineData]DeletePhotosDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string ImgId:imagIdString];
        if ([dic isEqualToString:@"删除成功"]) {
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:dic  delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alView show];
        }

    }
    
    [self.collectionView reloadData];
}

// 点击进入相册选择图片
-(void)imageActionOne
{
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.limitsMinimumNumberOfSelection = YES;

    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:navigationController animated:YES completion:NULL];


}

#pragma mark - QBImagePickerControllerDelegate

- (void)imgPickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
//    [_picCountArr removeLastObject];
    if(imagePickerController.allowsMultipleSelection)
    {
        NSArray *mediaInfoArray = (NSArray *)info;
        for (int i = 0; i < mediaInfoArray.count; i++)
        {
            [self.picCountArr addObject:[mediaInfoArray[i] objectForKey:@"UIImagePickerControllerOriginalImage"]];
            [self addPhotosWithImage:[mediaInfoArray[i] objectForKey:@"UIImagePickerControllerOriginalImage"]];
        }
        [self.collectionView reloadData];
            }
    else {
//        NSDictionary *mediaInfo = (NSDictionary *)info;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)addPhotosWithImage:(UIImage *)image{
    NSString *Token = [[getDataHand shareHandLineData]stringPutPicture];
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }params:nil checkCrc:NO cancellationSignal:nil];
    
    NSString *string = [Factory randomlyString];
    NSString *timeString = [Factory TimeToDataString];
    NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 上传图片到图库
        [upManager putFile:[self getImagePath:image] key:@"imageUrl" token:Token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if ([resp objectForKey:@"state"]) {
                NSString *url = [NSString stringWithFormat:@"%@%@",QI_NIU,[resp objectForKey:@"url"]];
                NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersPhotosDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string ImgUrl:url imgDescription:@"不错"];
                if ([[dic objectForKey:@"message"] isEqualToString:@"保存成功"]) {
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alView show];
                }
            }
        } option:uploadOption];
    });

}
- (void)imgPickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"请选择图片";
}


// 界面头部设置
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"picUploadheadView" forIndexPath:indexPath];
    headView.backgroundColor = [UIColor redColor];
    
    //    /// 上部分
    /// 三张图片的宽高
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 217 )];
    self.topView.backgroundColor = [UIColor redColor];
    
    
    
        /// 模特卡上传
//        @property (nonatomic,strong) UIView *modelCardUpload;
    self.modelCardUpload = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.topView.frame), 65)];
    self.modelCardUpload.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [self.topView addSubview:_modelCardUpload];
    
    // 小写人生图片添加
    _imgXiaoxierensheng = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaoxierensheng.jpg"]];
    _imgXiaoxierensheng.frame = CGRectMake(0, 0, CGRectGetWidth(_modelCardUpload.frame), CGRectGetHeight(_modelCardUpload.frame));
    [_modelCardUpload addSubview:_imgXiaoxierensheng];
    
    
    self.backImgModelCard = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.modelCardUpload.frame) + 3, CGRectGetMaxY(self.modelCardUpload.frame) + 3, CGRectGetWidth(self.modelCardUpload.frame) - 6, 214)];
    self.backImgModelCard.backgroundColor = [UIColor colorWithRed:186 / 255.0 green:191 / 255.0 blue:196 / 255.0 alpha:1];
    [self.topView addSubview:_backImgModelCard];
    //    @property (nonatomic,strong) UIImageView *imgModelCardUpload;
    //模特卡
    self.imgModelCardUpload = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.backImgModelCard.frame) + 2, CGRectGetMinY(self.backImgModelCard.frame) + 2, CGRectGetWidth(self.backImgModelCard.frame) - 4, 210)];
    [self.imgModelCardUpload sd_setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:[UIImage imageNamed:@"yiren1"]];
    
        [self.topView addSubview:_imgModelCardUpload];
    _imgModelCardUpload.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTapModelCardUpload = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnModelCardSelectAction:)];
    [_imgModelCardUpload addGestureRecognizer:singleTapModelCardUpload];
    
    
    
    //
    //    模特卡图下面的空白
    self.representativePicView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.modelCardUpload.frame), CGRectGetMaxY(self.backImgModelCard.frame) + 4, CGRectGetWidth(self.modelCardUpload.frame), CGRectGetHeight(self.modelCardUpload.frame) - 20)];
    self.representativePicView.layer.contents = (id)[UIImage imageNamed:@"111"].CGImage;
    [self.topView addSubview:_representativePicView];
    
    
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




@end
