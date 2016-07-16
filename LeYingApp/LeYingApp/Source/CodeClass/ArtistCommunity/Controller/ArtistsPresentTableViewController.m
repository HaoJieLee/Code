//
//  ArtistsPresentTableViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "ArtistsPresentTableViewController.h"
#import "ArtistsPresentTableViewCell.h"
#import "CompanyConnectTableViewCell.h"
#import "WorkTableViewCell.h"
#import "detailModel.h"

@interface ArtistsPresentTableViewController ()
@property (nonatomic,assign)NSInteger inter;
@property (nonatomic,strong)NSString *contentStr;
@property (nonatomic,strong)NSString *lifecontentStr;
@property (nonatomic,strong)NSArray *myPresentArr;

@end

@implementation ArtistsPresentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myPresentArr = [NSArray array];
    self.tableView.bounces = NO;
    [self.tableView registerClass:[ArtistsPresentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self.tableView registerClass:[CompanyConnectTableViewCell class] forCellReuseIdentifier:@"mycell"];
    
     [self.tableView registerClass:[WorkTableViewCell class] forCellReuseIdentifier:@"workcell"];
    
    self.tableView.scrollEnabled = NO;
   
    //设置cell之间线的颜色
    self.tableView.separatorColor = [UIColor colorWithRed:122/255.0f green:137/255.0f blue:142/255.0f alpha:1.0];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [self setUpData];
        
    }
    //设置背景图片
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    img.image = [UIImage imageNamed:@"sybg.png"];
    img.alpha = 0.7;
    self.tableView.backgroundView = img;
    self.inter = 2;
    
   
    
}
-(void)setUpData
{
    
    [[getAboutArtistData shareArtistData] getRecommendWithId:self.presentId Recommend:^(NSArray *Recommend) {
        
        self.myPresentArr = Recommend;
    }];
}
//设置cell分割线从最左边开始
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //这里要判断数组为空的情况

    detailModel *d = self.myPresentArr[0];
    if (section == 0)
    {
        return 7;
    }
    else if (section == 1)
    {
        if ([d.isPhoneOpen isEqualToString:@"0"]&&[d.isWechatOpen isEqualToString:@"0"] )
        {
            return 3;
        }
       else if ([d.isPhoneOpen isEqualToString:@"0"]&&[d.isWechatOpen isEqualToString:@"1"])
       {
            return 3;
        }
       else if ([d.isPhoneOpen isEqualToString:@"1"]&&[d.isWechatOpen isEqualToString:@"0"])
        {
            return 3;
        }
        else
        {
            return 4;
        }
        
        
    }
    else
    {
       return 4;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    detailModel *d = self.myPresentArr[0];
    if ([d.isPhoneOpen isEqualToString:@"0"]&&[d.isWechatOpen isEqualToString:@"0"] )
    {
        if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                return 80;
            }
        }

    }
    if ([d.isPhoneOpen isEqualToString:@"0"]&&[d.isWechatOpen isEqualToString:@"1"] )
    {
        if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                return 40;
            }
        }
        
    }
    if ([d.isPhoneOpen isEqualToString:@"1"]&&[d.isWechatOpen isEqualToString:@"0"] )
    {
        if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                return 40;
            }
        }
        
    }
    if (indexPath.section == 2)
    {
        if (indexPath.row == 2)
        {
            
            return  30 +[self heightForString:self.contentStr];
            
        }
        if (indexPath.row == 3)
        {
            return 30 + [self heightForString:self.contentStr];
        }
    }

    
    return 40;
    
}
//返回表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 7;
}
//设置表头背景颜色
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 7)];
    myview.backgroundColor = [UIColor colorWithRed:121/255.0f green:130/255.0f blue:126/255.0f alpha:1.0];
    
    
    return myview;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    detailModel *d = self.myPresentArr[0];
    self.contentStr = d.subCategory;
    self.lifecontentStr = d.experience;
    if (indexPath.section == 0)
    {
        ArtistsPresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
         KCellStyle;
        cell.backgroundColor = [UIColor clearColor];
        

        if (indexPath.row == 0)
        {
            cell.titLab.text = @"艺名";
            cell.titShowLab.text = d.nicename;
           
           
            
        }
        if (indexPath.row == 1)
        {
            cell.titLab.text = @"性别";
            if ([d.gender isEqualToString:@"1"])
            {
                cell.titShowLab.text = @"男";
            }
            else
            {
                cell.titShowLab.text = @"女";
            }
            
            
        }
        if (indexPath.row == 2)
        {
            cell.titLab.text = @"地区";
            cell.titShowLab.text = d.location;
            
        }
        if (indexPath.row == 3)
        {
            cell.titLab.text = @"身高";
            cell.titShowLab.text = d.height;
            
        }
        if (indexPath.row == 4)
        {
            cell.titLab.text = @"体重";
            cell.titShowLab.text = d.weight;
            
        }
        if (indexPath.row == 5)
        {
            cell.titLab.text = @"三围";
            cell.titShowLab.text = d.bwh;
            
        }
        if (indexPath.row == 6)
        {
            cell.titLab.text = @"鞋码";
            cell.titShowLab.text = d.shoesize;
            
        }
        return cell;
        
    }

    if (indexPath.section == 1)
    {
        ArtistsPresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
         KCellStyle;
        cell.backgroundColor = [UIColor clearColor];
        

        if ([d.isPhoneOpen isEqualToString:@"0"]&&[d.isWechatOpen isEqualToString:@"0"])
        {
            if (indexPath.row == 0)
            {
                CompanyConnectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
                 KCellStyle;
                cell.backgroundColor = [UIColor clearColor];
                cell.myLab.text = @"此人未公开微信号和手机号码，请联系平台";
                cell.phoneLab.text = @"电话:0571-87865555";
                
                return cell;
                
            }
            if (indexPath.row == 1)
            {
                cell.titLab.text = @"邮箱";
                cell.titShowLab.text = d.email;
                
            }
            if (indexPath.row == 2)
            {
                cell.titLab.text = @"QQ";
                cell.titShowLab.text = d.qq;
                
            }
          
            

        }
        else if([d.isPhoneOpen isEqualToString:@"0"]&&[d.isWechatOpen isEqualToString:@"1"])
        {
            if (indexPath.row == 0)
            {
                cell.titLab.text = @"微信号";
                cell.titShowLab.text = d.wechat;
                
                
                
            }
            if (indexPath.row == 1)
            {
                cell.titLab.text = @"邮箱";
                cell.titShowLab.text =d.email;
                
            }
            if (indexPath.row == 2)
            {
                cell.titLab.text = @"QQ";
                cell.titShowLab.text = d.qq;
                
            }
        }
        else if([d.isPhoneOpen isEqualToString:@"1"]&&[d.isWechatOpen isEqualToString:@"0"])
        {
            if (indexPath.row == 0)
            {
                cell.titLab.text = @"手机号";
                cell.titShowLab.text = d.phone;
                
                
                
            }
            if (indexPath.row == 1)
            {
                cell.titLab.text = @"邮箱";
                cell.titShowLab.text =d.email;
                
            }
            if (indexPath.row == 2)
            {
                cell.titLab.text = @"QQ";
                cell.titShowLab.text = d.qq;
                
            }
        }


        else
        {
            if (indexPath.row == 0)
            {
                cell.titLab.text = @"微信号";
                cell.titShowLab.text = d.wechat;
                
                
                
            }
            if (indexPath.row == 1)
            {
                cell.titLab.text = @"手机号";
                cell.titShowLab.text =d.phone;
                
            }
            if (indexPath.row == 2)
            {
                cell.titLab.text = @"邮箱";
                cell.titShowLab.text = d.email;
                
            }
            if (indexPath.row == 3)
            {
                cell.titLab.text = @"QQ";
                cell.titShowLab.text = d.qq;
                
            }
        }
        
       
    return cell;
        
    }
    
    if (indexPath.section == 2)
    {
       
        

        if (indexPath.row == 0)
        {
            ArtistsPresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
             KCellStyle;
            cell.backgroundColor = [UIColor clearColor];
            cell.titLab.text = @"类型";
            cell.titShowLab.text = d.category;
              return cell;
            
            
        }
        if (indexPath.row == 1)
        {
            ArtistsPresentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
             KCellStyle;
            cell.backgroundColor = [UIColor clearColor];
            cell.titLab.text = @"标签";
            cell.titShowLab.text = d.tag;
              return cell;
        }
        if (indexPath.row == 2)
        {
            WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workcell" forIndexPath:indexPath];
             KCellStyle;
            cell.backgroundColor = [UIColor clearColor];
            cell.titLab.text = @"主要作品";
            cell.detailLab.text = self.contentStr;
            
            CGFloat tempHight = [self heightForString:self.contentStr];
            
            CGRect tempRect = cell.detailLab.frame;
            
            tempRect.size.height = tempHight;
            cell.detailLab.frame = tempRect;
           
            
            return cell;
        }
        if (indexPath.row == 3)
        {
            WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workcell" forIndexPath:indexPath];
             KCellStyle;
            cell.backgroundColor = [UIColor clearColor];
            cell.titLab.text = @"人生经历";
            cell.detailLab.text = self.lifecontentStr;
            
            CGFloat tempHight = [self heightForString:self.contentStr];
            
            CGRect tempRect = cell.detailLab.frame;
            
            tempRect.size.height = tempHight;
            cell.detailLab.frame = tempRect;
            return cell;
        }
        
        
      
    }


    return nil;
}

-(CGFloat)heightForString:(NSString *)aString
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0] };
    
    
    // 把传进来的字符串放在一个矩形中
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.tableView.frame) - 20, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.height;
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
