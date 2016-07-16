//
//  DropDownListView.h
//  xntz
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 surf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"

#define SECTION_BUT_TAG 1000
#define SECTION_IN_TAG 2000
@interface DropDownListView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)id <DropDownChooseDelegate> dropDownDelegate;
@property (nonatomic,assign)id <DropDownChooseDataSource> dropDownDataSource;
/**当前展示的分组，默认-1时都没有展开*/
@property (nonatomic)NSInteger currentExtendSection;
/***/
@property (nonatomic,strong)UIView      *mSuperView;
/**蒙版View*/
@property (nonatomic,strong)UIView      *mTableBaseView;
/**展示课程和知识点的TableView*/
@property (nonatomic,strong)UITableView *mTableView;
/**学期*/
@property (nonatomic,strong)UIButton *TermName;
/**章节*/
@property (nonatomic,strong)UIButton *ChaptersName;

- (id)initAndWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id)delegate;

- (void)setTitle:(NSString *)title inSection:(NSInteger)section;
- (BOOL)isShow;
- (void)hideExtendedChooseView;

@end
