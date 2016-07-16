//
//  DropDownListView.m
//  xntz
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 surf. All rights reserved.
//

#import "DropDownListView.h"

#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

@implementation DropDownListView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (id)initAndWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id)delegate{
    
    self = [super initWithFrame:frame];
    if (self) {
  
        self.TermName     = [[UIButton alloc]init];
        self.ChaptersName = [[UIButton alloc]init];
        self.backgroundColor = [UIColor clearColor];
        self.currentExtendSection = -1;
        self.dropDownDataSource = delegate;
        self.dropDownDelegate   = datasource;
        NSInteger sectionNum = 0;
        if ([self.dropDownDataSource respondsToSelector:@selector(numberOfSections)]) {
            sectionNum = [self.dropDownDataSource numberOfSections];
        }
        if (sectionNum == 0) {
            self = nil;
        }
        //初始化默认显示view
        CGFloat sectionWidth = (1.0*(frame.size.width)/sectionNum);
        for (NSInteger i = 0; i <sectionNum; i++) {
            //课程知识点按钮选项位置
            if (i == 0) {
                [self addButton:self.TermName index:i width:sectionWidth];
            }else{
                [self addButton:self.ChaptersName index:i width:sectionWidth];
            }
        }
    }
    return self;
}
- (void)addButton:(UIButton *)button index:(NSInteger)i width:(CGFloat)sectionWidth{
    button = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth*i+5, 5, sectionWidth-5, self.frame.size.height)];
    
    button.tag = SECTION_BUT_TAG+i;
//    button.layer.borderWidth = 1;
//    [button.layer setBackgroundColor:(CGColorRef)[UIColor orangeColor]];
    [button addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
   button.backgroundColor = [UIColor whiteColor];
    //按钮标题
    NSString *sectionBtnTitle = [[NSString alloc]init];
    
    if ([self.dropDownDataSource respondsToSelector:@selector(titleInSection:index:)]) {
        sectionBtnTitle = [self.dropDownDataSource titleInSection:i index:[self.dropDownDataSource defaultShowSection:i]];
    }
    [button  setTitle:sectionBtnTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:button];
    UIImageView *sectionBtnIv = [[UIImageView alloc] initWithFrame:CGRectMake(sectionWidth*i +(sectionWidth - 16), (self.frame.size.height-12)/2, 12, 12)];
    [sectionBtnIv setImage:[UIImage imageNamed:@"down_dark.png"]];
    [sectionBtnIv setContentMode:UIViewContentModeScaleToFill];
    sectionBtnIv.tag = SECTION_IN_TAG + i;
    [self addSubview: sectionBtnIv];

}
- (void)sectionBtnTouch:(UIButton *)button{
    
    NSInteger sectionButton = button.tag - SECTION_BUT_TAG;
    UIImageView *currentIV= (UIImageView *)[self viewWithTag:(SECTION_IN_TAG +self.currentExtendSection)];
    
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
    }];
    
    if (self.currentExtendSection == sectionButton) {
        [self hideExtendedChooseView];
    }else{
        self.currentExtendSection = sectionButton;
        currentIV = (UIImageView *)[self viewWithTag:SECTION_IN_TAG + self.currentExtendSection];
        [UIView animateWithDuration:0.3 animations:^{
            currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
        }];
        [self showChooseListViewInSection:self.currentExtendSection choosedIndex:[self.dropDownDataSource defaultShowSection:self.currentExtendSection]];
    }
}
- (void)setTitle:(NSString *)title inSection:(NSInteger) section
{
    UIButton *btn = (id)[self viewWithTag:SECTION_BUT_TAG +section];
    [btn setTitle:title forState:UIControlStateNormal];
}

- (BOOL)isShow
{
    if (self.currentExtendSection == -1) {
        return NO;
    }
    return YES;
}
-  (void)hideExtendedChooseView
{
    if (self.currentExtendSection != -1) {
        self.currentExtendSection = -1;
        CGRect rect = self.mTableView.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.mTableBaseView.alpha = 1.0f;
            self.mTableView.alpha = 1.0f;
            
            self.mTableBaseView.alpha = 0.2f;
            self.mTableView.alpha = 0.2;
            
            self.mTableView.frame = rect;
        }completion:^(BOOL finished) {
            [self.mTableView removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
        }];
    }
}

-(void)showChooseListViewInSection:(NSInteger)section choosedIndex:(NSInteger)index
{
    if (!self.mTableView) {
        self.mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height , self.mSuperView.frame.size.width, self.mSuperView.frame.size.height)];
        self.mTableBaseView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [self.mTableBaseView addGestureRecognizer:bgTap];
        self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width , 240) style:UITableViewStylePlain];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        self.mTableView.bounces = NO;
    }
    
    //修改tableview的frame
    int sectionWidth = (self.frame.size.width)/[self.dropDownDataSource numberOfSections];
    CGRect rect = self.mTableView.frame;
    rect.origin.x = sectionWidth *section + 5;
    rect.size.width = sectionWidth - 5;
    rect.size.height = 0;
    self.mTableView.frame = rect;
    [self.mSuperView addSubview:self.mTableBaseView];
    [self.mSuperView addSubview:self.mTableView];
         
    //动画设置位置
    NSInteger nuber = [self.dropDownDataSource numberOfRowsInSection:section];
    if (nuber>=7) {
        rect .size.height = 240;
    }
    else{
        rect .size.height = nuber*40;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.mTableBaseView.alpha = 0.2;
        self.mTableView.alpha = 0.2;
        
        self.mTableBaseView.alpha = 1.0;
        self.mTableView.alpha = 1.0;
        self.mTableView.frame =  rect;
    }];
    [self.mTableView reloadData];
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap
{
    [self resumeImagePlace];
    
}
- (void)resumeImagePlace{
    UIImageView *currentIV = (UIImageView *)[self viewWithTag:(SECTION_IN_TAG + self.currentExtendSection)];
    [UIView animateWithDuration:0.3 animations:^{
        currentIV.transform = CGAffineTransformRotate(currentIV.transform, DEGREES_TO_RADIANS(180));
        [self hideExtendedChooseView];
    }];

}
#pragma mark -- UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    
    if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:)]) {
        NSString *chooseCellTitle = [self.dropDownDataSource titleInSection:self.currentExtendSection index:indexPath.row];
        UIButton *currentSectionBtn = (UIButton *)[self viewWithTag:SECTION_BUT_TAG + self.currentExtendSection];
        [currentSectionBtn setTitle:chooseCellTitle forState:UIControlStateNormal];
        
        [self.dropDownDelegate chooseAtSection:self.currentExtendSection index:indexPath.row];
        
        [self resumeImagePlace];
    }
}

#pragma mark -- UITableView DataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dropDownDataSource numberOfRowsInSection:self.currentExtendSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [self.dropDownDataSource titleInSection:self.currentExtendSection index:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
