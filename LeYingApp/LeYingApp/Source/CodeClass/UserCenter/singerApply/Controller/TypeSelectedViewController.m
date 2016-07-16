//
//  TypeSelectedViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/21.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "TypeSelectedViewController.h"
#import "HMButton.h"

@interface TypeSelectedViewController ()<UIAlertViewDelegate>

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) NSArray *totleArr;

// 父级和子级一共有多少
@property (nonatomic,strong) NSMutableArray *typeArray;//艺人类型数组
@property (nonatomic,strong)NSMutableArray *gewuArrray;//歌舞数组
@property (nonatomic,strong)NSMutableArray *moteArray;//模特数组



@end

@implementation TypeSelectedViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)setAllArray{
    self.typeArray = [NSMutableArray array];
    self.gewuArrray = [NSMutableArray array];
    self.moteArray = [NSMutableArray array];
     self.count = 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAllArray];
    
   

    if (![[IsHaveNetwork shareIsHaveNetwork] isConnectionAvailable])
    {
        [[IsHaveNetwork shareIsHaveNetwork] alertViewForNetworkWithBase:self.view];
    }
    else
    {
        [self p_setRequestData];
        
        [self p_settingUpView];
    }
   
    

    
    UILabel *lblBiaoqian = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblBiaoqian.text = @"选择类型";
    lblBiaoqian.textColor = [UIColor whiteColor];
    lblBiaoqian.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = lblBiaoqian;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
}

#pragma mark 请求数据
-(void)p_setRequestData
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/artist/getcategory"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //分类数据处理
    for (int i = 1; i<= 13; i++) {
         NSDictionary *dictionary = [NSDictionary new];
        if (i <=8) {
            dictionary = [[[dict objectForKey:@"data"]objectForKey:@"0"] objectForKey:[NSString stringWithFormat:@"%d",i]];
            [self.typeArray addObject:dictionary];
        }else if ((i>=9)&&(i<=10)){
            dictionary = [[[dict objectForKey:@"data"]objectForKey:@"2"] objectForKey:[NSString stringWithFormat:@"%d",i]];
            [self.gewuArrray addObject:dictionary];
        }else{
            dictionary = [[[dict objectForKey:@"data"]objectForKey:@"5"] objectForKey:[NSString stringWithFormat:@"%d",i]];
            [self.moteArray addObject:dictionary];
        }
   
    }
    NSLog(@"%ld",self.typeArray.count);
}
#pragma mark 数据保存 回传
/// 保存
-(void)rightBarButtonAction
{
    // 保存 反向传值
    NSString *typeStr = @"";
    NSString *idStr = @"";
    NSInteger pinCount = 0;
    // 遍历找到选中的类型
    NSArray *arr = [self.bottomView subviews];
    for (HMButton *btn in arr) {
        if (btn.isSelected) {
            if ([typeStr isEqualToString:@""] || pinCount == 3) {
                typeStr = [typeStr stringByAppendingString:btn.currentTitle];
                idStr = [NSString stringWithFormat:@"%ld",(long)btn.tag - 100];
            }
            else
            {
                typeStr = [NSString stringWithFormat:@"%@-",typeStr];
                typeStr = [typeStr stringByAppendingString:btn.currentTitle];
                idStr = [NSString stringWithFormat:@"%@,",idStr];
                idStr = [idStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)btn.tag - 100]];
            }
            pinCount ++;
        }
    }
    NSString *newIdStr = @"";
    NSArray *myarry = [idStr componentsSeparatedByString:@","];
    for (int i = 0; i < myarry.count; i++) {
        for (int j = 0; j < _totleArr.count; j++) {
            if ([[NSString stringWithFormat:@"%@",myarry[i]] isEqualToString:[NSString stringWithFormat:@"%@",[_totleArr[j] objectForKey:@"id"]]]) {
                // 判断是否存在父级
                if ([_totleArr[j] objectForKey:@"fujiid"] == nil) {
                    // 不存在父级id
                    if ([newIdStr isEqualToString:@""]) {
                        // 空
                        newIdStr = [NSString stringWithFormat:@"%@",myarry[i]];
                    }
                    else
                    {
                        // 非空
                        newIdStr = [NSString stringWithFormat:@"%@-",newIdStr];
                        newIdStr = [newIdStr stringByAppendingString:myarry[i]];
                    }
                }
                else
                {
                    // 存在父级id
                    if ([newIdStr isEqualToString:@""]) {
                        // 空
                        // 子级|父级
                        newIdStr = [NSString stringWithFormat:@"%@|%@",myarry[i],[_totleArr[j] objectForKey:@"fujiid"]];
                    }
                    else
                    {
                        // 非空
                        newIdStr = [NSString stringWithFormat:@"%@-",newIdStr];
                        newIdStr = [newIdStr stringByAppendingString:[NSString stringWithFormat:@"%@|%@",myarry[i],[_totleArr[j] objectForKey:@"fujiid"]]];
                    }
                }
            }
        }
    }
    NSLog(@"%@",newIdStr);
    NSMutableArray *ddar = [NSMutableArray array];
    for (NSString *dsstr in [newIdStr componentsSeparatedByString:@"|"]) {
        if ([dsstr rangeOfString:@"-"].location != NSNotFound) {
            // 含有-字符
            NSArray *fenzuarr = [dsstr componentsSeparatedByString:@"-"];
            NSMutableDictionary *dddic = [NSMutableDictionary dictionary];
            [dddic setObject:fenzuarr[0] forKey:@"child"];
            [dddic setObject:fenzuarr[1] forKey:@"parent"];
            [ddar addObject:dddic];
        }
        else
        {
            // 没有-字符
            NSMutableDictionary *dddic = [NSMutableDictionary dictionary];
            [dddic setObject:dsstr forKey:@"parent"];
            [ddar addObject:dddic];
        }
    }
    if (![typeStr isEqualToString:@""]) {
        [self.delegate passType:typeStr];
//        [self.delegate passtypeId:[self stringToArray:newIdStr]];
        [self.delegate passtypeId:ddar];
        // 返回
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        // 提醒
        [AlertShow alertShowWithContent:@"类型不能为空" Seconds:3];
    }
    
    
    
}

