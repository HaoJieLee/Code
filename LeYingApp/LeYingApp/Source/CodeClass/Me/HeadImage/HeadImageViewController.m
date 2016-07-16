//
//  HeadImageViewController.m
//  YHXZ
//
//  Created by xiaoheibi on 16/6/27.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import "HeadImageViewController.h"
#import "TopView.h"
#import "PicUploadNewCollectionViewController.h"
#import "SubDataTableViewController.h"
#import "MakeShowViewController.h"
#import "QiniuSDK.h"


@interface HeadImageViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView; //最下层滑动视图
@property (nonatomic, strong) TopView * topView;//上面头像视图
@property (nonatomic, strong) UIScrollView *subScrollView; //下面滑动视图
@property (nonatomic, strong) PicUploadNewCollectionViewController *picVC;//图片布局View
@property (nonatomic, strong) SubDataTableViewController *subDataTable;//资料布局View

@property (nonatomic) CGRect switchFrame; //切换按钮的坐标
@property (nonatomic) float topH;//上面头像视图的高度
@property (nonatomic, strong) UILabel *showView;//切换按钮,图片
@property (nonatomic, strong) UILabel *dataView;//切换按钮,资料
@property (nonatomic) NSUInteger tempTag;//切换按钮临时Tag;
@property (nonatomic, strong) UIView *animationView;//切换按钮动画View

@end

@implementation HeadImageViewController

//设置坐标
- (void)setFrameData {
    self.topH = (490*[UIScreen mainScreen].bounds.size.width)/1080;
    self.switchFrame = CGRectMake(0, self.topH, [UIScreen mainScreen].bounds.size.width, 55);//Temp/-------!!! Change
    //'showView' And 'dataView'-- Frame Change, Define Long;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrameData];//调用 设置坐标方法
    [self initScrollViewWithMain]; //调用初始化 主ScrollView
    [self TopView];//调用创建顶部视图
    [self initViewWithShowAndData];//创建中部 切换按钮
    [self initScrollViewWtihSub]; // 创建底部视图
    
    //暂时添加
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 90, 40)];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"制作模卡" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:btn];
}

//
- (void)pushVCAction{
    
    MakeShowViewController *vc = [MakeShowViewController new];
    [self.navigationController  pushViewController:vc animated:YES];
}

#pragma make --- Main View Setting
//设置主滑动视图
- (void)initScrollViewWithMain {
    CGSize mainContentSize = CGSizeMake(0, self.view.frame.size.height + _switchFrame.origin.y - _switchFrame.size.height);
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _mainScrollView.delegate = self;
    _mainScrollView.contentSize = mainContentSize;//添加自定义Size
    [self.view addSubview:_mainScrollView];
}
//设置头像视图
- (void)TopView {
    self.topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _topH)];
    [_mainScrollView addSubview:_topView];
    //添加手势
    UITapGestureRecognizer *topViewTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction)];
    [_topView.headImage addGestureRecognizer:topViewTap];
    
    _topView.backgroundColor = [UIColor redColor];
}
#pragma mark ---Init Show And Data View
//创建切换按钮 "展示","资料"
- (void)initViewWithShowAndData {
    CGSize switchSize = self.switchFrame.size;
//    创建控件展示
    self.showView = [UILabel new];
    _showView.userInteractionEnabled = YES;
    [_showView setBackgroundColor:[UIColor whiteColor]];
    _showView.frame = CGRectMake(0, self.switchFrame.origin.y, switchSize.width/2, switchSize.height);
    _showView.text = @"展示";
    _showView.textAlignment = NSTextAlignmentCenter;
    _showView.textColor = [UIColor redColor];
    [_mainScrollView addSubview:_showView];
    
//    创建控件资料
    self.dataView = [UILabel new];
    _dataView.userInteractionEnabled = YES;
    [_dataView setBackgroundColor:[UIColor whiteColor]];
    _dataView.frame = CGRectMake(switchSize.width/2, self.switchFrame.origin.y, switchSize.width/2, switchSize.height);
    _dataView.text = @"资料";
    _dataView.textAlignment = NSTextAlignmentCenter;
    _dataView.textColor = [UIColor blackColor];
    [_mainScrollView addSubview:_dataView];
    
//    创建动画View
    CGRect animationViewFrame = CGRectMake(0, self.switchFrame.origin.y + switchSize.height - 5, switchSize.width/2, 5);
    self.animationView = [[UIView alloc] initWithFrame:animationViewFrame];
    _animationView.backgroundColor = [UIColor redColor];
    [_mainScrollView addSubview:_animationView];
    
    _showView.tag = 0;
    _dataView.tag = 1;
    
//    展示,资料 添加手势
    UITapGestureRecognizer *showViewTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showViewClick)];
    [_showView addGestureRecognizer:showViewTap];
    UITapGestureRecognizer *dataViewTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dataViewClick)];
    [_dataView addGestureRecognizer:dataViewTap];
}
//展示按钮绑定手势方法
- (void)showViewClick {
    _showView.textColor = [UIColor redColor];
    _dataView.textColor = [UIColor blackColor];
    [self switchView:_showView.tag];//跳转切换按钮事件
}
//资料按钮绑定手势方法
- (void)dataViewClick {
    _showView.textColor = [UIColor blackColor];
    _dataView.textColor = [UIColor redColor];
    [self switchView:_dataView.tag];//跳转切换按钮事件

}
//切换按钮事件
- (void)switchView:(NSUInteger)tag {
    
    CGRect newFrame = CGRectMake(_animationView.frame.size.width * tag, _animationView.frame.origin.y, _animationView.frame.size.width, _animationView.frame.size.height);//Change --Long
    //动画View 切换时动画
    [UIView animateWithDuration:0.32 animations:^{
        _animationView.frame = newFrame;
    }];
    
    //点击时 底部 ScrollView 切换动画
    [UIView animateWithDuration:0.32 animations:^{
        _subScrollView.contentOffset = CGPointMake(self.view.frame.size.width * tag, 0);
    }];

}

