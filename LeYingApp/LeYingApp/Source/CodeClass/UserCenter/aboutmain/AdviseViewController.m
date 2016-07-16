//
//  AdviseViewController.m
//  SeeWorld
//
//  Created by LZZ on 15/10/27.
//  Copyright (c) 2015年 LZZ. All rights reserved.
//

#import "AdviseViewController.h"
#import "AdviseScrollView.h"
@interface AdviseViewController ()<UITextViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) AdviseScrollView *AV;

@end

@implementation AdviseViewController

-(void)loadView
{
    self.AV = [[AdviseScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = _AV;
}

- (void)viewDidLoad {
     self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.AV.textView.delegate = self;
    self.AV.textView.backgroundColor = [UIColor whiteColor];
    self.AV.textView.alpha = 0.5;
    
    [self.AV.btnSub addTarget:self action:@selector(btnSubAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.AV.contentSize = CGSizeMake(0, KScreenH + 256);
    
    
}

//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    CGRect text = self.AV.textView.frame;
//    CGFloat moveY = text.origin.y;
//    text.origin.y -= moveY;
//    self.AV.textView.frame = text;
//    
//    CGRect btn = self.AV.btnSub.frame;
//    btn.origin.y -= moveY;
//    self.AV.btnSub.frame = btn;
//}

// 提交按钮功能实现
-(void)btnSubAction:(UIButton *)sender
{
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 提交数据
        NSString *str = self.AV.textView.text;
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/system/savefeedback.html"];
        NSURL *url = [NSURL URLWithString:urlStr];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        [request setHTTPMethod:@"POST"];
        
        // 准备参数
        NSString *argument = [NSString stringWithFormat:@"content=%@",str];
        NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
        //设置URl参数
        [request setHTTPBody:argDada];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([[[dict objectForKey:@"datas"] objectForKey:@"success"]isEqualToString:@"反馈成功"])
        {
            UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alView.tag = 1;
            alView.delegate =self;
            
            [alView show];
        }
       // NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"error"]);
        

    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.AV.textField == textField)
    {
        if ([toBeString length] > 400) {
            textField.text = [toBeString substringToIndex:20];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作提示" message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
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
