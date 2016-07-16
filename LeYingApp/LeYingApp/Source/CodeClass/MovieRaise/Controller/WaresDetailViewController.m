//
//  WaresDetailViewController.m
//  乐影
//
//  Created by LiuChenhao on 16/7/3.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "WaresDetailViewController.h"
#import "order2View.h"
#import "expandModel.h"
#import "getProjectData.h"
#import "proBuyDataModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "OrderMessageToServer.h"
#import "SDCycleScrollView.h"
#import "AlertShow.h"

@interface WaresDetailViewController ()
@property (nonatomic,strong)UILabel *consigneeLabel;//收货信息
@property (nonatomic,strong)UILabel *consigneeInfoShowLabel;//收货信息展示
@property (nonatomic,strong)UIButton *consgneeButton;//收货信息点击button
@property (nonatomic,strong)UIView *detailView;//货物信息的View
@property (nonatomic,strong)UIView *zhifubaoView;//选择支付宝的View
@property (nonatomic,strong)UIView *xiaDanView;//确认下单的View
@property (nonatomic,strong)UITextView *textView;//说明 备注
@property (nonatomic,strong)UILabel *buyWaresQuantity;//购买数量
@property (nonatomic,strong)UILabel *unitpriceShowLable;//货物价格
@property (nonatomic,strong)UILabel * waresAmountLable;//@“剩余货数量”
@property (nonatomic,strong)UILabel *waresAmountShowLb;//剩余货物量
@property (nonatomic,strong)UIImageView * waresShowImage;//货物图片
@property (nonatomic,strong)UILabel *waresTitleLable;//货物标题

@property (nonatomic,strong)UILabel *QuantityPrice;//购买货物的总价
@property (nonatomic,strong)UIButton *xiadanButton;//下单的button

@property (nonatomic,strong)UIButton *reduceBtn;//购买数量➖
@property (nonatomic,strong)UILabel *mountLab;//购买数量个数
@property (nonatomic,strong)UIButton *addBtn;//购买数量+

@end