#pragma make --- _subScrollView View Setting

//下方滑动视图初始化
- (void)initScrollViewWtihSub {
    
    float subY = self.switchFrame.origin.y + self.switchFrame.size.height;
    CGRect subFrame = CGRectMake(0, subY, self.switchFrame.size.width, [UIScreen mainScreen].bounds.size.height - self.switchFrame.size.height- 100);//Frame Change------Define long;
    
    self.subScrollView = [[UIScrollView alloc] initWithFrame:subFrame];
    _subScrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    _subScrollView.bounces = NO;
    _subScrollView.delegate = self;
    _subScrollView.alwaysBounceVertical = YES;
    _subScrollView.alwaysBounceHorizontal = YES;
    _subScrollView.pagingEnabled = YES;
    [_mainScrollView addSubview:_subScrollView];

    [self addShowCollectionView];//调用初始化  展示
    [self addDataTableView];//调用初始化  资料
    [self addLableViewWithTag:0];
    [self addLableViewWithTag:1];//最下方 "影红小镇";
    _subScrollView.backgroundColor = [UIColor greenColor];
}

//添加 展示  视图(移植来的)
- (void)addShowCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame) / 2 - 10, 158);
    flowLayout.minimumInteritemSpacing = 3;
    // 上下间距
    flowLayout.minimumLineSpacing = 6;
    flowLayout.headerReferenceSize = CGSizeMake(0, 330);
    // 设置整体四周边距  上、左、下、右
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 15, 5);
    self.picVC = [[PicUploadNewCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    self.picVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 108  + 500 + 100000);
    [self addChildViewController:_picVC];
    [_subScrollView addSubview:_picVC.collectionView];
    CGRect showFrame = CGRectMake(0, 0, self.switchFrame.size.width, - _dataView.frame.size.height);
    _picVC.view.frame = showFrame;
    
}

//添加  资料 视图
- (void)addDataTableView {
    CGRect dataFrame = CGRectMake(self.switchFrame.size.width, 0, self.switchFrame.size.width, _subScrollView.frame.size.height);
    self.subDataTable = [[SubDataTableViewController alloc]initWithFrame:dataFrame];
    _subDataTable.superOffsetY = _mainScrollView.contentOffset.y;
    _subDataTable.dataSourceTitle = [self tableViewDataSourceTitleInit];//添加tableView Cell 标题数组/   不用刷新表;

    //初始化后添加到容器,然后  资料 页面添加.
    [self addChildViewController:_subDataTable];
    [_subScrollView addSubview:_subDataTable.dataTableView];
    
    
}

