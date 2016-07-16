//
//  MySuppostTableViewCell.m
//  LeYingApp
//
//  Created by sks on 15/12/11.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "MySuppostTableViewCell.h"

@implementation MySuppostTableViewCell

-(UILabel *)initiatorLable
{
    if (_initiatorLable == nil)
    {
        self.initiatorLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
        self.initiatorLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_initiatorLable];
    }
    return _initiatorLable;
}
-(UILabel *)initiatorShowLable
{
    if (_initiatorShowLable == nil)
    {
        self.initiatorShowLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.initiatorLable.frame), 5, 100, 30)];
        self.initiatorShowLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_initiatorShowLable];
    }
    return _initiatorShowLable;
}
-(UILabel *)stateLable
{
    if (_stateLable == nil)
    {
        self.stateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 80, 5, 70, 30)];
        self.stateLable.font = [UIFont systemFontOfSize:14];
        self.stateLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_stateLable];
    }
    return _stateLable;
}

-(UIImageView *)showImage
{
    if (_showImage == nil)
    {
        self.showImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.initiatorLable.frame) + 5, 100, 80)];
        [self.contentView addSubview:_showImage];
    }
    return _showImage;
}

-(UILabel *)showTitLable
{
    if (_showTitLable == nil)
    {
        self.showTitLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.showImage.frame) + 5, CGRectGetMinY(self.showImage.frame), 100, 20)];
        self.showTitLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_showTitLable];
    }
    return _showTitLable;
}

-(UILabel *)priceLablel
{
    if (_priceLablel == nil)
    {
        self.priceLablel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 50, CGRectGetMinY(self.showTitLable.frame), 40, 30)];
        self.priceLablel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_priceLablel];
    }
    return _priceLablel;
}

-(UILabel *)goodsLable
{
    if (_goodsLable == nil)
    {
        self.goodsLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.showImage.frame) + 5, CGRectGetMaxY(self.showTitLable.frame) + 5, 150, 15)];
        self.goodsLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_goodsLable];
    }
    return _goodsLable;
}


-(UILabel *)numberLable
{
    if (_numberLable == nil)
    {
        self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 50, CGRectGetMaxY(self.showTitLable.frame) + 5, 150, 15)];
        self.numberLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_numberLable];
    }
    return _numberLable;
}


-(UILabel *)allLable
{
    if (_allLable == nil)
    {
        self.allLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.showImage.frame), CGRectGetMaxY(self.showImage.frame) + 5, 30, 15)];
        self.allLable.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_allLable];
    }
    return _allLable;
}
-(UILabel *)allShowLable
{
    if (_allShowLable == nil)
    {
        self.allShowLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.allLable.frame), CGRectGetMaxY(self.showImage.frame) + 5, 100, 15)];
        self.allShowLable.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_allShowLable];
    }
    return _allShowLable;
}

-(UILabel *)freightLable
{
    if (_freightLable == nil)
    {
        self.freightLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.showImage.frame), CGRectGetMaxY(self.allLable.frame) + 5, 50, 15)];
        self.freightLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_freightLable];
    }
    return _freightLable;
}
-(UILabel *)freightShowLable
{
    if (_freightShowLable == nil)
    {
        self.freightShowLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.freightLable.frame), CGRectGetMaxY(self.allLable.frame) + 5, 100, 15)];
        self.freightShowLable.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_freightShowLable];
    }
    return _freightShowLable;
}


-(UIButton *)paymentBtn
{
    if (_paymentBtn == nil)
    {
        self.paymentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.paymentBtn.frame = CGRectMake(CGRectGetMinX(self.stateLable.frame), CGRectGetMinY(self.allLable.frame), CGRectGetWidth(self.stateLable.frame), 50);
        [self.contentView addSubview:_paymentBtn];
    }
    return _paymentBtn;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
