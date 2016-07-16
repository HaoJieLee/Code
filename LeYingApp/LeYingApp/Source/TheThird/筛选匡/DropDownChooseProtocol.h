//
//  DropDownChooseProtocol.h
//  xntz
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 surf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DropDownChooseDelegate <NSObject>

@optional
/**选择了哪个cell*/
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index;
@end
@protocol DropDownChooseDataSource <NSObject>
/**有多少个分组*/
-(NSInteger)numberOfSections;
/**每组有多少行*/
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
/**选择cell后button的标题*/
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
/**默认加载*/
-(NSInteger)defaultShowSection:(NSInteger)section;

@end

