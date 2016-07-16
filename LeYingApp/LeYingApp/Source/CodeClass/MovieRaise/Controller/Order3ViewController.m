//
//  Order3ViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/3/30.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "Order3ViewController.h"
#import "order3View.h"
#import "expandModel.h"
#import "getProjectData.h"
#import "proBuyDataModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "OrderMessageToServer.h"
#import "SDCycleScrollView.h"
@interface Order3ViewController ()<UITextViewDelegate,SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)order3View *ov;
@property (nonatomic,strong)NSArray *expandArr;
@property (nonatomic,strong)NSDictionary *myDic;
@property (nonatomic,strong)NSMutableArray *myArr;


/// 详情
@property (nonatomic,assign) CGRect oldDetailsRect;
/// 顶部view的frame
@property (nonatomic,assign) CGRect oldTopViewRect;
/// 底部view的frame
@property (nonatomic,assign) CGRect oldbottomViewRect;
/// contentsize大小
@property (nonatomic,assign) CGSize oldContentSize;
/// 展开按钮
@property (nonatomic,assign) CGRect oldBtnDetailsRect;



// 支付
@property (nonatomic,strong) NSString *activeId;



@end

@implementation Order3ViewController

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
    self.myArr = [NSMutableArray array];
    
    self.ov = [[order3View alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _ov;
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    self.ov.detailWeb.scrollView.delegate = self;
    
    
    [self.ov.btnShowDetail addTarget:self action:@selector(btnShowDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    self.myDic = [NSDictionary dictionary];
    
    self.expandArr = [NSArray array];
    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 子线程中加载数据
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            // 1.加载更多数据
            [[getProjectData shareProjectData]getBuyDetailWithId:self.index passValue:^(NSDictionary *buyDic) {
                
                self.myDic = buyDic;
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                [self setData];
                [self setUpUI];
            });
        });
    }
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
-(void)leftBarButtonItemAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setData
{
   
    
    NSDictionary *dict = [NSDictionary dictionary];
    dict = [[self.myDic objectForKey:@"datas"] objectForKey:@"info"];
    
    proBuyDataModel * model = [[proBuyDataModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    [self.myArr addObject:model];
    
    
    // 支付信息赋值  活动id
    self.activeId = [dict objectForKey:@"id"];
    
    
    
    
    
}

-(void)setUpUI
{
    
    
    
    proBuyDataModel * p = self.myArr[0];
    self.ov.titLab.text = p.title;
    self.ov.titLab.text = p.title;
//    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
//    NSString *str2 = p.titlepic;
//    [self.ov.topPic sd_setImageWithURL:[NSURL URLWithString:[str1 stringByAppendingString:str2]]];
    
    
    // 定义pageControl的位置
    self.ov.topPic.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    // 设置图片间隔
    self.ov.topPic.autoScrollTimeInterval = 3;
    
    // 设置代理
    self.ov.topPic.delegate = self;
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int  i = 0; i < p.piclist.count; i++)
    {
        NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",myurl];
        
        NSString *str2 = p.piclist[i];
        [arr1 addObject:str2];
        [arr addObject:[str1 stringByAppendingString:str2]];
    }
    //self.myBigPicArr = arr1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.ov.topPic.imageURLStringsGroup = arr;
        //self.myView.cycleScrollView.titlesGroup = descStr;
    });
    
    

    
    
    NSString *htmlStr = [self showInfoWithWebviewByHtml:p.information];
    [self.ov.detailWeb loadHTMLString:htmlStr baseURL:nil];
    [self.ov.detailWeb sizeToFit];
    
    
    
//    self.ov.priceLab.text = p.price;
//    self.ov.mountLab.text = @"1";
//    self.ov.showMassageLab.text = [NSString stringWithFormat:@"%@%@%@",@"共",@"1",@"件商品"];
//    self.ov.allLab.text = p.price;
//    
    
    //NSString *totMoney = [NSString stringWithFormat:@"%ld", [cell3.supportShowLable.text integerValue] + [cell3.freightShowLable.text integerValue]];
    //cell3.totalShowLable.text = totMoney;
    
    
    
//    [self.ov.reduceBtn addTarget:self action:@selector(reduceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.ov.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
    
    
    // 卖家留言占位设置
//    self.ov.playholdLab.enabled = YES;
//    self.ov.playholdLab.backgroundColor = [UIColor clearColor];
//    self.ov.messageText.delegate = self;
//    self.ov.messageText.hidden = NO;
//    
//    
    /// 给确认按钮添加事件
   // [self.ov.affirmBtn addTarget:self action:@selector(affirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark ---   webView设置
///////////////////////////////////////////////////////
- (NSString *)showInfoWithWebviewByHtml:(NSString *)htmlStr
{
    CGFloat width = KScreenW * 0.9;
    CGFloat height = KScreenW * 0.6;
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"night.css" withExtension:nil]];
    [html appendString:@"<style type = \"text/css\">"];
    [html appendString:[NSString stringWithFormat:@"img{width:%f;height:%f;}",width,height]];
    [html appendString:@"</style>"];
    [html appendString:@"</head>"];
    [html appendString:@"<body style='background-color:rgb(222,222,222)'>"];
    [html appendString:htmlStr];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
}
//轮播图代理事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
    
}

