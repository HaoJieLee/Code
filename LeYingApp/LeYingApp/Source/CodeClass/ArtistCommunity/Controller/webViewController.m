//
//  webViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/5/13.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation webViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    // webview 处理
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    //[self.webView setScalesPageToFit:YES];// 设置内容自适应屏幕
    
    [self.view addSubview:_webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.myWebStr]];
    [self.webView loadRequest:request];
    
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
