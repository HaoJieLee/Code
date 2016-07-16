//
//  SubDataTableViewController.m
//  乐影
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "SubDataTableViewController.h"
#import "SubTableViewDataChangeViewController.h"

@interface SubDataTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation SubDataTableViewController

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.dataSourceTitle = [[NSMutableArray alloc] init];//首先初始化数组,防止崩溃;
        [self drawTableViewWithFrame:frame];
    }
    return self;
}
-(void)drawTableViewWithFrame:(CGRect)frame{
//    初始化tablView;
    self.dataTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.dataTableView.bounces = NO;
    [self.dataTableView setDelegate:self];
    [self.dataTableView setDataSource:self];
    [self.view addSubview:self.dataTableView];
}
- (NSMutableDictionary * )dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary new];
    }
    return _dataSource;
}

#pragma mark ------

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSourceTitle.count;
}
/***/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_dataSourceTitle objectAtIndex:section] count]; //
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

//    字典比较保险
    NSDictionary * cellSelectDic = @{@"昵称":@(0),@"类型":@(1),@"标签":@(2),@"身份认证":@(3),@"身高":@(4),@"体重":@(5),@"三围":@(6),@"鞋码":@(7),@"手机号码":@(8),@"微信":@(9),@"QQ":@(10),@"邮箱":@(11),@"签名":@(12),@"简介":@(13)};
    
//    NSArray * cellSelectArr = @[@"昵称",@"类型",@"标签",@"身份认证",@"身高",@"体重",@"三围",@"鞋码",@"手机号码",@"微信",@"QQ",,@"邮箱",@"签名",@"简介"];
    
    if (cellSelectDic[cell.textLabel.text]) {
//        如果字典中有的话,跳转子视图,并传入Value,
//        Value 在子视图中是枚举,进入视图不同的样式,
        SubTableViewDataChangeViewController * VC = [[SubTableViewDataChangeViewController alloc] initWith:[cellSelectDic[cell.textLabel.text] intValue]];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"dataTableViewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];//设置cell样式
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置cell右边箭头

        NSString * cellTitleStr = _dataSourceTitle[indexPath.section][indexPath.row];//获取数组中的前置标题字符;后面有判断;
        [cell.textLabel setText:cellTitleStr];//设置前置标题
        [cell.detailTextLabel setText:@"test"];//设置后置标题
        
        if ([cellTitleStr isEqualToString:@"性别"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;//设置cell右边箭头 关闭;
        }
        if([cellTitleStr isEqualToString:@"影红号"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;//设置cell右边箭头 关闭;
        }
    }
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"222");
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"111");
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"3333");
}
@end
