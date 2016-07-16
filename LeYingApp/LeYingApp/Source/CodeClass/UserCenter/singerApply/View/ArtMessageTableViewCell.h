//
//  ArtMessageTableViewCell.h
//  乐影
//
//  Created by LiuChenhao on 16/3/18.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtMessageTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *starImage;

@property (nonatomic,strong)UIButton *heightBtn;
@property (nonatomic,strong)UIButton *weightBtn;
@property (nonatomic,strong)UIButton *mensurationsBtn;
@property (nonatomic,strong)UIButton *sizeBtn;

@property (nonatomic,strong)UILabel *heightLab;
@property (nonatomic,strong)UILabel *weightLab;
@property (nonatomic,strong)UILabel *mensurationLab;
@property (nonatomic,strong)UILabel *sizeLab;


@end
