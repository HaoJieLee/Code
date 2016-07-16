//
//  SetViewController.m
//  News
//
//  Created by Xcord-LS on 15/10/24.
//  Copyright (c) 2015年 All rights reserved.
//

#import "SetViewController.h"
#import "ResetTableViewCell.h"
#import "PhotoTableViewCell.h"

#import "ChangePassWordViewController.h"
#import "changNameViewController.h"
#import <AFNetworking.h>

@interface SetViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,assign)NSInteger inter;
@property (nonatomic,strong)UIImage *currentImg;
@property (nonatomic,strong)NSString *mySrt;
@property (nonatomic,strong)PhotoTableViewCell *cell1;

@end

@implementation SetViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
     [self.tableView registerClass:[ResetTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[PhotoTableViewCell class] forCellReuseIdentifier:@"photocell"];
    
    
    
    //设置cell之间线的颜色
    self.tableView.separatorColor = [UIColor colorWithRed:122/255.0f green:137/255.0f blue:142/255.0f alpha:1.0];
    
    //设置背景图片
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    img.image = [UIImage imageNamed:@"sybg.png"];
    img.alpha = 0.7;
    self.tableView.backgroundView = img;
    
}

// 调用相机后的代理方法
// 拍摄完成后要执行的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 图片存入相册
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    // 从相册库中选中的图片应该显示在哪个UIImageView中(依次显示)
    self.currentImg = image;
    
    if (image!=nil)
    {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",myurl,@"/index.php/Home/system/upimages.html"]];
        NSDictionary *param = @{@"ios":@"1"
                                };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:URL.absoluteString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // 上传文件
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
            
        }  progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
             //NSLog(@"成功%@",result);
             UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alView show];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"请检查网络连接" message:@"修改失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [alView show];
             NSLog(@"失败%@",error);
         }];
        
    }
    
    _cell1.photoImage.image = image;
    //    [self.tableView reloadData];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"name.png"];   // 保存文件的名称
    
    [UIImagePNGRepresentation(image)writeToFile: filePath atomically:YES];
    // 模态消失
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    // 返回
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (section == 1)
    {
        return 1;
    }
    return 3;
}

//通过委托方法设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 5;
}
//设置表头背景颜色
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 7)];
    myview.backgroundColor = [UIColor colorWithRed:121/255.0f green:130/255.0f blue:126/255.0f alpha:1.0];
    
    
    return myview;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   

    
    float temSize  =   [[SDImageCache sharedImageCache] getSize] / 1024.0f / 1024.0f;
   
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            _cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            _cell1 = [tableView dequeueReusableCellWithIdentifier:@"photocell" forIndexPath:indexPath];
            
            _cell1.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            
            NSLog(@"%@",self.picString);
            if (![[NSString stringWithFormat:@"%@",self.picString] isEqualToString:@"(null)"])
            {
                [_cell1.photoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",myurl,_picString]]];
            }
            else
            {
                 _cell1 .photoImage.image = [UIImage imageNamed:@"shequ1.png"];
            }
            _cell1.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            _cell1.showLab.text = @"头像设置";
            return _cell1 ;
        }
        else if (indexPath.row == 1)
        {
            ResetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
            
            KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.textLabel.text = @"修改昵称";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
           
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            
            if ([self.nameString isEqualToString:@"<null>"]) {
                cell.showLab.text = @"";
            }
            else
            {
                cell.showLab.text = self.nameString;
            }
            self.mySrt = cell.showLab.text;
            return cell;
        }
        else
        { ResetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
            
                 KCellStyle;
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.textLabel.text = @"修改密码";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
            cell.titleImage.image = [UIImage imageNamed:@"zhankai3.png"];
            return cell;
        }

    }
    else
    {
            ResetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
            
            
            cell.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f  blue:255/255.0f alpha:0.5f];
            cell.textLabel.text = @"清除缓存";
        cell.textLabel.textColor = [UIColor colorWithRed:90/255.0f green:101/255.0f  blue:104/255.0f alpha:1.0f];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.showLab.text = [NSString stringWithFormat:@"%.0f M",temSize];
            return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
           
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
//
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
           ///]
            [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"sytopd.png"] forBarMetrics:UIBarMetricsDefault];
             [self.navigationController presentViewController:picker animated:YES completion:nil];
            
            
        }
        if (indexPath.row == 1)
        {
    
            changNameViewController *changNameVC = [[changNameViewController alloc]init];
            changNameVC.myNameStr = self.mySrt;
            [self.navigationController pushViewController:changNameVC animated:YES];
            
            
        }
        if (indexPath.row == 2)
        {
            ChangePassWordViewController *changVC = [[ChangePassWordViewController alloc]init];
            changVC.myPhone = self.userName;
            [self.navigationController pushViewController:changVC animated:YES];
            
        }
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            //显示缓存多大 ;
            float temSize  =   [[SDImageCache sharedImageCache] getSize] / 1024.0f / 1024.0f;
            NSString *text =[NSString stringWithFormat:@"已清除缓存%.0fM", temSize];
            [[SDImageCache sharedImageCache] clearDisk];
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:text delegate: nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [self.tableView reloadData];
        }
    }
    
    
    
   
        
    
    
    
}
-(void)clearCacheSuccess

{
    [self.tableView reloadData];
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清除缓存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [view show];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return 95;
        }
    }
    return 40;
}



/*设置标题尾的宽度*/
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//
//{
//    
//    return 5;
//    
//}
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
