//
//  YourTestChatViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/5/6.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "YourTestChatViewController.h"
#import "ChatViewController.h"
@interface YourTestChatViewController ()

@end

@implementation YourTestChatViewController

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.contentView.backgroundColor = [UIColor colorWithRed: 146/255.0f green: 163/255.0f blue: 162/255.0f alpha:0.5];
    
  
    
    
}




- (void)viewDidLoad
{
  
    //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理
    [super viewDidLoad];
    

    
    self.view.subviews[0].backgroundColor = [UIColor colorWithRed: 146/255.0f green: 163/255.0f blue: 162/255.0f alpha:1.0];
    ((UITableView *)self.view.subviews[0]).separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
    
}
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.conversationType = model.conversationType;
    chatVC.targetId = model.targetId;
    chatVC.title = model.conversationTitle;
    chatVC.unReadMessage = model.unreadMessageCount;
    chatVC.enableUnreadMessageIcon = YES;
    chatVC.enableNewComingMessageIcon = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
    
    [[RCIMClient sharedRCIMClient] setConversationToTop:model.conversationType targetId:model.targetId isTop:YES];
}

- (void)didReceiveMemoryWarning
{
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
