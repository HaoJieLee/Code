//
//  MakeShowViewController.m
//  乐影
//
//  Created by Chuck on 16/7/11.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MakeShowViewController.h"



@interface MakeShowViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *one;
@property (nonatomic,strong) UIButton *two;
@property (nonatomic,strong) UIButton *three;
@property (nonatomic,strong) UIButton *four;
@property (nonatomic,strong) UIButton *five;
@property (nonatomic,strong) UIButton *six;

@property (nonatomic,strong) NSMutableArray *infoArray;
@property (nonatomic,assign) NSMutableArray *tagArray;
@property (nonatomic,assign) int tags;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *label;
@end

@implementation MakeShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];

    //变横屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 320);
    
    //隐藏导航栏
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
    
    //暂时页面布局*******************************************
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/6)];
    navigationView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:navigationView];
    //返回按钮
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 60)];
    cancelBtn.backgroundColor = [UIColor greenColor];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    //制作模卡label
    UILabel *markShwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 0, 80, 60)];
    markShwoLabel.backgroundColor = [UIColor blueColor];
    markShwoLabel.text = @"制作模卡";
    [navigationView addSubview:markShwoLabel];
    //完成btn (需改btn
    UILabel *okLabel = [[UILabel alloc] initWithFrame:CGRectMake(610, 0, 40, 60)];
    okLabel.backgroundColor = [UIColor yellowColor];
    okLabel.text = @"完成";
    [self.view addSubview:okLabel];
    
    //已上传照片label
    UILabel *imgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(navigationView.frame), 100, 30)];
    imgLabel.backgroundColor = [UIColor whiteColor];
    imgLabel.text = @"已上传照片";
    [self.view addSubview:imgLabel];
    //选择照片UIScrollView
    UIScrollView *photoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgLabel.frame), 100, 300)];
    photoScrollView.contentSize = CGSizeMake(100, 600);
    photoScrollView.showsVerticalScrollIndicator =YES;
    photoScrollView.pagingEnabled = YES;
    photoScrollView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:photoScrollView];
    //暂时固定五个UIButton
    for (int i = 0; i < 5; i++) {
        UIButton *btnPhoto = [[UIButton alloc] initWithFrame:CGRectMake(5, 5+(90*i)+i, 90, 90)];
        btnPhoto.backgroundColor = [UIColor whiteColor];
        [btnPhoto addTarget:self action:@selector(pickerVCAction) forControlEvents:UIControlEventTouchUpInside];
        [photoScrollView addSubview:btnPhoto];
    }
    
    //第一个button
    _one = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(photoScrollView.frame)+5, CGRectGetMaxY(navigationView.frame), 200, 305)];
    _one.backgroundColor = [UIColor yellowColor];
    [_one setTitle:@"1" forState:UIControlStateNormal];
    [_one addTarget:self action:@selector(gainPhoto) forControlEvents:UIControlEventTouchUpInside];
    _one.tag = 1001;
    [self.view addSubview:_one];
    //第二个button
    _two = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_one.frame)+5, CGRectGetMinY(_one.frame), 112, 150)];
    _two.tag = 1002;
    _two.backgroundColor = [UIColor yellowColor];
    [_two addTarget:self action:@selector(gainPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_two];
    //第三个btn
    _three = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_two.frame)+5, CGRectGetMinY(_two.frame), 112, 150)];
    _three.backgroundColor = [UIColor yellowColor];
    [_three addTarget:self action:@selector(gainPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_three];
    //第四个btn
    _four = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_three.frame)+5, CGRectGetMinY(_three.frame), 112, 150)];
    _four.backgroundColor = [UIColor yellowColor];
    [_four addTarget:self action:@selector(gainPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_four];
    //第五个btn
    _five = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_two.frame), CGRectGetMaxY(_two.frame)+5, 170, 150)];
    _five.backgroundColor = [UIColor yellowColor];
    [_five addTarget:self action:@selector(gainPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_five];
    //第六个btn
    _six = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_five.frame)+5, CGRectGetMinY(_five.frame), 170, 150)];
    _six.backgroundColor = [UIColor yellowColor];
    [_six addTarget:self action:@selector(gainPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_six];
    
    //tableview选择视图 （调比例等
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(200, 150, 300, 200)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    //
    _label = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 300, 50)];
    _label.text = @"您想要选择的位置";
    _label.backgroundColor = [UIColor purpleColor];
    _label.hidden = YES;
    [self.view addSubview:_label];
    //
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];

}

