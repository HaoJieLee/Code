//
//  TypeBiaoqinViewController.m
//  乐影
//
//  Created by zhaoHm on 16/3/22.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "TypeBiaoqinViewController.h"
#import "HMButton.h"

@interface TypeBiaoqinViewController ()

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) NSArray *totleArr;

@end

@implementation TypeBiaoqinViewController
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
    // Do any additional setup after loading the view.
    
    _count = 0;
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
    lblBiaoqian.text = @"选择标签";
    lblBiaoqian.textColor = [UIColor whiteColor];
    lblBiaoqian.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = lblBiaoqian;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
}

-(void)p_setRequestData
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",myurl,@"/artist/gettag"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.totleArr = [dict objectForKey:@"data"];
}

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
            if ([typeStr isEqualToString:@""] || pinCount == 4) {
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
    
    
    
    
    if (![typeStr isEqualToString:@""]) {
        [self.delegate passBiaoqian:typeStr];
        [self.delegate passBiaoqianId:idStr];
        // 返回
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        // 提醒
        [AlertShow alertShowWithContent:@"标签不能为空" Seconds:3];
    }
    
    
}

-(void)p_settingUpView
{
//    self.view.layer.contents = (id)[UIImage imageNamed:@"sybg.png"].CGImage;
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    self.prompView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, KScreenW, 50)];
    self.prompView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_prompView];
    
    self.lblPromp = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.prompView.frame), 40)];
    self.lblPromp.text = @"最多只能选择四种类型";
    self.lblPromp.textColor = [UIColor blackColor];
    [self.prompView addSubview:_lblPromp];

    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.prompView.frame), CGRectGetWidth(self.prompView.frame), 300)];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bottomView];
 
    CGFloat btnW = 100;
    CGFloat btnH = 50;
    CGFloat paddingX = (KScreenW - (3 * btnW)) / 4;
    CGFloat paddingY = 20;
    for (int i = 0; i < self.totleArr.count; i++) {
        CGFloat btnX = paddingX + (btnW + paddingX) * (i % 3);
        CGFloat btnY = paddingY + (btnH + paddingY) * (i / 3);
        HMButton *btn = [HMButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        btn.tag = i + 100;
        btn.layer.cornerRadius = 15;
   
                // 初始化所有的按钮都是未选中状态
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.isSelected = NO;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[self.totleArr[i] objectForKey:@"title"] forState:UIControlStateNormal];
        btn.tag = [[self.totleArr[i] objectForKey:@"id"] integerValue] + 100;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
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
        sender.isSelected = YES;
        _count ++;
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
