//
//  ChatViewController.m
//  PracticeRongYun
//
//  Created by xiaoli on 16/1/7.
//  Copyright © 2016年 hangzhouyijiyin. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<RCChatSessionInputBarControlDelegate>
//RCIMUserInfoDataSource
@end

@implementation ChatViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    NSUserDefaults *myOtherID = [NSUserDefaults standardUserDefaults];
    [myOtherID setObject:self.myOtherId forKey:@"selfotherID"];
    
    
    
    
    
    // Do any additional setup after loading the view.

     //[[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    // 右上角的未读消息
    self.enableUnreadMessageIcon = YES;

    self.unReadMessageLabel.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.1];
    self.unReadMessageLabel.frame = CGRectMake(200, 100, 100, 30);
    self.unReadMessageLabel.text = @"你好";
    
        self.unReadButton.frame = CGRectMake(200, 100, 100, 30);
        self.unReadButton.backgroundColor = [UIColor cyanColor];
        [self.unReadButton setTitle:[NSString stringWithFormat:@"%ld消息", self.unReadMessage] forState:UIControlStateNormal];
    
    // 显示右下角消息的位置
    self.enableNewComingMessageIcon = YES;
    self.unReadNewMessageLabel.text = @"新消息";
    [super notifyUpdateUnreadMessageCount];
    
 
    
    // 输入框的模式
   self.defaultInputType = RCChatSessionInputBarInputVoice;
    
//    RCChatSessionInputBarControl *control = [[RCChatSessionInputBarControl alloc] initWithFrame:CGRectMake(0, 100, 0, 100) withContextView:self.view type:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_EXTENTION_CONTAINER_SWITCH];
  //  [control setInputTextview_height:50];
 //   [self.view addSubview:control];
    
   // 插入扩展项
//    [self.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"30X30-08"] title:@"头像" tag:3000];
//    [self.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"30X30-08"] title:@"头像2" tag:4000];
    
    self.displayUserNameInCell = NO;
    // 删除地理位置共享
    [self.pluginBoardView removeItemAtIndex:2];
    
    // 插入提示信息
    RCInformationNotificationMessage *tipInfomation = [RCInformationNotificationMessage notificationWithMessage:@"欢迎来到私人聊天" extra:@""];
    RCMessage *tipRcMessage = [[RCMessage alloc] initWithType:self.conversationType targetId:self.targetId direction:MessageDirection_SEND messageId:-1 content:tipInfomation];
    [self appendAndDisplayMessage:tipRcMessage];
    
}

- (void)notifyUpdateUnreadMessageCount
{
   
}



#pragma mark -  扩展功能板的点击回调
- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag
{
    NSLog(@"点击扩展功能版了， tag = %ld", tag);
    if (tag == 3000 || tag == 4000) {
      //  self.tabBarController.tabBar.translucent = NO;
        NSLog(@"我选择了自己的定义的扩展项");
    } else {
        [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    }
}


- (void)chatSessionInputBarControlContentSizeChanged:(CGRect)frame
{
    frame = CGRectMake(0, 0, 0, 100);
}

//头像点击事件
- (void)didTapCellPortrait:(NSString *)userId
{
    // 点击头像触发
    NSLog(@"userID = %@", userId);
    
}

- (void)didLongPressCellPortrait:(NSString *)userId
{
    NSLog(@"userID = %@", userId);
}

- (void)didTapMessageCell:(RCMessageModel *)model
{
    // 点击信息触发
    NSLog(@"model = %@", model);
    
}

- (void)didTapPhoneNumberInMessageCell:(NSString *)phoneNumber model:(RCMessageModel *)model
{
    NSLog(@"phoneNumber = %@", phoneNumber);
    //[self sendMessage:@"兄弟们大家好" pushContent:@"群主发的消息"];
   
    

}


//- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
//- (void)getUserInfoWithUserId:(NSString *)userId
//                   completion:(void (^)(RCUserInfo *userInfo))completion
//{
//    NSUserDefaults *mypublicId = [NSUserDefaults standardUserDefaults];
//    NSString *mypuId = [mypublicId objectForKey:@"selfMyId"];
//    
////    
////    NSUserDefaults *myOtherName = [NSUserDefaults standardUserDefaults];
////    NSString *myOtName = [myOtherName objectForKey:@"selfotherName"];
//    
//    
//    
//    NSUserDefaults *myOtherID = [NSUserDefaults standardUserDefaults];
//    NSString *myOtID = [myOtherID  objectForKey:@"selfotherID"];
//    
//    
////
//    if ([userId isEqual:mypuId]) {
//        RCUserInfo *user = [[RCUserInfo alloc] init];
//      
//        user.userId = mypuId;
//        user.name = @"我";
//        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
//        return completion(user);
//        
//        
//    }
//    else if ([userId isEqual:userId]) {
//        RCUserInfo *user = [[RCUserInfo alloc] init];
//        user.userId = myOtID;
//        user.name = @"123";
//          NSLog(@"%@",user.portraitUri);
//        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";
//        
//        
//        return completion(user);
//    }
//    return completion(nil);
//    
//}

//// 更改聊天气泡
//- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
////    if ([cell isKindOfClass:[RCTextMessageCell class]]) {
////        RCTextMessageCell *textCell = (RCTextMessageCell *)cell;
////        UIImage *image = textCell.bubbleBackgroundView.image;
////        textCell.bubbleBackgroundView.image = [textCell.bubbleBackgroundView.image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height *0.8, image.size.width * 0.8, image.size.height * 0.2, image.size.width * 0.2)];
////     //   textCell.nicknameLabel.text = @"我是谁";
////       
////        // 字体颜色
////        textCell.textLabel.textColor = [UIColor redColor];
////        // 只能修改边框的颜色
////        textCell.bubbleBackgroundView.backgroundColor = [UIColor cyanColor];
////        // 聊天背景的颜色
////        textCell.backgroundColor = [UIColor greenColor];
// //   }
//}



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
