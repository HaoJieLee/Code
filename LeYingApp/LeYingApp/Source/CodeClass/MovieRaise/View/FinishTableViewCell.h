//
//  FinishTableViewCell.h
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *playImage;

@property (nonatomic,strong)UIImageView *showImage2;
@property (nonatomic,strong)UILabel *titLab;
@property (nonatomic,strong)UIImageView *seeImage;
@property (nonatomic,strong)UILabel *seeShowLab;
@property (nonatomic,strong)UILabel *endTimeLab;
@property (nonatomic,strong)UILabel *endTimeShowLab;
@property (nonatomic,strong)UILabel *introLab;

@property (nonatomic,strong)UIView *infoView;//将标题、时间、浏览量放到view上



@end
