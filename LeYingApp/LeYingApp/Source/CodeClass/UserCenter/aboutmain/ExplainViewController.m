//
//  ExplainViewController.m
//  About软件
//
//  Created by lanou3g on 15/10/28.
//  Copyright (c) 2015年 WHM. All rights reserved.
//

#import "ExplainViewController.h"

@interface ExplainViewController ()
@property(nonatomic,strong)UITextView * myview;

@end

@implementation ExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myview = [[UITextView alloc]init];
    self.myview.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 400);
    [self.view addSubview:_myview];
   NSString * str = @"简介:\n\t乐影APP-隶属于杭州鸿古科技有限责任公司，是全国首家的新媒体影视平台，专业提供全民影视微众筹和全民影视文化线上线下服务！公司成立于2015年3月，是国内首家垂直型APP众筹及线下影视文化服务一体的平台。";
  //  self.myview.font = [UIFont systemFontOfSize:16.0];
    self.myview.textColor = [UIColor grayColor];
    self.myview.textAlignment = NSTextAlignmentLeft;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 30 ;
    NSDictionary * attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0],NSParagraphStyleAttributeName:paragraphStyle};
    self.myview.attributedText = [[NSAttributedString alloc]initWithString:str attributes:attributes];
  //  [self.myview setKeyboardAppearance:UIKeyboardAppearanceDefault];
    self.myview.editable = NO;
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
