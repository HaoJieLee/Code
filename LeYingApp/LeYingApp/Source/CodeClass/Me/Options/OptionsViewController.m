//
//  OptionsViewController.m
//  YHXZ
//
//  Created by xiaoheibi on 16/6/28.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import "OptionsViewController.h"
#import "PasswordViewController.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"
#import "MessageSettingsViewController.h"
#import "ServiceViewController.h"



@interface OptionsViewController ()<UITableViewDataSource>

@end

@implementation OptionsViewController


-(void)ExitButton
{
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 370, 300, 50)];
    btn.backgroundColor = [UIColor grayColor];
    
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    
//    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];

}


-(void)onClick{
    NSLog(@"ddd");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self ExitButton];
    //设置顶部标签栏自定制
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.tableView.bounds = CGRectMake(0, 25, SCREEN_WIDTH, SCREEN_HEIGHT-25);
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

//设置CELL的组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    return 3;
}

//设置CELL每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        return 2;
    }

}

//设置CELL的名字 和图片
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath{
    
  //  NSLog(@"调用的次数%ld",indexPath.row);
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];

    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"修改密码";
                cell.imageView.image = [UIImage imageNamed:@"修改密码.png"];
                NSLog(@"123");
            }
            break;
            default:
                break;
        }
    }
    
    
    if (indexPath.section == 1){
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"关于我们.png"];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"联系客服";
            cell.imageView.image = [UIImage imageNamed:@"电话.png"];
        }
            break;
            case 2:
        {
            cell.textLabel.text = @"反馈";
            cell.imageView.image = [UIImage imageNamed:@"反馈.png"];

        }
            break;
            
            
        default:
            break;
    }
    }
    
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"消息设置";
                cell.imageView.image = [UIImage imageNamed:@"消息1.png"];

            }
                break;
                case 1:
            {
                cell.textLabel.text = @"检查更新";
                cell.imageView.image = [UIImage imageNamed:@"更新.png"];

                NSLog(@"ssss");
            }
                break;
                
            default:
                break;
        }
    }
    
   // cell.textLabel.text = [NSString stringWithFormat:@"修改密码",indexPath.section,indexPath.row];
    
    
    return cell;
}

//设置标签栏的宽度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 20;
}

//设置cell跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    if (indexPath.section == 0 && indexPath.row == 0 ) {
        PasswordViewController *password = [[PasswordViewController alloc]init];
        password.title = @"修改密码";
        [self.navigationController pushViewController:password animated:YES];
    }
  
    if (indexPath.section == 1 && indexPath.row == 0 ){
        AboutViewController *about = [[AboutViewController alloc]init];
        about.title = @"关于我们" ;
        [self.navigationController pushViewController:about animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        ServiceViewController *service = [[ServiceViewController alloc]init];
        service.title = @"联系客服";
        [self.navigationController pushViewController:service animated:YES];
    }

    if (indexPath.section == 1 && indexPath.row == 2) {
        
    
        FeedbackViewController *feedback = [[FeedbackViewController alloc]init];
//        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:feedback];
        feedback.title = @"反馈";
        [self.navigationController pushViewController:feedback animated:NO];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        MessageSettingsViewController *messgae = [[MessageSettingsViewController alloc]init];
        messgae.title = @"消息设置";
        [self.navigationController pushViewController:messgae animated:YES];
    }

//检查更新提示
    if (indexPath.section == 2 && indexPath.row == 1) {
    
        UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"检查更新" message:@"版本更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        [alertview show];
        
    }
}



//处理点击按钮关联事件 更新的点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:{
            
        }
            break;
        case 1:{
            
        }
            break;
            
        default:
            break;
    }
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