- (void)addLableViewWithTag:(NSUInteger)tag {
    CGFloat SW = [UIScreen mainScreen].bounds.size.width;
    CGFloat w = 100;
    CGFloat h = 50;
    CGFloat bh = 100;
    CGFloat showB = _picVC.collectionView.frame.size.height + bh;
    CGFloat dataB = _subDataTable.dataTableView.frame.size.height + bh;
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake((SW-w)/2,tag==0?showB:dataB, w, h);
    label.text = @"影红小镇";
    label.backgroundColor = [UIColor redColor];
    [_subScrollView addSubview:label];
    
}
//设置资料视图的数据源 标题;
- (NSMutableArray * )tableViewDataSourceTitleInit {
    NSArray *section_0 = @[@"昵称",@"影红号",@"性别",@"类型",@"标签",@"设备"];
    NSArray *section_1 = @[@"身份认证"];
    NSArray *section_2 = @[@"手机号码",@"微信号",@"QQ",@"邮箱"];
    NSArray *section_3 = @[@"签名",@"简介"];
    return [NSMutableArray arrayWithArray:@[section_0,section_1,section_2,section_3]];
}

#pragma mark ---ScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat mainOffsetY = _mainScrollView.contentOffset.y;
    if (mainOffsetY > _topH - _switchFrame.size.height) {
        _mainScrollView.contentOffset = CGPointMake(0, _topH - _switchFrame.size.height);
        _subDataTable.dataTableView.scrollEnabled =YES; //设置tableview 不能滚动

    }
    if(mainOffsetY == _topH - _switchFrame.size.height) {
        _subDataTable.dataTableView.scrollEnabled =YES; //设置tableview 不能滚动
    }else {
        _subDataTable.dataTableView.scrollEnabled =NO; //设置tableview 不能滚动
    }
    
    
    //setting _subScrollView offset ,change switch
    CGFloat SW = [UIScreen mainScreen].bounds.size.width;
    NSUInteger sx = _subScrollView.contentOffset.x;
    NSUInteger tag;
    
    tag = SW>sx+100?0:1;//(+100)将要滑动到屏幕宽度就跳转
    if (_tempTag != tag) {
        _tempTag = tag;
        tag == 0?[self showViewClick]:[self dataViewClick];
    }

}


#pragma mark -- 调用相机,更换头像
//选择上传头像方式  拍照 or 相册
-(void)singleTapAction {
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"请选择照片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;   // 设置委托
            imagePickerController.sourceType = sourceType;
            imagePickerController.allowsEditing = YES;
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;   // 设置委托
            imagePickerController.sourceType = sourceType;
            imagePickerController.allowsEditing = YES;
            [self presentViewController:imagePickerController animated:YES completion:nil];
            
            
        }];
        
        // Add the actions.
        [alertController addAction:cancelAction];
        [alertController addAction:cameraAction];
        [alertController addAction:photoAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark --- imagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _topView.headImage.image = image;
    NSString *Token = [[getDataHand shareHandLineData]stringPutPicture];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }params:nil checkCrc:NO cancellationSignal:nil];

    NSString *string = [Factory randomlyString];
    NSString *timeString = [Factory TimeToDataString];
    NSString *SHA = [Factory SHA1HexDigest:[NSString stringWithFormat:@"%@%@%@",[loginModel grobleLoginModel].secretKey,timeString,string]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 头像图片上传
        [upManager putFile:[self getImagePath:image] key:@"avatar" token:Token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            if ([resp objectForKey:@"state"]) {
                NSString *url = [NSString stringWithFormat:@"%@%@",QI_NIU,[resp objectForKey:@"url"]];
                NSString *avatar = [NSString stringWithFormat:@"%@=%@",key,url];
                NSDictionary *dic =[[getDataHand shareHandLineData]SaveUsersAllDataWithAccessKey:[loginModel grobleLoginModel].accessKey Signature:SHA Timestamp:timeString Nonce:string Key:avatar];
                if ([[dic objectForKey:@"message"] isEqualToString:@"保存成功"]) {
                    UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"头像修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alView show];
                }
            }
        } option:uploadOption];

    });
    // 模态消失
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
