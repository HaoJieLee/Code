//
//  completeModel.h
//  乐影
//
//  Created by LiuChenhao on 16/3/22.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface completeModel : NSObject


/**
 
 {
 "id": "2",
 "coverImgUrl": "http://o7rqw6rro.bkt.clouddn.com/1465798747444233354.jpg",
 "title": "进行中测试",
 "summary": "进行中测试 .......",
 "limitDate": "1480000000",
 "viewTime": "22",
 "publishDate": "1465881118"
 }
 */

//进行中

@property (nonatomic,copy)NSString *summary;//一句话介绍活动
@property (nonatomic,copy)NSString *coverImgUrl;//图片URL
@property (nonatomic,copy)NSString *publishDate;//发布时间
@property (nonatomic,copy)NSString *Id;//活动id
@property (nonatomic,copy)NSString *viewTime;//查看次数
@property (nonatomic,copy)NSString *title;//标题
@property (nonatomic,copy)NSString *limitDate;//截止时间

//进行中

//@property (nonatomic,copy)NSString *toptype;
//@property (nonatomic,copy)NSString *videoload;

/**  {
"id": "1",
"coverImgUrl": "http://o7rqw6rro.bkt.clouddn.com/1465798747444233354.jpg",
"title": "测试乐影",
"summary": "测试乐影",
"limitDate": "1465920000",
"viewTime": "261",
"publishDate": "1465881118"
}
*/



@end
