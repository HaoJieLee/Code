//
//  MyViewController.m
//  Heng
//
//  Created by 赵良育 on 16/4/1.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    
    if (_imageString != nil) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:self.imageString]];
    }
    
    UITapGestureRecognizer *uig =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myImageaction:)];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.autoresizesSubviews = YES;
    _imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.imageView addGestureRecognizer:uig];
    
    _imageView.userInteractionEnabled = YES;
    
//    _introduceLabel.text = _strMessage;
//    
//    _introduceLabel.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.6];
    
    // view的高度
    CGFloat height = 60;
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenW - height, 241, height)];
//    self.myView.backgroundColor = [UIColor yellowColor];
    self.myView.backgroundColor = [UIColor colorWithRed:1 / 255.0 green:1 / 255.0 blue:1 / 255.0 alpha:0.5];
    [self.imageView addSubview:_myView];
    
    // 图标
//    @property (nonatomic,strong) UIImageView *imgIcon;
    self.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 55, 55)];
    self.imgIcon.image = [UIImage imageNamed:@"logo5.png"];
    [self.myView addSubview:_imgIcon];
    
    // 昵称
//    @property (nonatomic,strong) UILabel *lblNicheng;
    self.lblNicheng = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imgIcon.frame) + 10, CGRectGetMinY(_imgIcon.frame) + 2, CGRectGetWidth(_myView.frame) - CGRectGetMaxX(_imgIcon.frame) - 10, 25)];
    self.lblNicheng.font = [UIFont systemFontOfSize:13];
    self.lblNicheng.textColor = [UIColor whiteColor];
    
    if (_strMessage == nil) {
        self.lblNicheng.text = @"昵称：nicheng";
    }
    else
    {
        self.lblNicheng.text = _strMessage;
    }
    [self.myView addSubview:_lblNicheng];
    
    // 三围
//    @property (nonatomic,strong) UILabel *lblSanwei;
    self.lblSanwei = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_lblNicheng.frame), CGRectGetMaxY(_lblNicheng.frame), CGRectGetWidth(_lblNicheng.frame), CGRectGetHeight(_lblNicheng.frame))];
    self.lblSanwei.font = [UIFont systemFontOfSize:11];
    self.lblSanwei.textColor = [UIColor whiteColor];
    
    if (self.lblSanwei == nil) {
        self.lblSanwei.text = @"169cm 25/30/31 45kg 10码";
    }
    else
    {
        self.lblSanwei.text = _strSanweiMes;
    }
    [self.myView addSubview:_lblSanwei];
    

    // Do any additional setup after loading the view from its nib.
}
/**
 * 点击图片返回
 */
-(void)myImageaction:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
/**
 * 横屏方法
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
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