@implementation WaresDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self action:@selector(TuiChuView)];
    [self addAllInfo];
    [self setWaresInfo];
    // Do any additional setup after loading the view.
}
- (void)TuiChuView{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//添加货物信息
- (void)setWaresInfo{
    [self.waresShowImage sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.waresTitleLable.text = self.title;
    self.waresAmountShowLb.text = self.remain;
    self.unitpriceShowLable.text = [NSString stringWithFormat:@"¥ %@",self.price];
  
    if ([self.remain intValue] >=1) {
        
    }
}
//添加所有控件
- (void)addAllInfo{
    [self.view addSubview:self.consigneeLabel];
    [self.view addSubview:self.consgneeButton];
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.zhifubaoView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.QuantityPrice];
    [self.view addSubview:self.xiadanButton];
}

- (UILabel*)QuantityPrice{
    if (_QuantityPrice==nil) {
        _QuantityPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-50, CGRectGetWidth(self.view.frame)*2/3, 50)];
        _QuantityPrice.backgroundColor = [UIColor whiteColor];
        _QuantityPrice.textColor = [UIColor redColor];
        _QuantityPrice.textAlignment = NSTextAlignmentRight;
    }
    return _QuantityPrice;
}
- (UIButton *)xiadanButton{
    if (_xiadanButton==nil) {
        _xiadanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _xiadanButton.backgroundColor = [UIColor greenColor];
        _xiadanButton.frame = CGRectMake(CGRectGetWidth(self.QuantityPrice.frame), CGRectGetHeight(self.view.frame)-50, CGRectGetWidth(self.view.frame)/3, 50);
        [_xiadanButton addTarget:self action:@selector(xiadanToShangJia) forControlEvents:UIControlEventTouchUpInside];
        [_xiadanButton setTitle:@"立即下单" forState:UIControlStateNormal];
        [_xiadanButton setTintColor:[UIColor whiteColor]];
    }
    return _xiadanButton;
}
-(UITextView*)textView{
    if (_textView==nil) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.zhifubaoView.frame), CGRectGetWidth(self.view.frame)-20, 100)];
        _textView.text = @"说明";
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}
- (UIView*)zhifubaoView{
    if (_zhifubaoView == nil) {
        _zhifubaoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailView.frame)+10, CGRectGetWidth(self.view.frame), 81)];
        _zhifubaoView.backgroundColor = [UIColor whiteColor];
    }
    return _zhifubaoView;
}
-(UIView*)detailView{
    if (_detailView==nil) {
        _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.consgneeButton.frame)+10, CGRectGetWidth(self.view.frame), 150.0f)];
        [_detailView addSubview:self.waresShowImage];
        [_detailView addSubview:self.waresTitleLable];
        [_detailView addSubview:self.unitpriceShowLable];
        [_detailView addSubview:self.buyWaresQuantity];
        [_detailView addSubview:self.reduceBtn];
        [_detailView addSubview:self.mountLab];
        [_detailView addSubview:self.addBtn];
        [_detailView addSubview:self.waresAmountLable];
        [_detailView addSubview:self.waresAmountShowLb];
        _detailView.backgroundColor = [UIColor whiteColor];
    }
    return _detailView;
}
-(UIButton*)reduceBtn{
    if (_reduceBtn==nil) {
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.reduceBtn.frame = CGRectMake(CGRectGetMaxX(self.buyWaresQuantity.frame)+20, CGRectGetMaxY(self.unitpriceShowLable.frame), 25, 25);
        [_reduceBtn addTarget:self action:@selector(reduceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_reduceBtn setBackgroundImage:[UIImage imageNamed:@"djian.png"] forState:UIControlStateNormal];
    }
    return _reduceBtn;
}
-(UILabel*)mountLab{
    if (_mountLab==nil) {
        _mountLab  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.reduceBtn.frame) + 2, CGRectGetMinY(self.reduceBtn.frame), 30, 25)];
        _mountLab.text = @"1";
        _mountLab.backgroundColor = [UIColor colorWithRed:175/255.0f green:183/255.0f blue:185/255.0f alpha:1.0];
        _mountLab.textAlignment = NSTextAlignmentCenter;
    }
    return _mountLab;
}
-(UIButton*)addBtn{
    if (_addBtn==nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _addBtn.frame = CGRectMake(CGRectGetMaxX(self.mountLab.frame) + 2, CGRectGetMinY(self.reduceBtn.frame), 25, 25);
         [_addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"djia.png"] forState:UIControlStateNormal];
    }
    return _addBtn;

}
- (UIButton*)consgneeButton{
    if (_consgneeButton==nil) {
        _consgneeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _consgneeButton.frame = CGRectMake(0, 105, CGRectGetWidth(self.view.frame), 40);
        [_consgneeButton addSubview:self.consigneeInfoShowLabel];
        [_consgneeButton addTarget:self action:@selector(xuanzeConsgnee) forControlEvents:UIControlEventTouchUpInside];
        _consgneeButton.backgroundColor = [UIColor whiteColor];
       
    }
    return _consgneeButton;
}

- (UILabel*)consigneeLabel{
    if (_consigneeLabel==nil) {
        _consigneeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 40)];
        _consigneeLabel.text = @"收货信息";
        _consigneeLabel.backgroundColor = [UIColor whiteColor];
        _consigneeLabel.textColor = [UIColor blackColor];
        _consigneeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _consigneeLabel;
}
-(UILabel *)consigneeInfoShowLabel{
    if (_consigneeInfoShowLabel==nil) {
        _consigneeInfoShowLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
        _consigneeInfoShowLabel.text = @"请填写收货信息";
        _consigneeInfoShowLabel.textColor = [UIColor blackColor];
        
        _consigneeInfoShowLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _consigneeInfoShowLabel;
}
-(UIImageView *)waresShowImage
{
    
    if (_waresShowImage == nil)
    {
        self.waresShowImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 25, CGRectGetWidth(self.view.frame)/3- 24, 100)];
        self.waresShowImage.contentMode = UIViewContentModeScaleAspectFill;
        self.waresShowImage.clipsToBounds = YES;
    }
    return _waresShowImage;
}

-(UILabel *)waresTitleLable
{
    if (_waresTitleLable == nil)
    {
        self.waresTitleLable = [[UILabel alloc]initWithFrame:CGRectMake( CGRectGetMaxX(self.waresShowImage.frame)+10, 20, CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.waresShowImage.frame) - 50, 25)];
    }
    return _waresTitleLable;
}

