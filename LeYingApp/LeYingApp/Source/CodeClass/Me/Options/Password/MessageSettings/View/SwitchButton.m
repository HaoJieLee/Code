//
//  SwitchButton.m
//  乐影
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "SwitchButton.h"

@implementation SwitchButton

static SwitchButton* _switch = nil;

+(instancetype) shareSwich
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _switch = [[self alloc]init];
        });
    
    return _switch;
    
}
- (void)getScleFloat{
    if (iPhone4s || iPhone5) {
        self.scle = 320.f*320.f/375;
    }else if (iPhone6){
        self.scle = 310.f;
    }else if (iPhone6p){
        self.scle = 414*320.f/375;
    }
}
-(UISwitch *)witch1
{
    [self getScleFloat];
    if (!_witch1) {
        _witch1 = [[UISwitch alloc]initWithFrame:CGRectMake(self.scle, 7.0f, 100.0f, 28.0f)];
    }
    return _witch1;
}

-(UISwitch *)witch2
{
    [self getScleFloat];
    if (!_witch2) {
        _witch2 = [[UISwitch alloc]initWithFrame:CGRectMake(self.scle, 7.0f, 100.0f, 28.0f)];
    }
    return _witch2;
}


-(UISwitch *)witch3
{
    [self getScleFloat];
    if (!_witch3) {
        _witch3 = [[UISwitch alloc]initWithFrame:CGRectMake(self.scle,7.0f, 100.0f, 28.0f)];
    }
    return _witch3;
}


-(UISwitch *)witch4
{
    [self getScleFloat];
    if (!_witch4) {
        _witch4 = [[UISwitch alloc]initWithFrame:CGRectMake(self.scle, 7.0f, 100.0f, 28.0f)];
    }
    return _witch4;
}



@end
