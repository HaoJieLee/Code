//
//  ApplyScrollView.m
//  Zhongchou
//
//  Created by 赵良育 on 15/12/11.
//  Copyright © 2015年 赵良育. All rights reserved.
//

#import "ApplyScrollView.h"

@implementation ApplyScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
        
        // 批量上传
        
        [self moreLoad];
        
        [self moreLabelTextField];
    }
    return self;
}
-(void)p_setupView
{
    self.showsVerticalScrollIndicator = NO;
    
    self.userInteractionEnabled = YES;
    
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height*3);
    
    self.titleImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(selfWidth / 5, selfWidth / 10, selfWidth /3 , selfWidth  * 2 / 5)];
    
#pragma mark 可删除代码
    self.titleImageView.backgroundColor = [UIColor grayColor];
    
    //
    
    self.uploadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.uploadButton.frame = CGRectMake(CGRectGetMaxX(self.titleImageView.frame)+selfWidth / 10, selfWidth *2 / 5, selfWidth / 4, selfWidth / 12);
    
   // self.uploadButton.backgroundColor = [UIColor orangeColor];
    
    self.uploadButton.tintColor = [UIColor whiteColor];
    
    self.uploadButton.layer.cornerRadius = 3 ;
    
    [self.uploadButton setTitle:@"上传" forState:UIControlStateNormal];
    
    UILabel * briefLabel = [[UILabel alloc]initWithFrame:CGRectMake(4 , selfWidth / 15 + CGRectGetMaxY(self.titleImageView.frame), selfWidth / 6, selfWidth / 12)];
    
    briefLabel.text = @"简介:";
    
    briefLabel.textAlignment = NSTextAlignmentLeft;
    
    briefLabel.textColor = [UIColor orangeColor];
    
    briefLabel.font = [UIFont systemFontOfSize:15];
    
    [self mybriefInfomation:briefLabel];
    
    [self addSubview:_titleImageView];
    
    [self addSubview:_uploadButton];
    
    [self addSubview:briefLabel];
}

// 简介基本数据设置
-(void)mybriefInfomation:(UILabel *)myLabel
{
    self.briefInfomation = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(myLabel.frame) , CGRectGetMaxY(myLabel.frame), selfWidth - 8, selfWidth / 2)];
    self.briefInfomation.layer.cornerRadius = 3;
    
    self.briefInfomation.layer.borderWidth = 1;
    
    self.briefInfomation.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.briefInfomation.editable = YES;
    
    self.briefInfomation.scrollEnabled = YES;
    
    self.briefInfomation.font = [UIFont systemFontOfSize:16];
    
    self.placeHolder = [[UILabel alloc]initWithFrame:CGRectMake(2, 4, selfWidth/4, selfWidth / 20)];
    
    self.placeHolder.text = @"300字左右...";
    
    self.placeHolder.font = [UIFont systemFontOfSize:16];
    
    self.placeHolder.textColor  = [UIColor grayColor];
    
    [self.briefInfomation addSubview:_placeHolder];

    [self addSubview:_briefInfomation];
}

// 批量上传设置
-(void)moreLoad
{
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleImageView.frame), CGRectGetMaxY(self.briefInfomation.frame)+selfWidth / 16, CGRectGetWidth(self.titleImageView.frame) *4/5, CGRectGetHeight(self.titleImageView.frame) * 7/9)];
    
    self.myImageView.backgroundColor = [UIColor grayColor];
    
    self.moreUploadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.moreUploadButton.frame = CGRectMake(selfWidth / 8 + CGRectGetMaxX(self.myImageView.frame), CGRectGetMaxY(self.briefInfomation.frame) + selfWidth / 4, CGRectGetWidth(self.uploadButton.frame), CGRectGetHeight(self.uploadButton.frame));
    self.moreUploadButton.layer.cornerRadius = 3;
    
    self.moreUploadButton.backgroundColor = [UIColor orangeColor];
    
    [self.moreUploadButton setTitle:@"批量上传" forState:UIControlStateNormal];
    
    self.moreUploadButton.tintColor = [UIColor whiteColor];
    
    [self addSubview:_moreUploadButton];
    
    [self addSubview:_myImageView];
}