-(UILabel *)unitpriceShowLable
{
    if (_unitpriceShowLable == nil)
    {
        self.unitpriceShowLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresShowImage.frame)+10, CGRectGetMaxY(self.waresTitleLable.frame) + 5, CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.waresShowImage.frame) - 60, 15)];
        self.unitpriceShowLable.textColor = [UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0];
        self.unitpriceShowLable.font = [UIFont systemFontOfSize:14];

    }
    return _unitpriceShowLable;
}

-(UILabel *)waresAmountLable
{
    if (_waresAmountLable == nil)
    {
        self.waresAmountLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresShowImage.frame) + 10, CGRectGetMaxY(self.buyWaresQuantity.frame) + 5, 65, 15)];
        self.waresAmountLable.textColor =  [UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0];
        self.waresAmountLable.font = [UIFont systemFontOfSize:13];
        self.waresAmountLable.text =@"剩余数量:";

    }
    return _waresAmountLable;
}

-(UILabel *)waresAmountShowLb
{
    if (_waresAmountShowLb == nil)
    {
        
        self.waresAmountShowLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresAmountLable.frame) , CGRectGetMaxY(self.buyWaresQuantity.frame) + 5, CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.waresShowImage.frame) - 60, 15)];
        self.waresAmountShowLb.textColor = [UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0];
        //self.targetAmountLable.backgroundColor = [UIColor yellowColor];
        self.waresAmountShowLb.font = [UIFont systemFontOfSize:14];
    }
    return _waresAmountShowLb;
}
- (UILabel*)buyWaresQuantity{
    if (_buyWaresQuantity==nil) {
        _buyWaresQuantity = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresShowImage.frame)+10,CGRectGetMaxY(self.unitpriceShowLable.frame), 100, 40)];
        _buyWaresQuantity.text = @"购买数量";
        _buyWaresQuantity.backgroundColor = [UIColor whiteColor];
        _buyWaresQuantity.textColor = [UIColor blackColor];
        _buyWaresQuantity.textAlignment = NSTextAlignmentLeft;
    }
    return _buyWaresQuantity;
}