////减少商品事件
//-(void)reduceBtnAction:(UIButton *)sender
//{
//    
//    order3View *order = (order2View *)sender.superview.superview.superview;
//    
//    if ([order.mountLab.text integerValue] <= 1)
//    {
//        order.mountLab.text = @"1";
//    }
//    else
//    {
//        order.mountLab.text = [NSString stringWithFormat:@"%ld", [order.mountLab.text integerValue] - 1];
//    }
//    //    NSInteger  myMoney = [cell.supportShowLable.text integerValue];
//    order.allLab.text = [NSString stringWithFormat:@"%.1f",[order.mountLab.text integerValue] * [order.priceLab.text floatValue]];
//    
//    
//    
//}
//-(void)textViewDidChange:(UITextView *)textView
//{
//    self.ov.messageText.text =  textView.text;
//    if (textView.text.length == 0)
//    {
//        self.ov.playholdLab.text = @"给卖家留言:";
//    }
//    else
//    {
//        self.ov.playholdLab.text = @"";
//    }
//}
//
//// 商品个数增加事件按钮
//-(void)addBtnAction:(UIButton *)sender
//{
//    
//    //Order3TableViewCell *cell = (Order3TableViewCell *)sender.superview.superview;
//    
//    
//    order2View *order = (order2View *)sender.superview.superview.superview;
//    if ([order.mountLab.text integerValue] >= 10)
//    {
//        order.mountLab.text = @"10";
//    }
//    else
//    {
//        order.mountLab.text = [NSString stringWithFormat:@"%ld", [order.mountLab.text integerValue] + 1];
//        NSLog(@"%@",order.mountLab.text);
//        NSLog(@"%@",order.priceLab.text);
//        
//        order.showMassageLab.text = [NSString stringWithFormat:@"%@%ld%@",@"共",[order.mountLab.text integerValue],@"件商品"];
//        order.allLab.text = [NSString stringWithFormat:@"%.1f",[order.mountLab.text integerValue] * [order.priceLab.text floatValue]];
//    }
//    
//    
//    
//}
//

