//
//  FinishTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "FinishTableViewCell.h"
#import <sys/types.h>
#import <sys/sysctl.h>
@implementation FinishTableViewCell

- (UIView*)infoView{
    if (_infoView==nil) {
        
        _infoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.showImage2.frame)*3/4-20, CGRectGetWidth(self.showImage2.frame), CGRectGetHeight(self.showImage2.frame)/4+20)];
        [_infoView addSubview:self.seeImage];
        [_infoView addSubview:self.seeShowLab];
        [_infoView addSubview:self.endTimeShowLab];
        [_infoView addSubview:self.introLab];
        [_infoView addSubview:self.titLab];
        _infoView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.1];
    }
    return _infoView;
}
-(UIImageView *)seeImage
{
    if (_seeImage == nil)
    {
        self.seeImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 75,20, 20, 25)];
        
    }
    return _seeImage;
}
-(UILabel *)seeShowLab
{
    if (_seeShowLab == nil)
    {
        self.seeShowLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.seeImage.frame)+10, 20, 40, 25)];
        // self.seeShowLab.backgroundColor = [UIColor redColor];
        self.seeShowLab.textColor =  [UIColor whiteColor];
        self.seeShowLab.font = [UIFont systemFontOfSize:14];
    }
    return _seeShowLab;
}


-(UIImageView *)showImage2
{
    
    if (_showImage2 == nil)
    {
        self.showImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 170)];
        [_showImage2 addSubview:self.infoView];
        //self.showImage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_showImage2];
    }
    return _showImage2;
}
-(UIImageView *)playImage
{
    if (_playImage == nil)
    {
        self.playImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.showImage2.frame)/2 - 40,CGRectGetHeight(self.showImage2.frame)/2 - 40, 80, 80)];
        //self.showImage.backgroundColor = [UIColor orangeColor];
//        [self.showImage2 addSubview:_playImage];
    }
    return _playImage;
}

-(UILabel *)titLab
{
    if (_titLab == nil)
    {
        self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 2,CGRectGetWidth(self.frame) - 220, 30)];
        
        self.titLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        self.titLab.textColor = [UIColor whiteColor];

    }
    return _titLab;
}

-(UILabel *)endTimeShowLab
{
    if (_endTimeShowLab == nil)
    {
        self.endTimeShowLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 110, 30)];
        self.endTimeShowLab.textColor =  [UIColor whiteColor];
        self.endTimeShowLab.font = [UIFont systemFontOfSize:12];

    }
    return _endTimeShowLab;
}






-(UILabel *)endTimeLab
{
    if (_endTimeLab == nil)
    {
        self.endTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 40, 30)];
       // self.endTimeLab.backgroundColor = [UIColor brownColor];
        self.endTimeLab.font = [UIFont systemFontOfSize:13];
        self.endTimeLab.textColor =  [UIColor colorWithRed:111/255.0f green:111/255.0f blue:111/255.0f alpha:1.0];
//        [self.contentView addSubview:_endTimeLab];
    }
    return _endTimeLab;
}



-(UILabel *)introLab
{
    if (_introLab == nil)
    {
        self.introLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 45, CGRectGetWidth(self.frame) - 10, 20)];
        //self.titleLable.backgroundColor = [UIColor redColor];
        self.introLab.font = [UIFont systemFontOfSize:12];
        self.introLab.textColor = [UIColor whiteColor];
//        [self.contentView addSubview:_introLab];
    }
    return _introLab;
}

-(NSString *)platformString
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

-(NSString *)deverceString
{
    NSString * platform = [self platformString];
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        platform = @"iPhone";
        
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        
        platform = @"iPhone 3G";
        
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        
        platform = @"iPhone 3GS";
        
    } else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
        
        platform = @"iPhone 4";
        
    } else if ([platform isEqualToString:@"iPhone4,1"]) {
        
        platform = @"iPhone 4S";
        
    } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
        
        platform = @"iPhone 5";
        
    }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
        
        platform = @"iPhone 5C";
        
    }else if ([platform isEqualToString:@"iPhone6,2"]||[platform isEqualToString:@"iPhone6,1"]) {
        
        platform = @"iPhone 5S";
        
    }else if ([platform isEqualToString:@"iPod4,1"]) {
        
        platform = @"iPod touch 4";
        
    }else if ([platform isEqualToString:@"iPod5,1"]) {
        
        platform = @"iPod touch 5";
        
    }else if ([platform isEqualToString:@"iPod3,1"]) {
        
        platform = @"iPod touch 3";
        
    }else if ([platform isEqualToString:@"iPod2,1"]) {
        
        platform = @"iPod touch 2";
        
    }else if ([platform isEqualToString:@"iPod1,1"]) {
        
        platform = @"iPod touch";
        
    } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]) {
        
        platform = @"iPad 3";
        
    } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
        
        platform = @"iPad 2";
        
    }else if ([platform isEqualToString:@"iPad1,1"]) {
        
        platform = @"iPad 1";
        
    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]) {
        
        platform = @"ipad mini";
        
    } else if ([platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
        
        platform = @"ipad 3";
        
    }else if([platform isEqualToString:@"i386"]||[platform isEqualToString:@"x86_64"])
    {
        platform = @"iPhone Simulator";
    }
    
    return platform;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
