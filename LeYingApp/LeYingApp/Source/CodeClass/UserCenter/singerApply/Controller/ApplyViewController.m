//
//  ApplyViewController.m
//  Zhongchou
//
//  Created by 赵良育 on 15/12/11.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import "ApplyViewController.h"
#import "ApplyScrollView.h"
@interface ApplyViewController ()<UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)ApplyScrollView * applyScrollView;

@end

@implementation ApplyViewController
-(void)loadView
{
    self.applyScrollView = [[ApplyScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _applyScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 基本数据设置
    [self mySet];
    
    [self productionAndMyLift];
    
    // Do any additional setup after loading the view.
}
// 主要作品和人生经历
-(void)productionAndMyLift
{
    self.applyScrollView.myTableView.dataSource = self;
    
    self.applyScrollView.myTableView.delegate =self;
    
    self.applyScrollView.myTableView.scrollEnabled = NO;
}
-(void)mySet
{
    self.navigationItem.title = @"艺人申请";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.applyScrollView.briefInfomation.delegate = self;
    
    self.applyScrollView.nameTextField.delegate = self;
    
    self.applyScrollView.otherNameTextField.delegate = self;
    
    self.applyScrollView.heightTextField.delegate = self;
    
    self.applyScrollView.weightTextField.delegate  = self;
    
    self.applyScrollView.sinaBlogTextField.delegate = self;
    
    self.applyScrollView.fanNameTextField.delegate = self;
    
    self.applyScrollView.starTextField.delegate = self;
    
    self.applyScrollView.bloodTextField.delegate = self;
    
    self.applyScrollView.jobTextField.delegate = self;
    
    self.applyScrollView.addressTextField.delegate = self;
    
    self.applyScrollView.hobbyTextField.delegate = self;
    
    self.applyScrollView.habitTextField.delegate = self;
    
    self.applyScrollView.companyTextField.delegate = self;
    
    self.applyScrollView.productionTextField.delegate = self;

}

// tableView的代理事件
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:@"主要作品:"];
    }else
    {
        return [NSString stringWithFormat:@"人生经历:"];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = @"cell";
    
    UITableViewCell * myCell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    }
    
    return myCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    
        return 13;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.applyScrollView.placeHolder.hidden = YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1 animations:^{
        
        self.applyScrollView.contentOffset = CGPointMake(0, self.view.frame.size.height * 5/7);
        
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self.applyScrollView.briefInfomation resignFirstResponder];
        
        if (self.applyScrollView.briefInfomation.text.length == 0) {
            
            self.applyScrollView.placeHolder.hidden = NO;
        }
        
    }
    return YES;
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
