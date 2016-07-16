//
//  MeItemCollectionViewCell.m
//  YHXZ
//
//  Created by LiuChenhao on 16/6/27.
//  Copyright © 2016年 LiuChenhao. All rights reserved.
//

#import "MeItemCollectionViewCell.h"

@implementation MeItemCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setAllComponentsFrame];
    }
    return self;
}
- (void)setCollectionViewCellData:(MeItemModel*)model{
    self.itemImage.image = [UIImage imageNamed:model.imageName];
    self.itemNameLabel.text = model.itemName;
}
//各控件的frame
- (void)setAllComponentsFrame{
    
    CGFloat ImageBeginX;
    CGFloat ImageBeginY;
    CGFloat ImageWidth;
    CGFloat ImageHeight;
    
    CGFloat ItemNameBeginX;
    CGFloat ItemNameBeginY;
    CGFloat ItemNameWidth;
    CGFloat ItemNameHeight;
    
    CGFloat MessageBeginX;
    CGFloat MessageBeginY;
    CGFloat MessageWidth;
    CGFloat MessageHeight;
    
    if (iPhone4s||iPhone5) {
        ImageBeginX = 35;
        ImageBeginY = 20;
        ImageWidth  = 40;
        ImageHeight = 40;
        
        ItemNameBeginX = 20;
        ItemNameBeginY = 65;
        ItemNameWidth  = 69;
        ItemNameHeight = 20;
        
        MessageBeginX = 30;
        MessageBeginY = 86;
        MessageWidth  = 49;
        MessageHeight = 15;
    }
        else if (iPhone6){
        ImageBeginX = 40;
        ImageBeginY = 30;
        ImageWidth  = 40;
        ImageHeight = 40;
        
        ItemNameBeginX = 18;
        ItemNameBeginY = 75;
        ItemNameWidth  = 85;
        ItemNameHeight = 15;
        
        MessageBeginX = 35;
        MessageBeginY = 95;
        MessageWidth  = 49;
        MessageHeight = 13;
    }
    
    else if (iPhone6p){
        ImageBeginX = 50;
        ImageBeginY = 30;
        ImageWidth  = 40;
        ImageHeight = 40;
        
        ItemNameBeginX = 28;
        ItemNameBeginY = 90;
        ItemNameWidth  = 85;
        ItemNameHeight = 15;
        
        MessageBeginX = 45;
        MessageBeginY = 95;
        MessageWidth  = 49;
        MessageHeight = 13;
    }
    self.itemImage = [[UIImageView alloc]initWithFrame:CGRectMake(ImageBeginX, ImageBeginY, ImageWidth, ImageHeight)];
    self.itemImage.image = [UIImage imageNamed:@"消息.png"];
    self.itemNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ItemNameBeginX, ItemNameBeginY, ItemNameWidth, ItemNameHeight)];
    self.itemNameLabel.text = @"演员";
    self.itemNameLabel.textAlignment = NSTextAlignmentCenter;
    self.MessageCount = [[UILabel alloc]initWithFrame:CGRectMake(MessageBeginX, MessageBeginY, MessageWidth, MessageHeight)];
    self.MessageCount.text = @"1";
    self.MessageCount.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.itemImage];
    [self.contentView addSubview:self.itemNameLabel];
    [self.contentView addSubview:self.MessageCount];
}


@end
