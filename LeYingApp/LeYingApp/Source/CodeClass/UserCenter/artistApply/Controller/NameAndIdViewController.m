//
//  NameAndIdViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/7/11.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "NameAndIdViewController.h"

@interface NameAndIdViewController ()
@property (nonatomic,strong)UITextField *textField;
@end

@implementation NameAndIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:_textField];
    // Do any additional setup after loading the view.
}

-(UITextField*)textField{
    
    if (_textField == nil) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60)];
        _textField.delegate = self;
        
    }
    return _textField;
    
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
