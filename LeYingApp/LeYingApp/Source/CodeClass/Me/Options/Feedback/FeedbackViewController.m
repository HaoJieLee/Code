//
//  FeedbackViewController.m
//  YHXZ
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import "FeedbackViewController.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface FeedbackViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITextView *answerTextView;
@property (nonatomic,strong) UIImageView *answerBackImage;
@property (nonatomic,strong) NSString *nowDate;

@end



@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title=@"回复信息";
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self getDate];
    [self.view addSubview:self.answerBackImage];
    [self.view addSubview:self.answerTextView];

    
    UIBarButtonItem *SureBT=[[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(surelPublish)];
    self.navigationItem.rightBarButtonItem = SureBT;
    // Do any additional setup after loading the view.
}
//取消回复按钮
-(void)cancelPublish
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)surelPublish
{
    if ([self.answerTextView.text isEqual:@""]) {
       // [MBProgressHUD showError:@"回复内容不能为空"];
    }else{
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"是否提交" message:@"提交后无法取消发送信息" delegate:self cancelButtonTitle:@"考虑一下" otherButtonTitles:@"确定", nil];
        [alertview show];
    }
    
    
}
//处理点击按钮关联事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:{
            
        }
            break;
        case 1:{
            
            [self sendAnswerData];
        }
            break;
            
        default:
            break;
    }
}

-(void)sendAnswerData{
    
    if (self.block) {
        self.block(self.nowDate,self.answerTextView.text);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark 加载textview的背景图
- (UIImageView *)answerBackImage{
    if (_answerBackImage==nil) {
        _answerBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(8*SCREEN_WIDTH/320, 20, 304*SCREEN_WIDTH/320, 250)];
        _answerBackImage.image = [self resizeWithImagename:@"630×174.png"];
    }
    return _answerBackImage;
}
#pragma mark 加载textview
- (UITextView *)answerTextView{
    if (_answerTextView==nil) {
        _answerTextView = [[UITextView alloc]initWithFrame:CGRectMake(8*SCREEN_WIDTH/200, 35, 304*SCREEN_WIDTH/330, 250)];
        _answerTextView.backgroundColor = [UIColor clearColor];
    }
    return _answerTextView;
}

#pragma mark - 图片拉伸方法
-(UIImage *)resizeWithImagename:(NSString *)name{
    UIImage *image = [UIImage imageNamed:name];
    
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

//获取当前时间
- (void)getDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//获取当前时间
    self.nowDate = [formatter stringFromDate:date];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.answerTextView resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
        return YES;
    }
}


@end