// 组织数据 把字符串转换为数组
-(NSArray *)stringToArray:(NSString *)strId
{
    NSMutableArray *returnMutableArr = [NSMutableArray array];
    NSArray *arr = [strId componentsSeparatedByString:@"-"];
    for (NSString *ss in arr) {
        // 判断是否包含父级
        if ([self isHaveAChar:@"|" InString:ss]) {
            // 包含父级
            NSArray *zijiArr = [ss componentsSeparatedByString:@"|"];
            NSMutableDictionary *fuji = [NSMutableDictionary dictionary];
            [fuji setObject:[zijiArr lastObject] forKey:@"parent"];
            for (int i = 0; i < zijiArr.count - 1; i++) {
                [fuji setObject:zijiArr[i] forKey:@"child"];
            }
            [returnMutableArr addObject:fuji];
        }
        else
        {
            // 不包含父级
            NSMutableDictionary *fuji = [NSMutableDictionary dictionary];
            [fuji setObject:ss forKey:@"parent"];
            [returnMutableArr addObject:fuji];
        }
    }
    NSLog(@"%@",returnMutableArr);
    return returnMutableArr;
}

// 判断字符串中是否包含某个字符
-(BOOL)isHaveAChar:(NSString *)str InString:(NSString *)Mystr
{
    if ([Mystr rangeOfString:str].location != NSNotFound) {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark 布局
-(void)p_settingUpView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    self.prompView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, KScreenW, 50)];
    self.prompView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_prompView];
    
    self.lblPromp = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.prompView.frame), 40)];
    self.lblPromp.text = @"请选择类型(最多四个)";
    self.lblPromp.textColor = [UIColor blackColor];
    self.lblPromp.backgroundColor = [UIColor clearColor];
    [self.prompView addSubview:_lblPromp];
    
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.prompView.frame), CGRectGetWidth(self.prompView.frame), 300)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomView];
    
    
    
    CGFloat btnW = 100;
    CGFloat btnH = 50;
    CGFloat paddingX = (KScreenW - (3 * btnW)) / 4;
    CGFloat paddingY = 20;
    for (int i = 0; i < self.typeArray.count+self.moteArray.count; i++) {
            CGFloat btnX = paddingX + (btnW + paddingX) * (i % 3);
            CGFloat btnY = paddingY + (btnH + paddingY) * (i / 3);
            HMButton *btn = [HMButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.layer.cornerRadius = 15;
            btn.backgroundColor = [UIColor whiteColor];
        if (i==1) {
            NSString *title = [NSString stringWithFormat:@"%@.%@",[self.typeArray[1] objectForKey:@"title"],[[self.gewuArrray objectAtIndex:0] objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.gewuArrray[0] objectForKey:@"id"] integerValue];
        }else if (i==2){
            NSString *title = [NSString stringWithFormat:@"%@.%@",[self.typeArray[1] objectForKey:@"title"],[[self.gewuArrray objectAtIndex:1]objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.gewuArrray[1] objectForKey:@"id"] integerValue];
        }else if ((i>=3)&&(i<=4)){
            NSString *title = [NSString stringWithFormat:@"%@",[self.typeArray[i-1] objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.typeArray[i-1] objectForKey:@"id"] integerValue];
        }else if (i==5){
            NSString *title = [NSString stringWithFormat:@"%@.%@",[self.typeArray[4] objectForKey:@"title"],[[self.moteArray objectAtIndex:0]objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.moteArray[0] objectForKey:@"id"] integerValue];
        }else if (i==6){
            NSString *title = [NSString stringWithFormat:@"%@.%@",[self.typeArray[4] objectForKey:@"title"],[[self.moteArray objectAtIndex:0]objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.moteArray[1] objectForKey:@"id"] integerValue];
        }else if (i==7){
            NSString *title = [NSString stringWithFormat:@"%@.%@",[self.typeArray[4] objectForKey:@"title"],[[self.moteArray objectAtIndex:0]objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.moteArray[2] objectForKey:@"id"] integerValue];
        }else if(i>=8){
            NSString *title = [NSString stringWithFormat:@"%@",[self.typeArray[i-3] objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.typeArray[i-5] objectForKey:@"id"] integerValue];
        }else{
            NSString *title = [NSString stringWithFormat:@"%@",[self.typeArray[i] objectForKey:@"title"]];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.tag = 100 + [[self.typeArray[i] objectForKey:@"id"] integerValue];
        }
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.bottomView addSubview:btn];
        
    }
}
-(void)btnAction:(HMButton *)sender
{
    if (self.count < 4 || sender.isSelected == YES) {
        switch (sender.tag) {
            case 100:
                [self p_setBackGroundColor:sender];
                break;
            case 101:
                [self p_setBackGroundColor:sender];
                break;
            case 102:
                [self p_setBackGroundColor:sender];
                break;
            case 103:
                [self p_setBackGroundColor:sender];
                break;
            case 104:
                [self p_setBackGroundColor:sender];
                break;
            case 105:
                [self p_setBackGroundColor:sender];
                break;
            case 106:
                [self p_setBackGroundColor:sender];
                break;
            case 107:
                [self p_setBackGroundColor:sender];
                break;
            case 108:
                [self p_setBackGroundColor:sender];
                break;
            case 109:
                [self p_setBackGroundColor:sender];
                break;
            case 110:
                [self p_setBackGroundColor:sender];
                break;
            case 111:
                [self p_setBackGroundColor:sender];
                break;
            case 112:
                [self p_setBackGroundColor:sender];
                break;
            case 113:
                [self p_setBackGroundColor:sender];
                break;
            case 114:
                [self p_setBackGroundColor:sender];
                break;
            case 115:
                [self p_setBackGroundColor:sender];
                break;
            case 116:
                [self p_setBackGroundColor:sender];
                break;
            case 117:
                [self p_setBackGroundColor:sender];
                break;
            case 118:
                [self p_setBackGroundColor:sender];
                break;
            case 119:
                [self p_setBackGroundColor:sender];
                break;
            case 120:
                [self p_setBackGroundColor:sender];
                break;
            case 121:
                [self p_setBackGroundColor:sender];
                break;
            case 122:
                [self p_setBackGroundColor:sender];
                break;
            case 123:
                [self p_setBackGroundColor:sender];
                break;
            case 124:
                [self p_setBackGroundColor:sender];
                break;
            case 125:
                [self p_setBackGroundColor:sender];
                break;
            case 126:
                [self p_setBackGroundColor:sender];
                break;
            case 127:
                [self p_setBackGroundColor:sender];
                break;
            case 128:
                [self p_setBackGroundColor:sender];
                break;
            case 129:
                [self p_setBackGroundColor:sender];
                break;
            case 130:
                [self p_setBackGroundColor:sender];
                break;
            case 131:
                [self p_setBackGroundColor:sender];
                break;
            case 132:
                [self p_setBackGroundColor:sender];
                break;
            case 133:
                [self p_setBackGroundColor:sender];
                break;
            case 134:
                [self p_setBackGroundColor:sender];
                break;
            case 135:
                [self p_setBackGroundColor:sender];
                break;
            case 136:
                [self p_setBackGroundColor:sender];
                break;
            case 137:
                [self p_setBackGroundColor:sender];
                break;
            case 138:
                [self p_setBackGroundColor:sender];
                break;
            case 139:
                [self p_setBackGroundColor:sender];
                break;
            case 140:
                [self p_setBackGroundColor:sender];
                break;
            case 141:
                [self p_setBackGroundColor:sender];
                break;
            case 142:
                [self p_setBackGroundColor:sender];
                break;
            case 143:
                [self p_setBackGroundColor:sender];
                break;
            case 144:
                [self p_setBackGroundColor:sender];
                break;
            case 145:
                [self p_setBackGroundColor:sender];
                break;
            case 146:
                [self p_setBackGroundColor:sender];
                break;
            case 147:
                [self p_setBackGroundColor:sender];
                break;
            case 148:
                [self p_setBackGroundColor:sender];
                break;
            case 149:
                [self p_setBackGroundColor:sender];
                break;
            case 150:
                [self p_setBackGroundColor:sender];
                break;
            case 151:
                [self p_setBackGroundColor:sender];
                break;
            case 152:
                [self p_setBackGroundColor:sender];
                break;
            case 153:
                [self p_setBackGroundColor:sender];
                break;
            case 154:
                [self p_setBackGroundColor:sender];
                break;
            case 155:
                [self p_setBackGroundColor:sender];
                break;
            case 156:
                [self p_setBackGroundColor:sender];
                break;
            case 157:
                [self p_setBackGroundColor:sender];
                break;
            case 158:
                [self p_setBackGroundColor:sender];
                break;
            case 159:
                [self p_setBackGroundColor:sender];
                break;
            case 160:
                [self p_setBackGroundColor:sender];
                break;
            case 161:
                [self p_setBackGroundColor:sender];
                break;
            case 162:
                [self p_setBackGroundColor:sender];
                break;
            case 163:
                [self p_setBackGroundColor:sender];
                break;
            case 164:
                [self p_setBackGroundColor:sender];
                break;
            case 165:
                [self p_setBackGroundColor:sender];
                break;
            case 166:
                [self p_setBackGroundColor:sender];
                break;
            case 167:
                [self p_setBackGroundColor:sender];
                break;
            case 168:
                [self p_setBackGroundColor:sender];
                break;
            case 169:
                [self p_setBackGroundColor:sender];
                break;
            case 170:
                [self p_setBackGroundColor:sender];
                break;
            case 171:
                [self p_setBackGroundColor:sender];
                break;
            case 172:
                [self p_setBackGroundColor:sender];
                break;
            case 173:
                [self p_setBackGroundColor:sender];
                break;
            case 174:
                [self p_setBackGroundColor:sender];
                break;
            case 175:
                [self p_setBackGroundColor:sender];
                break;
            case 176:
                [self p_setBackGroundColor:sender];
                break;
            case 177:
                [self p_setBackGroundColor:sender];
                break;
            case 178:
                [self p_setBackGroundColor:sender];
                break;
            case 179:
                [self p_setBackGroundColor:sender];
                break;
            case 180:
                [self p_setBackGroundColor:sender];
                break;
            case 181:
                [self p_setBackGroundColor:sender];
                break;
            case 182:
                [self p_setBackGroundColor:sender];
                break;
            case 183:
                [self p_setBackGroundColor:sender];
                break;
            case 184:
                [self p_setBackGroundColor:sender];
                break;
            case 185:
                [self p_setBackGroundColor:sender];
                break;
            case 186:
                [self p_setBackGroundColor:sender];
                break;
            case 187:
                [self p_setBackGroundColor:sender];
                break;
            case 188:
                [self p_setBackGroundColor:sender];
                break;
            case 189:
                [self p_setBackGroundColor:sender];
                break;
            case 190:
                [self p_setBackGroundColor:sender];
                break;
            case 191:
                [self p_setBackGroundColor:sender];
                break;
            case 192:
                [self p_setBackGroundColor:sender];
                break;
            case 193:
                [self p_setBackGroundColor:sender];
                break;
            case 194:
                [self p_setBackGroundColor:sender];
                break;
            case 195:
                [self p_setBackGroundColor:sender];
                break;
            case 196:
                [self p_setBackGroundColor:sender];
                break;
            case 197:
                [self p_setBackGroundColor:sender];
                break;
            case 198:
                [self p_setBackGroundColor:sender];
                break;
            case 199:
                [self p_setBackGroundColor:sender];
                break;
            case 200:
                [self p_setBackGroundColor:sender];
                break;
            case 201:
                [self p_setBackGroundColor:sender];
                break;
            case 202:
                [self p_setBackGroundColor:sender];
                break;
            case 203:
                [self p_setBackGroundColor:sender];
                break;
            case 204:
                [self p_setBackGroundColor:sender];
                break;
            case 205:
                [self p_setBackGroundColor:sender];
                break;
            case 206:
                [self p_setBackGroundColor:sender];
                break;
            case 207:
                [self p_setBackGroundColor:sender];
                break;
            case 208:
                [self p_setBackGroundColor:sender];
                break;
            case 209:
                [self p_setBackGroundColor:sender];
                break;
            case 210:
                [self p_setBackGroundColor:sender];
                break;
            case 211:
                [self p_setBackGroundColor:sender];
                break;
            case 212:
                [self p_setBackGroundColor:sender];
                break;
            case 213:
                [self p_setBackGroundColor:sender];
                break;
            case 214:
                [self p_setBackGroundColor:sender];
                break;
            case 215:
                [self p_setBackGroundColor:sender];
                break;
            case 216:
                [self p_setBackGroundColor:sender];
                break;
            case 217:
                [self p_setBackGroundColor:sender];
                break;
            case 218:
                [self p_setBackGroundColor:sender];
                break;
            case 219:
                [self p_setBackGroundColor:sender];
                break;
            case 220:
                [self p_setBackGroundColor:sender];
                break;
            case 221:
                [self p_setBackGroundColor:sender];
                break;
            case 222:
                [self p_setBackGroundColor:sender];
                break;
            case 223:
                [self p_setBackGroundColor:sender];
                break;
            case 224:
                [self p_setBackGroundColor:sender];
                break;
            case 225:
                [self p_setBackGroundColor:sender];
                break;
            case 226:
                [self p_setBackGroundColor:sender];
                break;
            case 227:
                [self p_setBackGroundColor:sender];
                break;
            case 228:
                [self p_setBackGroundColor:sender];
                break;
            case 229:
                [self p_setBackGroundColor:sender];
                break;
            case 230:
                [self p_setBackGroundColor:sender];
                break;
            case 231:
                [self p_setBackGroundColor:sender];
                break;
            case 232:
                [self p_setBackGroundColor:sender];
                break;
            case 233:
                [self p_setBackGroundColor:sender];
                break;
            case 234:
                [self p_setBackGroundColor:sender];
                break;
            case 235:
                [self p_setBackGroundColor:sender];
                break;
            case 236:
                [self p_setBackGroundColor:sender];
                break;
            case 237:
                [self p_setBackGroundColor:sender];
                break;
            case 238:
                [self p_setBackGroundColor:sender];
                break;
            case 239:
                [self p_setBackGroundColor:sender];
                break;
            case 240:
                [self p_setBackGroundColor:sender];
                break;
            case 241:
                [self p_setBackGroundColor:sender];
                break;
            case 242:
                [self p_setBackGroundColor:sender];
                break;
            case 243:
                [self p_setBackGroundColor:sender];
                break;
            case 244:
                [self p_setBackGroundColor:sender];
                break;
            case 245:
                [self p_setBackGroundColor:sender];
                break;
            case 246:
                [self p_setBackGroundColor:sender];
                break;
            case 247:
                [self p_setBackGroundColor:sender];
                break;
            case 248:
                [self p_setBackGroundColor:sender];
                break;
            case 249:
                [self p_setBackGroundColor:sender];
                break;
            case 250:
                [self p_setBackGroundColor:sender];
                break;
            case 251:
                [self p_setBackGroundColor:sender];
                break;
            case 252:
                [self p_setBackGroundColor:sender];
                break;
            case 253:
                [self p_setBackGroundColor:sender];
                break;
            case 254:
                [self p_setBackGroundColor:sender];
                break;
            case 255:
                [self p_setBackGroundColor:sender];
                break;
            case 256:
                [self p_setBackGroundColor:sender];
                break;
            case 257:
                [self p_setBackGroundColor:sender];
                break;
            case 258:
                [self p_setBackGroundColor:sender];
                break;
            case 259:
                [self p_setBackGroundColor:sender];
                break;
            case 260:
                [self p_setBackGroundColor:sender];
                break;
            case 261:
                [self p_setBackGroundColor:sender];
                break;
            case 262:
                [self p_setBackGroundColor:sender];
                break;
            case 263:
                [self p_setBackGroundColor:sender];
                break;
            case 264:
                [self p_setBackGroundColor:sender];
                break;
            case 265:
                [self p_setBackGroundColor:sender];
                break;
            case 266:
                [self p_setBackGroundColor:sender];
                break;
            case 267:
                [self p_setBackGroundColor:sender];
                break;
            case 268:
                [self p_setBackGroundColor:sender];
                break;
            case 269:
                [self p_setBackGroundColor:sender];
                break;
            case 270:
                [self p_setBackGroundColor:sender];
                break;
            case 271:
                [self p_setBackGroundColor:sender];
                break;
            case 272:
                [self p_setBackGroundColor:sender];
                break;
            case 273:
                [self p_setBackGroundColor:sender];
                break;
            case 274:
                [self p_setBackGroundColor:sender];
                break;
            case 275:
                [self p_setBackGroundColor:sender];
                break;
            case 276:
                [self p_setBackGroundColor:sender];
                break;
            case 277:
                [self p_setBackGroundColor:sender];
                break;
            case 278:
                [self p_setBackGroundColor:sender];
                break;
            case 279:
                [self p_setBackGroundColor:sender];
                break;
            case 280:
                [self p_setBackGroundColor:sender];
                break;
            case 281:
                [self p_setBackGroundColor:sender];
                break;
            case 282:
                [self p_setBackGroundColor:sender];
                break;
            case 283:
                [self p_setBackGroundColor:sender];
                break;
            case 284:
                [self p_setBackGroundColor:sender];
                break;
            case 285:
                [self p_setBackGroundColor:sender];
                break;
            case 286:
                [self p_setBackGroundColor:sender];
                break;
            case 287:
                [self p_setBackGroundColor:sender];
                break;
            case 288:
                [self p_setBackGroundColor:sender];
                break;
            case 289:
                [self p_setBackGroundColor:sender];
                break;
            case 290:
                [self p_setBackGroundColor:sender];
                break;
            case 291:
                [self p_setBackGroundColor:sender];
                break;
            case 292:
                [self p_setBackGroundColor:sender];
                break;
            case 293:
                [self p_setBackGroundColor:sender];
                break;
            case 294:
                [self p_setBackGroundColor:sender];
                break;
            case 295:
                [self p_setBackGroundColor:sender];
                break;
            case 296:
                [self p_setBackGroundColor:sender];
                break;
            case 297:
                [self p_setBackGroundColor:sender];
                break;
            case 298:
                [self p_setBackGroundColor:sender];
                break;
            case 299:
                [self p_setBackGroundColor:sender];
                break;
            case 300:
                [self p_setBackGroundColor:sender];
                break;
            default:
                break;
        }
    }
    else
    {
        // 选择标签个数超过三个
    }
}


-(void)p_setBackGroundColor:(HMButton *)sender
{
    UIColor *selectBackColor = [UIColor colorWithRed:83/ 255.0 green:90 / 255.0 blue:89/ 255.0 alpha:0.6];
    UIColor *normolBackColor = [UIColor whiteColor];
    if (sender.isSelected) {
        /// 已经选中过了  取消选中状态
        [sender setBackgroundColor:normolBackColor];
        sender.isSelected = NO;
        _count --;
    }
    else
    {
        /// 有被选中   选中它
        [sender setBackgroundColor:selectBackColor];
        if (sender.tag == 102) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"子类型" message:@"请选择类型" delegate:self cancelButtonTitle:nil otherButtonTitles:[[self.gewuArrray objectAtIndex:0] objectForKey:@"title"],[[self.gewuArrray objectAtIndex:1] objectForKey:@"title"], nil];
            alert.tag = 10;
            [alert show];
        }
        
        sender.isSelected = YES;
        _count ++;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
