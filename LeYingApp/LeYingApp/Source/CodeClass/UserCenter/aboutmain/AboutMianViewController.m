//
//  AboutMianViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/17.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "AboutMianViewController.h"
#import "AdviseViewController.h"

@interface AboutMianViewController ()
@property (nonatomic,strong)UIScrollView *myScrollow;
@property(nonatomic,strong)UIView * myview;

@property(nonatomic,strong)UILabel * mylable;
@property(nonatomic,strong)UILabel * titLab;

@property(nonatomic,strong)UIImageView * myimage;

@property(nonatomic,strong)UILabel *nameLab;
@property (nonatomic,strong)UIWebView *myTextView;
@property (nonatomic,strong)UIButton *myBtn;
@property (nonatomic,strong)UILabel *introLab;
@property (nonatomic,strong)NSString *myIntro;

@end

@implementation AboutMianViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;

    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [self getCompleteIntro];
        
        [self setUp];
        
    }
 
}

-(void)setUp
{
    
    
    self.myScrollow = [[UIScrollView alloc]init];
    self.myScrollow.layer.contents =  (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    self.myScrollow.frame = CGRectMake(0, CGRectGetMaxY(self.myScrollow.frame), CGRectGetWidth([UIScreen mainScreen].bounds), self.view.frame.size.height + 321);
    
    self.myScrollow.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 1000);
    //self.myScrollow.backgroundColor = [UIColor redColor];
    //[UIColor colorWithRed:222/255.0f green:222/255.0f  blue:222/255.0f alpha:1.0];
    [self.view addSubview:_myScrollow];
    
    
    self.myview = [[UIImageView alloc]init];
    self.myview.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 3);
    self.myview.backgroundColor = [UIColor clearColor];
    [self.myScrollow  addSubview:_myview];
    
    
    self.myimage = [[UIImageView alloc]init];
    self.myimage.image = [UIImage imageNamed:@"logo.png"];
    self.myimage.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - CGRectGetWidth(self.view.frame) * 0.4 / 2, 20, CGRectGetWidth(self.view.frame) * 0.4, CGRectGetWidth(self.view.frame) * 0.4);
    [self.myview addSubview:_myimage];
    self.myimage.layer.cornerRadius = CGRectGetWidth(self.myimage.frame)/2;
    self.myimage.layer.masksToBounds = YES;
    
    
    
    
    
    
    self.mylable = [[UILabel alloc]init];
    self.mylable.frame = CGRectMake(CGRectGetWidth(self.view.frame)/ 2 - 50,CGRectGetMaxY(self.myimage.frame) + 10, 100, 30);
    [self.myview addSubview:_mylable];
    self.mylable.textAlignment = NSTextAlignmentCenter;
    self.mylable.font = [UIFont systemFontOfSize:20.0];
    self.mylable.textColor = [UIColor whiteColor];
    self.mylable.text = @"乐影";
    
    
    self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.mylable.frame), CGRectGetMaxY(self.mylable.frame), CGRectGetWidth(self.mylable.frame), 30)];
    
    [self.myview addSubview:_titLab];
    self.titLab.textAlignment = NSTextAlignmentCenter;
    self.titLab.font = [UIFont systemFontOfSize:20.0];
    self.titLab.textColor = [UIColor whiteColor];
    self.titLab.text = @"V1.0.0";
    
    
    
    //
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titLab.frame), CGRectGetWidth(self.view.frame), 180)];

    view1.backgroundColor = [UIColor whiteColor];
    view1.alpha = 0.5;
    [self.myScrollow addSubview:view1];
    
    self.introLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, CGRectGetWidth(self.mylable.frame), 30)];
    [view1 addSubview:_introLab];
    self.introLab.font = [UIFont systemFontOfSize:20.0];
    self.introLab.textColor = [UIColor colorWithRed:81 / 255.0 green:93/ 255.0 blue:94 / 255.0 alpha:1];
    self.introLab.text = @"功能介绍：";
    [view1 addSubview:_introLab];

    
    
    self.myTextView = [[UIWebView alloc]init];
    self.myTextView.backgroundColor = [UIColor whiteColor];
//    self.myTextView.alpha = 0.5; 
    self.myTextView.frame = CGRectMake(10, CGRectGetMaxY(self.introLab.frame), self.view.frame.size.width-20, 120);
    self.myTextView.backgroundColor = [UIColor clearColor];
    [view1 addSubview:_myTextView];
    NSString *htmlStr = [self showInfoWithWebviewByHtml:self.myIntro];
    [self.myTextView loadHTMLString:htmlStr baseURL:nil];
    [self.myTextView sizeToFit];
    
    
    
//    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineSpacing = 5 ;
//    NSDictionary * attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],NSParagraphStyleAttributeName:paragraphStyle};
  
    
    //意见反馈
    self.myBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myBtn.frame = CGRectMake(60, CGRectGetMaxY(view1.frame) + 30 ,CGRectGetWidth(self.view.frame) - 120, 40);
    //self.myBtn.backgroundColor = [UIColor whiteColor];
    
    //self.myBtn.alpha = 0.4;
    [self.myBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
    [self.myBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myBtn addTarget:self action:@selector(myBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.myBtn.layer.contents = (id)[UIImage imageNamed:@"loginbg.png"].CGImage;
    self.myBtn.layer.cornerRadius = 15;
    self.myBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.myScrollow  addSubview:_myBtn];
    
    
    
}

#pragma mark ---   webView设置
///////////////////////////////////////////////////////
- (NSString *)showInfoWithWebviewByHtml:(NSString *)htmlStr
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"night.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body style='background-color:rgb(0,0,0,0.5)'>"];
    [html appendString:htmlStr];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
}

-(void)getCompleteIntro
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/getfun.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
//    // 准备参数
//    NSString *argument = [NSString stringWithFormat:@"id=%@",artistId];
//    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
//    //设置URl参数
//    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    self.myIntro = [[dict objectForKey:@"datas"] objectForKey:@"info"];
    

}



-(void)myBtnAction:(UIButton *)sender
{
    AdviseViewController *adVc = [[AdviseViewController alloc]init];
    [self.navigationController pushViewController:adVc animated:YES];
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
