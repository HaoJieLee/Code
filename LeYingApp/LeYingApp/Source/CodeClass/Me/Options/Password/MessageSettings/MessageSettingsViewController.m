//
//  MessageSettingsViewController.m
//  YHXZ
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import "MessageSettingsViewController.h"
#include "SwitchButton.h"

@interface MessageSettingsViewController ()

@end

@implementation MessageSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.tableView.bounds = CGRectMake(0, 5, SCREEN_WIDTH, SCREEN_HEIGHT-5);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 3 ;
    }else {
        return 1 ;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  NSLog(@"调用的次数%ld",indexPath.row);
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"不接收活动方消息";
                UISwitch *swith = [[SwitchButton shareSwich] witch1];
                swith.tag = 0;
                [swith addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:swith];
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"不接收摄影师消息";
                UISwitch * swith = [[SwitchButton shareSwich]witch2];
                [swith addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                swith.tag = 1;
                [cell.contentView addSubview:swith];
    
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"不接收陌生人消息";
                UISwitch * swith = [[SwitchButton shareSwich]witch3];
                [swith addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                swith.tag = 2;
                [cell.contentView addSubview:swith];

                
            }
                break;
                
                
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"消息免打扰";
                UISwitch * swith = [[SwitchButton shareSwich]witch4];
                [swith addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                swith.tag = 3;
                [cell.contentView addSubview:swith];

                
                
            }
                break;
            default:
                break;
        }
    }
    

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)switchAction:(UISwitch *)sender
{
    switch (sender.tag) {
        case 0:
        {
            if (sender.on) {
                sender.on=  YES;
            }else{
                sender.on = NO;
            }
        }
            break;
        case 1:
        {
            if (sender.on) {
                sender.on=  YES;
            }else{
                sender.on = NO;
            }        }
            break;
        case 2:
        {
            if (sender.on) {
                sender.on=  YES;
            }else{
                sender.on = NO;
            }
        }
            break;
        case 3:
        {
            if (sender.on) {
                sender.on=  YES;
            }else{
                sender.on = NO;
            }
        }
            break;
            
        default:
            break;
    }
//    UISwitch *swich = [[SwitchButton shareSwich]witch1];
//    {
//        if (sender == [[SwitchButton shareSwich]witch2]) {
//            if (sender == [[SwitchButton shareSwich]witch3]) {
//                if (sender == [[SwitchButton shareSwich]witch4]) {
//                    if ([sender isOn]) {
//                        NSLog(@"1");
//                        swich.on = YES;
//                    }
//                }
//            }
//        }
//    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    

    
}

//设置标签栏的宽度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 5;
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