//-(NSDictionary *)p_orderMessageCallToServer:(OrderMessageToServer *)sender
//{
//    // 准备数据
//    
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@",@"http://leying.hivipplus.com/index.php/home/index/orderadd.html"];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    // 准备参数
//    NSString *argument = [NSString stringWithFormat:@"buyactivitieid=%@&cardno=%@&username=%@&tel=%@&address=%@&goodsnum=%@&tomaijiamessage=%@",sender.buyactivitieid,sender.cardno,sender.username,sender.tel,sender.address,sender.goodsnum,sender.tomaijiamessage];
//    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
//    
//    //设置URl参数
//    [request setHTTPBody:argDada];
//    
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"error"]);
//    
//    return [dict objectForKey:@"datas"];
//}
//
//// 组织数据
//-(OrderMessageToServer *)orgernizeDataToServer
//{
//    OrderMessageToServer *orderMessage = [[OrderMessageToServer alloc] init];
//    orderMessage.buyactivitieid = self.activeId;
//    orderMessage.cardno = self.ov.consigneeText.text;
//    orderMessage.username = @"";
//    orderMessage.tel = self.ov.phoneText.text;
//    orderMessage.address = self.ov.addressText.text;
//    orderMessage.goodsnum = self.ov.mountLab.text;
//    orderMessage.tomaijiamessage = self.ov.messageText.text;
//    return orderMessage;
//}
//
//// 确认支付按钮事件
//-(void)affirmBtnAction:(UIButton *)sender
//{
//    
//    // 组织上传数据信息
//    OrderMessageToServer *orderMessage = [self orgernizeDataToServer];
//    
//    // 进行数据上传  把订单信息传回到服务器
//    
//    // 上传商品信息后服务器返回的数据
//    // information   商品信息
//    // orderno    订单号
//    // price    价格
//    // title    商品名称
//    NSDictionary *toServerDic = [self p_orderMessageCallToServer:orderMessage];
//    
//    
//    /*======================================*/
//    /*========需要填写商户app申请的============*/
//    /*======================================*/
//    NSString *partner = @"2088911227467632";
//    NSString *seller = @"2088911227467632";
//    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMKA7ERagtbJDro9y/NuaufW75E/7qPDcmw7cFZo9mc47PDx2pM8bX0C/qdl+SBCaDNu9prGB9v1J8KYBuiT/F5i1ROsxnnQh/++u3iVpiSXvk1/2Vchp48Zt3LqxBY/qXhXTKWtMqq5aTXXBD6bW8q3e3WMGzdNKrj2TRpY3AfbAgMBAAECgYEAoSCSGZHtf6bxd2GIGjJnh4Wr0mTm+W0I1hZrWnn7Xclvp66DRqOxg/U+Jki4l3vLvIf47ICOtC2j8XVli7hEQC0t2+CZpao+aLKPGS3FXexv81VCJgjBqoKUFYYaEIYn5ms+Mlr3avSJ8gmS0fQMFIKJeXl06T4RvjWVB82znXkCQQD1qkxeHeBvNQdW9CDDOjBXnIXcWvp8V2LYoVUoCD99zmyQ5LlVYyHoCzkG+iuuwedH5IXpUdGxqPBWTQQfhvs9AkEAyq+jLlK2fj4tDpH/8DEUdjx6p7nHRO2zjNEG2RdQN+lP1xOSk5VRwJ5mpVLniM0Oeq9RqchN6u/Qil63ipgg9wJBALVOqm4LvshUasZSBpwPJf6DFog63QNHuzwGVcLl03YWEyocpGvQbgXDwqLTn8mqcfctQWehaxGjjT0kOhbKmEECQGWnYzsnZrm4K1bkaK2pn+6Q9J9McKGkaenVKA8XPzdbf5yKB3iXajIl/6spAlC9L2beqSFzAYk0D65mRL1xAQ8CQQCFONCnHnCR2xHIb+YDMz/XAsHqVaq+Z/8mDonOJFirbScwLU8gp54+3hesIF1+5Lxt8cWuvH49jWrBPqHloDAk";
//    /*======================================*/
//    /*======================================*/
//    /*======================================*/
//    
//    Order *order = [[Order alloc] init];
//    order.partner = partner;   // 合作身份者id
//    order.seller = seller;     // 支付宝收款账号，手机号或者邮箱格式
//    order.tradeNO = [toServerDic objectForKey:@"orderno"]; //订单ID(由商家□自□行制定)
//    order.productName = [toServerDic objectForKey:@"title"]; //商品标题
//    order.productDescription = [toServerDic objectForKey:@"information"]; //商品描述
//    order.amount = [toServerDic objectForKey:@"price"]; //商 品价格
//    order.notifyURL = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/index/ailpayback.html"]; //回调URL
//    order.service = @"mobile.securitypay.pay";
//    // 支付类型。默认值为：1（商品购买）
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    
//    
//    
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types NSString *appScheme = @"alisdkdemo";
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"orderSpec = %@",orderSpec);
//    
//    
//    
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"LeYingAPP";
//    
//    
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式 NSString *orderString = nil;
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//        }];
//    }
//    
//}