//返回控制器
- (void)cancelBtnAction{

    //返回显示导航栏
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
    //返回变竖屏
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 320);
    
    [self.navigationController popViewControllerAnimated:YES];
}


//调用系统相册
- (void)gainPhoto{
    
    UIImagePickerController * pc = [[UIImagePickerController alloc]init];
    pc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pc.view.transform = CGAffineTransformMakeRotation(M_PI/2);

    //是否允许被编辑
    pc.allowsEditing = YES;
    
    //代理，这时候遵循一下代理
    pc.delegate = self;//因为delegete遵守了两个协议，这里只需要一个协议，只遵守了一个
    
    //animated是否要动画
    [self presentViewController:pc animated:YES completion:^{
        
    }];
    
}

//系统相册的回调方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //把得到的相册传递为标记的ImageView
    
//    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:info];
//    NSMutableArray *arr = [NSMutableArray arrayWithObject:info];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:dic forKey:@"dic"];
//    NSData *imgData = UIImageJPEGRepresentation(resultImage, 0.001);
//    [first addObject:imgData];
    
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [_one setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    UIImage *resultImage2 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [_two setImage:[resultImage2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
//    UIImage *resultImage3 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//        [_three setImage:[resultImage3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    UIImage *resultImage4 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    [_four setImage:[resultImage4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    UIImage *resultImage5 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    [_five setImage:[resultImage5 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    UIImage *resultImage6 = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    [_six setImage:[resultImage6 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    
    [self.infoArray addObject:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
    NSLog(@"%ld",self.infoArray.count);
    
    
    //退出
    [self dismissViewControllerAnimated:YES completion:^{
        
    } ];
    
}

- (NSMutableArray *)infoArray{
    
    if (!_infoArray) {
        
        _infoArray = [NSMutableArray array];
    }
    
    return _infoArray;
}

//切换照片
- (void)getImgWithButton{
    
    //if判断tag数组里有没有tag，有就替换，并且对应tag的图片也替换
    
    UIImage *resultImage = [[self.infoArray lastObject] objectForKey:@"UIImagePickerControllerEditedImage"];
    [[self.view viewWithTag:self.tags] setImage:[resultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
}


//因为想要手动旋转，所以先关闭自动旋转
- (BOOL)shouldAutorotate{
    
    return NO;
}

//选择器视图显示
- (void)pickerVCAction{
    
    self.tableView.hidden = NO;
    self.label.hidden = NO;
}

#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"1";
    }else if (indexPath.row == 1){
        
        cell.textLabel.text = @"2";
    }else if (indexPath.row == 2){
        
        cell.textLabel.text = @"3";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"4";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"5";
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"6";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        self.tableView.hidden = YES;
        self.label.hidden = YES;
        
    }else if (indexPath.row == 1){
        
        self.tableView.hidden = YES;
        self.label.hidden = YES;
        
    }else if (indexPath.row == 2){
        
        self.tableView.hidden = YES;
        self.label.hidden = YES;
        
    }else if (indexPath.row == 3){
        
        self.tableView.hidden = YES;
        self.label.hidden = YES;
        
    }else if (indexPath.row == 4){
        
        self.tableView.hidden = YES;
        self.label.hidden = YES;
    }else if (indexPath.row == 5){
        
        self.tableView.hidden = YES;
        self.label.hidden = YES;
    }
    
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
