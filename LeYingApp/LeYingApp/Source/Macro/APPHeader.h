//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h


#define selfWidth self.frame.size.width
#define selfHeight self.frame.size.height
#define ConX 10
#define ConY CGRectGetMaxY(self.artArrImage.frame) + 10
#define ConW 60
#define ConH 20
#define ConMid CGRectGetWidth(self.view.frame) / 2 - CGRectGetWidth(self.artistNameLable.frame) - 10

#define myurl @"http://leying.hivipplus.com/new_leying/index.php/api"
#define QI_NIU @"http://o7rqw6rro.bkt.clouddn.com/"
#define  lsUserCookie @"lsUserCookie"
// 注册头文件
#import "RegisterViewController.h"
#import "RegisterView.h"
// 登录头文件
#import "JoinView.h"
#import "JoinViewController.h"

//数据请求

#import "getDataHand.h"
#import "getProjectData.h"
#import "getAboutArtistData.h"
#import "getUserAddressData.h"
#import "getAboutOrder.h"


#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


//sdweb
#import "UIImageView+WebCache.h"


//shuaxin 
#import "MJRefresh.h"

//右navabar
#import "YCXMenu.h"


#import "LGcollectionCell.h"
#import "LGtitleBarView.h"


//网络判断头文件
#import "Reachability.h"
#import "IsHaveNetwork.h"
#import "MBProgressHUD.h"





















#import "DictToData.h"
#import "MBProgressHUD.h"



#import "AlertShow.h"


#import "Reach.h"

//#import "PXAlertView+Customization.h"




//TODO 提示
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif
