//
//  VideoWebViewController.m
//  LeYingApp
//
//  Created by LiuChenhao on 16/1/23.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "VideoWebViewController.h"

@interface VideoWebViewController ()
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation VideoWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    //项目浏览量
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [[getProjectData shareProjectData] completeClickwithID:self.clickIndex];
        // webview 处理
        self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
        
        //[self.webView setScalesPageToFit:YES];// 设置内容自适应屏幕
        
        [self.view addSubview:_webView];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.videoLoad]];
        [self.webView loadRequest:request];
        

    }
    
   
    //http://v.youku.com/v_show/id_XMTQ1MzE1ODY2NA==.html
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
