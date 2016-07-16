//
//  SubTableViewDataChangeViewController.m
//  乐影
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "SubTableViewDataChangeViewController.h"
@interface SubTableViewDataChangeViewController () {
    CGFloat SCW;

}
@property (nonatomic, strong)NSMutableArray *navTitleArr;

@end

@implementation SubTableViewDataChangeViewController

- (instancetype)initWith:(SubTableTypeStyle)style {
    self = [super init];
    if (self) {
        SCW = [UIScreen mainScreen].bounds.size.width;
        self.navigationItem.title = self.navTitleArr[style];
        switch (style) {
            case SubTableTypeStyleName:
                [self SubTableName];
                break;
                
            case SubTableTypeStyleStyle:
                [self SubTableStyle];
                break;
                
            case SubTableTypeStyleBar:
                [self SubTableBar];
                break;
                
            case SubTableTypeStyleID:
                [self SubTableID];
                break;
                
            case SubTableTypeStyleHeight:
                [self SubTableHeight];
                break;
                
            case SubTableTypeStyleWeight:
                [self SubTableWeight];
                break;
                
            case SubTableTypeStyleBWH:
                [self SubTableBWH];
                break;
                
            case SubTableTypeStyleShoe:
                [self SubTableShoe];
                break;
                
            case SubTableTypeStylePhone:
                [self SubTablePhone];
                break;
                
            case SubTableTypeStyleWeiChat:
                [self SubTableWeiChat];
                break;
                
            case SubTableTypeStyleQQ:
                [self SubTableQQ];
                break;
                
            case SubTableTypeStyleMail:
                [self SubTableMail];
                break;
                
            case SubTableTypeStyleSignature:
                [self SubTableSignature];
                break;
                
            case SubTableTypeStyleIntroduction:
                [self SubTableIntroduction];
                break;
                
            default:
                break;
        }
        
    }
    return self;
}


- (void)SubTableName {
    CGFloat nameX = 20;
    CGFloat nameY = 20 + 64;
    CGFloat nameH = 30;
    UITextField * name = [[UITextField alloc] init];
    name.frame = CGRectMake(nameX, nameY,SCW - (nameX*2) , nameH);
    [self.view addSubview:name];
    
    UIView * bottomView = [UIView new];
    bottomView.frame = CGRectMake(nameX, nameY + nameH, SCW - (nameX*2), 2);
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY + nameH, SCW - (nameX*2), nameH)];
    label.text = @"好的名字让别人更容易记住你";
    label.textColor = [UIColor grayColor];
    [label setFont:[UIFont systemFontOfSize:12.5]];
    [self.view addSubview:label];
}

- (void)SubTableStyle {
    
}

- (void)SubTableBar {
    
}
- (void)SubTableID {
    
}

- (void)SubTableHeight {
    
}

- (void)SubTableWeight {
    
}
- (void)SubTableBWH {
    
}

- (void)SubTableShoe {
    
}
- (void)SubTablePhone {
    
}
- (void)SubTableWeiChat {
    
}
- (void)SubTableQQ {
    
}
- (void)SubTableMail {
    
}
- (void)SubTableSignature {
    
}
- (void)SubTableIntroduction {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (NSMutableArray * )navTitleArr {
    _navTitleArr = [[NSMutableArray alloc] initWithArray:@[@"修改昵称",@"选择艺人类型",@"选择个性标签",@"身份认证",@"修改身高",@"修改体重",@"修改三围",@"修改鞋码",@"修改手机号码",@"修改微信号",@"修改QQ",@"修改邮箱",@"修改签名",@"修改简介",]];
    return _navTitleArr;
}
- (void)initDataArr {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