// 老多label 和 textField
-(void)moreLabelTextField
{
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.myImageView.frame) + selfWidth / 16, selfWidth / 6, selfWidth / 14)];
    
    self.nameTextField = [[UITextField alloc]init];
    
    self.otherNameTextField = [[UITextField alloc]init];
    
    self.heightTextField = [[UITextField alloc]init];
    
    self.heightTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.weightTextField = [[UITextField alloc]init];
    
    self.weightTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.sinaBlogTextField =[[UITextField alloc]init];
    
    self.fanNameTextField = [[UITextField alloc]init];
    
    self.starTextField = [[UITextField alloc]init];
    
    self.bloodTextField = [[UITextField alloc]init];
    
    self.jobTextField = [[UITextField alloc]init];
    
    self.addressTextField = [[UITextField alloc]init];
    
    self.hobbyTextField = [[UITextField alloc]init];
    
    self.habitTextField = [[UITextField alloc]init];
    
    
    [self labelOne:nameLabel oneTextField:self.nameTextField twoTextField:self.otherNameTextField oneString:@"姓名:" twoString:@"别名:"];
    
    UILabel * heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame), CGRectGetWidth(nameLabel.frame), CGRectGetHeight(nameLabel.frame))];
    
    [self labelOne:heightLabel oneTextField:self.heightTextField twoTextField:self.weightTextField oneString:@"身高:" twoString:@"体重:"];
    
    UILabel * sinaLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(heightLabel.frame), CGRectGetMaxY(heightLabel.frame), CGRectGetWidth(heightLabel.frame), CGRectGetHeight(heightLabel.frame))];
    
    [self labelOne:sinaLabel oneTextField:self.sinaBlogTextField twoTextField:self.fanNameTextField oneString:@"新浪微博:" twoString:@"粉丝名:"];
    
    UILabel * starLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(sinaLabel.frame), CGRectGetMaxY(sinaLabel.frame), CGRectGetWidth(sinaLabel.frame), CGRectGetHeight(sinaLabel.frame))];
    
    [self labelOne:starLabel oneTextField:self.starTextField twoTextField:self.bloodTextField oneString:@"星座:" twoString:@"血型:"];
    
    UILabel * jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(starLabel.frame), CGRectGetMaxY(starLabel.frame), CGRectGetWidth(starLabel.frame), CGRectGetHeight(starLabel.frame))];
    
    [self labelOne:jobLabel oneTextField:self.jobTextField twoTextField:self.addressTextField oneString:@"职业:" twoString:@"现居:"];
    
    UILabel * hobitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(jobLabel.frame), CGRectGetMaxY(jobLabel.frame), CGRectGetWidth(jobLabel.frame), CGRectGetHeight(jobLabel.frame))];
    
    [self labelOne:hobitLabel oneTextField:self.hobbyTextField twoTextField:self.habitTextField oneString:@"习惯:" twoString:@"爱好:"];
    
    
    
    UILabel * companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(hobitLabel.frame)+2, CGRectGetMaxY(hobitLabel.frame), CGRectGetWidth(hobitLabel.frame), CGRectGetHeight(hobitLabel.frame))];
    
    self.companyTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(companyLabel.frame), CGRectGetMinY(companyLabel.frame) +2, selfWidth - CGRectGetWidth(companyLabel.frame) - 9, self.hobbyTextField.frame.size.height)];
    
    UILabel * productLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(companyLabel.frame), CGRectGetMaxY(companyLabel.frame), CGRectGetWidth(companyLabel.frame), CGRectGetHeight(companyLabel.frame))];
    
    self.productionTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(productLabel.frame), CGRectGetMinY(productLabel.frame) +2, CGRectGetWidth(self.companyTextField.frame), CGRectGetHeight(self.companyTextField.frame))];
    
    companyLabel.text = @"经纪公司:";
    
    productLabel.text = @"代表作品:";
    
    productLabel.font = [UIFont systemFontOfSize:15];
    
    companyLabel.font = [UIFont systemFontOfSize:15];
    
    self.companyTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.productionTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    
    // 主要作品和人生经历
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMinX(productLabel.frame), CGRectGetMaxY(productLabel.frame)+selfWidth / 20, selfWidth -8, selfWidth*2/3) style:UITableViewStyleGrouped];

//    self.myTableView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_myTableView];
    
    [self addSubview:_productionTextField];
    
    [self addSubview:_companyTextField];
    
    [self addSubview:companyLabel];
    
    [self addSubview:productLabel];

}
// label 和textField混合私有方法
-(void)labelOne:(UILabel *)oneLabel oneTextField:(UITextField *)textFieldOne twoTextField:(UITextField *)textFieldTwo oneString:(NSString *)stringOne twoString:(NSString *)stringTwo
{
    UILabel * myLabel = [[UILabel alloc]initWithFrame:CGRectMake(selfWidth / 2, CGRectGetMinY(oneLabel.frame), CGRectGetWidth(oneLabel.frame), CGRectGetHeight(oneLabel.frame))];
    
    oneLabel.text = stringOne;
    
    myLabel.text = stringTwo;
    
    oneLabel.font = [UIFont systemFontOfSize:15];
    
    myLabel.font = [UIFont systemFontOfSize:15];
    
    oneLabel.textAlignment = NSTextAlignmentCenter;
    
    myLabel.textAlignment = NSTextAlignmentCenter;
    
    textFieldOne.frame = CGRectMake(CGRectGetMaxX(oneLabel.frame)+2, CGRectGetMinY(oneLabel.frame) +2, selfWidth / 2 - CGRectGetWidth(oneLabel.frame)-5, CGRectGetHeight(oneLabel.frame) - 4);
    
    textFieldTwo.frame = CGRectMake(CGRectGetMaxX(myLabel.frame), CGRectGetMinY(myLabel.frame) + 2, CGRectGetWidth(textFieldOne.frame), CGRectGetHeight(textFieldOne.frame));
    
    textFieldOne.borderStyle = UITextBorderStyleRoundedRect;
    
    textFieldTwo.borderStyle = UITextBorderStyleRoundedRect;
    
    [self addSubview:textFieldOne];
    
    [self addSubview:textFieldTwo];
    
    [self addSubview:oneLabel];
    
    [self addSubview:myLabel];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.briefInfomation resignFirstResponder];
    
    if (self.briefInfomation.text.length == 0) {
        
        self.placeHolder.hidden = NO;
        
    }
    [self.nameTextField resignFirstResponder];
    
    [self.otherNameTextField resignFirstResponder];
    
    [self.heightTextField resignFirstResponder];
    
    [self.weightTextField resignFirstResponder];
    
    [self.sinaBlogTextField resignFirstResponder];
    
    [self.fanNameTextField resignFirstResponder];
    
    [self.starTextField resignFirstResponder];
    
    [self.bloodTextField resignFirstResponder];
    
    [self.jobTextField resignFirstResponder];
    
    [self.addressTextField resignFirstResponder];
    
    [self.hobbyTextField resignFirstResponder];
    
    [self.habitTextField resignFirstResponder];
    
    [self.companyTextField resignFirstResponder];
    
    [self.productionTextField resignFirstResponder];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
