//
//  CertityViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/7/10.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CertityViewController.h"
#import "NameAndCertityTableViewCell.h"
#import "identityPhotoTableViewCell.h"

@interface CertityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UILabel *introduceLabel;//介绍label
@property (nonatomic,strong)UITableView *certityTableView;//认证的textView


@end

@implementation CertityViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    //重写左bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    self.navigationItem.title = @"信息认证";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    [self.view addSubview:self.certityTableView];
    
    
    
    
}

-(void)leftBarButtonItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableView*)certityTableView{
    if (_certityTableView == nil) {
        _certityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 400) style:UITableViewStylePlain];
        _certityTableView.delegate = self;
        _certityTableView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"NameAndCertityTableViewCell" bundle:nil];
        [_certityTableView registerNib:nib forCellReuseIdentifier:@"cellName"];
        UINib *nib2 = [UINib nibWithNibName:@"identityPhotoTableViewCell" bundle:nil];
        [_certityTableView registerNib:nib2 forCellReuseIdentifier:@"cellPhoto"];
    }
    return _certityTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        default:
            break;
    }
    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            NameAndCertityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellName"];
            if (indexPath.row==0) {
                cell.NameLabel.text = @"姓名";
                cell.UserNameLabel.text = @"";
            }else if (indexPath.row==1){
                cell.NameLabel.text = @"用户身份证号";
                
            }
            return cell;
        }
            break;
        case 1:
        {
            identityPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellPhoto"];
            switch (indexPath.row) {
                case 0:
                {
                    cell.IDfrontLabe.text = @"身份证正面照";
                }
                    break;
                case 1:
                {
                    cell.IDfrontLabe.text = @"身份证反面照";
                }
                    break;
                case 2:
                {
                    cell.IDfrontLabe.text = @"手持身份证照";
                }
                    break;

                default:
                    break;
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