/// 禁止webview滑动
// 禁止UIWebView上下滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y > 0) {
        scrollView.contentOffset = CGPointMake(point.x, 0);//这里不要设置为CGPointMake(0, point.y)，这样我们在文章下面左右滑动的时候，就跳到文章的起始位置，不科学
    }
    if (point.y < 0) {
        scrollView.contentOffset = CGPointMake(point.x, 0);
    }
}


/// 展开/收缩 按钮事件
-(void)btnShowDetailAction:(UIButton *)sender
{
    if ([self.ov.btnShowDetail.currentBackgroundImage isEqual:[UIImage imageNamed:@"zhankai4.png"]]) {
        /// 获取到实际内容高度
        CGSize newSize = self.ov.detailWeb.scrollView.contentSize;
        
        // 设置详情高度
        CGRect DetailWebRect = self.ov.detailWeb.frame;
        self.oldDetailsRect = DetailWebRect;
        CGRect newDetailWebRect = CGRectMake(DetailWebRect.origin.x, DetailWebRect.origin.y, DetailWebRect.size.width, newSize.height);
        self.ov.detailWeb.frame = newDetailWebRect;
        
        // 设置上半部分topview的frame
        CGRect topViewRect = self.ov.topView.frame;
        self.oldTopViewRect = topViewRect;
        CGRect newTopViewRect = CGRectMake(topViewRect.origin.x, topViewRect.origin.y, topViewRect.size.width, DetailWebRect.origin.y + newSize.height + 30);
        self.ov.topView.frame = newTopViewRect;
        
        // 设置展开按钮
        CGRect btnDetailRect = self.ov.btnShowDetail.frame;
        self.oldBtnDetailsRect = btnDetailRect;
        CGRect newBtnDetailRect = CGRectMake(btnDetailRect.origin.x, CGRectGetMaxY(self.ov.detailWeb.frame) + 5, btnDetailRect.size.width, btnDetailRect.size.height);
        self.ov.btnShowDetail.frame = newBtnDetailRect;
        //    [self.ov.btnShowDetail setImage:[UIImage imageNamed:@"zhankai2.png"] forState:UIControlStateNormal];
        [self.ov.btnShowDetail setBackgroundImage:[UIImage imageNamed:@"zhankai1.png"] forState:UIControlStateNormal];
        
        // 设置下半部分的frame
        CGRect bottomViewRect = self.ov.bottomView.frame;
        self.oldbottomViewRect = bottomViewRect;
        CGRect newBottomViewRect = CGRectMake(bottomViewRect.origin.x, CGRectGetMaxY(self.ov.topView.frame), bottomViewRect.size.width, bottomViewRect.size.height);
        self.ov.bottomView.frame = newBottomViewRect;
        
        // 设置contentsize
        CGSize oldContentSize = self.ov.myScrView.contentSize;
        self.oldContentSize = oldContentSize;
        CGSize newContentSize = CGSizeMake(oldContentSize.width, oldContentSize.height + newSize.height + 44);
        self.ov.myScrView.contentSize = newContentSize;
    }
    else
    {
        // 详情
        self.ov.detailWeb.frame = self.oldDetailsRect;
        // 按钮
        self.ov.btnShowDetail.frame = self.oldBtnDetailsRect;
        [self.ov.btnShowDetail setBackgroundImage:[UIImage imageNamed:@"zhankai4.png"] forState:UIControlStateNormal];
        // 顶部
        self.ov.topView.frame = self.oldTopViewRect;
        // 底部
        self.ov.bottomView.frame = self.oldbottomViewRect;
        // contentSize
        self.ov.myScrView.contentSize = self.oldContentSize;
    }
}

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
