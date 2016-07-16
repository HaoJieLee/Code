//
//  resingnAboutViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/4/6.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "resingnAboutViewController.h"

@interface resingnAboutViewController ()
@property (nonatomic,strong)UIWebView *myTextView;
@property (nonatomic,strong)NSString *myIntro;



@end

@implementation resingnAboutViewController
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
    // Do any additional setup after loading the view.
    
    
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [self getCompleteIntro];
        self.myTextView = [[UIWebView alloc]init];
        self.myTextView.backgroundColor = [UIColor whiteColor];
        //    self.myTextView.alpha = 0.5;
        self.myTextView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.myTextView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_myTextView];
        NSString *htmlStr = [self showInfoWithWebviewByHtml:self.myIntro];
        [self.myTextView loadHTMLString:htmlStr baseURL:nil];
        [self.myTextView sizeToFit];
        
    }
   
    
    
}
#pragma mark ---   webView设置
///////////////////////////////////////////////////////
- (NSString *)showInfoWithWebviewByHtml:(NSString *)htmlStr
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"night.css" withExtension:nil]];
    [html appendFormat:@"<style type='text/css'>"];
    [html appendFormat:@"</style>"];
    [html appendString:@"</head>"];
    [html appendString:@"<body style='background-color:rgb(0,0,0,0.5)'>"];
    [html appendString:htmlStr];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
}

-(void)getCompleteIntro
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/member/getprovisions.html"];
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