//减少商品事件
-(void)reduceBtnAction:(UIButton *)sender{
    if ([self.mountLab.text integerValue] <= 1)
    {
        self.mountLab.text = @"1";
    }else{
        self.mountLab.text = [NSString stringWithFormat:@"%ld", [self.mountLab.text integerValue] - 1];
    }
    self.QuantityPrice.text = [NSString stringWithFormat:@"共%d件 %.2f¥",[self.mountLab.text intValue],[self.price floatValue]*[self.mountLab.text intValue]];

}
// 商品个数增加事件按钮
-(void)addBtnAction:(UIButton *)sender{
    
    self.mountLab.text = [NSString stringWithFormat:@"%ld", [self.mountLab.text integerValue] + 1];
    if ([self.mountLab.text intValue] >=[self.waresAmountShowLb.text integerValue]) {
        self.mountLab.text =  [NSString stringWithFormat:@"%ld",[self.waresAmountShowLb.text integerValue]];
    }
    self.QuantityPrice.text = [NSString stringWithFormat:@"共%d件 %.2f¥",[self.mountLab.text intValue],[self.price floatValue]*[self.mountLab.text intValue]];
}
//下单
- (void)xiadanToShangJia{

    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        // 组织上传数据信息
        OrderMessageToServer *orderMessage = [self orgernizeDataToServer];
        
        // 进行数据上传  把订单信息传回到服务器
        
        // 上传商品信息后服务器返回的数据
        // information   商品信息
        // orderno    订单号
        // price    价格
        // title    商品名称
        NSDictionary *toServerDic = [self p_orderMessageCallToServer:orderMessage];
        
        
        /*======================================*/
        /*========需要填写商户app申请的============*/
        /*======================================*/
        //合作ID
        NSString *partner = @"2088911227467632";
        //商户ID
        NSString *seller = @"3125369916@qq.com";
        //私钥
        NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMKA7ERagtbJDro9y/NuaufW75E/7qPDcmw7cFZo9mc47PDx2pM8bX0C/qdl+SBCaDNu9prGB9v1J8KYBuiT/F5i1ROsxnnQh/++u3iVpiSXvk1/2Vchp48Zt3LqxBY/qXhXTKWtMqq5aTXXBD6bW8q3e3WMGzdNKrj2TRpY3AfbAgMBAAECgYEAoSCSGZHtf6bxd2GIGjJnh4Wr0mTm+W0I1hZrWnn7Xclvp66DRqOxg/U+Jki4l3vLvIf47ICOtC2j8XVli7hEQC0t2+CZpao+aLKPGS3FXexv81VCJgjBqoKUFYYaEIYn5ms+Mlr3avSJ8gmS0fQMFIKJeXl06T4RvjWVB82znXkCQQD1qkxeHeBvNQdW9CDDOjBXnIXcWvp8V2LYoVUoCD99zmyQ5LlVYyHoCzkG+iuuwedH5IXpUdGxqPBWTQQfhvs9AkEAyq+jLlK2fj4tDpH/8DEUdjx6p7nHRO2zjNEG2RdQN+lP1xOSk5VRwJ5mpVLniM0Oeq9RqchN6u/Qil63ipgg9wJBALVOqm4LvshUasZSBpwPJf6DFog63QNHuzwGVcLl03YWEyocpGvQbgXDwqLTn8mqcfctQWehaxGjjT0kOhbKmEECQGWnYzsnZrm4K1bkaK2pn+6Q9J9McKGkaenVKA8XPzdbf5yKB3iXajIl/6spAlC9L2beqSFzAYk0D65mRL1xAQ8CQQCFONCnHnCR2xHIb+YDMz/XAsHqVaq+Z/8mDonOJFirbScwLU8gp54+3hesIF1+5Lxt8cWuvH49jWrBPqHloDAk";
        /*======================================*/
        /*======================================*/
        /*======================================*/
        
        Order *order = [[Order alloc] init];
        order.partner = partner;   // 合作身份者id
        order.seller = seller;     // 支付宝收款账号，手机号或者邮箱格式
        
        order.tradeNO = [self generateTradeNO];//订单号随机且不重复
        
        //order.tradeNO = [toServerDic objectForKey:@"orderno"]; //订单ID(由商家□自□行制定)
        
        order.productName = [toServerDic objectForKey:@"title"]; //商品标题
        order.productDescription = [toServerDic objectForKey:@"information"]; //商品描述
        order.amount = [toServerDic objectForKey:@"price"]; //商 品价格
        order.notifyURL = [NSString stringWithFormat:@"%@%@",myurl,@"/index.php/home/index/ailpayback.html"]; //回调URL
        order.service = @"mobile.securitypay.pay";
        // 支付类型。默认值为：1（商品购买）
        order.paymentType = @"1";
        order.inputCharset = @"utf-8";
        order.itBPay = @"30m";
        
        
        
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types NSString *appScheme = @"alisdkdemo";
        //将商品信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"orderSpec = %@",orderSpec);
        
        
        
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"LeYingAPP";
        
        
        
        //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
        id<DataSigner> signer = CreateRSADataSigner(privateKey);
        NSString *signedString = [signer signString:orderSpec];
        //将签名成功字符串格式化为订单字符串,请严格按照该格式 NSString *orderString = nil;
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];
        }
    }
}


#pragma mark =============生产随机订单号============
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

-(NSDictionary *)p_orderMessageCallToServer:(OrderMessageToServer *)sender
{
    // 准备数据
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",@"http://leying.hivipplus.com/index.php/home/index/orderadd.html"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    // 准备参数
    NSString *argument = [NSString stringWithFormat:@"buyactivitieid=%@&cardno=%@&username=%@&tel=%@&address=%@&goodsnum=%@&tomaijiamessage=%@",sender.buyactivitieid,sender.cardno,sender.username,sender.tel,sender.address,sender.goodsnum,sender.tomaijiamessage];
    NSData *argDada = [argument dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置URl参数
    [request setHTTPBody:argDada];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",[[dict objectForKey:@"datas"] objectForKey:@"error"]);
    
    return [dict objectForKey:@"datas"];
}


// 组织数据
-(OrderMessageToServer *)orgernizeDataToServer
{
    OrderMessageToServer *orderMessage = [[OrderMessageToServer alloc] init];
//    orderMessage.buyactivitieid = self.activeId;
//    orderMessage.cardno = self.ov.consigneeText.text;
//    orderMessage.username = @"";
//    orderMessage.tel = self.ov.phoneText.text;
//    orderMessage.address = self.ov.addressText.text;
//    orderMessage.goodsnum = self.ov.mountLab.text;
//    orderMessage.tomaijiamessage = self.ov.messageText.text;
    return orderMessage;
}

//填写收货信息代理方法
- (void)xuanzeConsgnee{
    
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
