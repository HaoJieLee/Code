//
//  BuyTableViewCell.m
//  乐影
//
//  Created by LiuChenhao on 16/3/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "BuyTableViewCell.h"

@implementation BuyTableViewCell

- (void)setWaresDataSourceWithModel:(buyModel*)model{
    
    [self.contentView addSubview:self.waresDetailBtn];
    self.waresShowImage.contentMode = UIViewContentModeScaleAspectFill;
    self.waresShowImage.clipsToBounds = YES;
    [self.waresShowImage sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    self.waresTitleLable.text = model.title;
    
    self.unitpriceShowLable.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    self.waresDetailLabel.text = model.Description;
     self.waresAmountShowLb.text = [NSString stringWithFormat:@"%@件", model.remain];
    [self againSetFrame];
    self.frame = CGRectMake(0, 0, self.frame.size.width, CGRectGetMinY(self.waresDetailBtn.frame)+50);
    
}
- (void)againSetFrame{
    self.waresDetailLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size = CGSizeMake( CGRectGetWidth(self.contentView.frame), CGFLOAT_MAX);
    self.waresDetailLabel.font = [UIFont systemFontOfSize:12];
    self.waresDetailLabel.textColor = [UIColor blackColor];
    self.waresDetailLabel.numberOfLines = 0;
    self.waresDetailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize briefSize = [self.waresDetailLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    
    //重设Frame大小
    CGRect newDetailWebRect = CGRectMake(self.waresDetailLabel.frame.origin.x, self.waresDetailLabel.frame.origin.y, self.waresDetailLabel.frame.size.width,briefSize.height+15);
    self.waresDetailLabel.frame = newDetailWebRect;
    
    self.waresAmountShowLb.frame = CGRectMake(CGRectGetMaxX(self.waresAmountLable.frame) , CGRectGetMaxY(self.waresDetailLabel.frame) + 5, CGRectGetWidth(self.frame) - CGRectGetWidth(self.waresShowImage.frame) - 60, 15);
    self.waresAmountLable.frame = CGRectMake(CGRectGetMaxX(self.waresShowImage.frame) + 10, CGRectGetMaxY(self.waresDetailLabel.frame) + 5, 40, 15);
    self.waresDetailBtn.frame = CGRectMake(CGRectGetMaxX(self.waresAmountShowLb.frame)-60, CGRectGetMaxY(self.waresDetailLabel.frame)+5, 66, 22);

}
-(UIImageView *)waresShowImage
{
    
    if (_waresShowImage == nil)
    {
        self.waresShowImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 25, CGRectGetWidth(self.frame)/3- 24, 100)];
        //CGRectGetWidth(self.frame) / 4 = [UIColor orangeColor];
        [self.contentView addSubview:_waresShowImage];
    }
    return _waresShowImage;
}

-(UILabel *)waresTitleLable
{
    if (_waresTitleLable == nil)
    {
        self.waresTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresShowImage.frame) + 10, 20, CGRectGetWidth(self.frame) - CGRectGetWidth(self.waresShowImage.frame) - 50, 25)];
        //self.waresTitleLable.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_waresTitleLable];
    }
    return _waresTitleLable;
}

-(UILabel *)unitpriceShowLable
{
    if (_unitpriceShowLable == nil)
    {
        self.unitpriceShowLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresShowImage.frame)+10, CGRectGetMaxY(self.waresTitleLable.frame) + 5, CGRectGetWidth(self.frame) - CGRectGetWidth(self.waresShowImage.frame) - 60, 15)];
        self.unitpriceShowLable.textColor = [UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0];
        self.unitpriceShowLable.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_unitpriceShowLable];
    }
    return _unitpriceShowLable;
}

-(UILabel *)waresAmountLable
{
    if (_waresAmountLable == nil)
    {
        self.waresAmountLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresShowImage.frame) + 10, CGRectGetMaxY(self.waresDetailLabel.frame) + 5, 40, 15)];
        self.waresAmountLable.textColor =  [UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0];
        self.waresAmountLable.font = [UIFont systemFontOfSize:14];
        self.waresAmountLable.text =@"剩余:";
        [self.contentView addSubview:_waresAmountLable];
    }
    return _waresAmountLable;
}

-(UILabel *)waresAmountShowLb
{
    if (_waresAmountShowLb == nil)
    {
        
        self.waresAmountShowLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresAmountLable.frame) , CGRectGetMaxY(self.waresDetailLabel.frame) + 5, CGRectGetWidth(self.frame) - CGRectGetWidth(self.waresShowImage.frame) - 60, 15)];
         self.waresAmountShowLb.textColor = [UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0];
        //self.targetAmountLable.backgroundColor = [UIColor yellowColor];
        self.waresAmountShowLb.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_waresAmountShowLb];
    }
    return _waresAmountShowLb;
}

-(UILabel *)waresDetailLabel
{
    if (_waresDetailLabel == nil)
    {
        self.waresDetailLabel  = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.waresShowImage.frame) + 10, CGRectGetMaxY(self.unitpriceShowLable.frame) + 7, CGRectGetWidth(self.contentView.frame)-CGRectGetWidth(self.waresShowImage.frame)+20, 30)];
        self.waresDetailLabel.textColor = [UIColor colorWithRed:76/255.0f green:76/255.0f blue:76/255.0f alpha:1.0];
        self.waresDetailLabel .font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_waresDetailLabel];
    }
    return _waresDetailLabel ;
}

-(UIButton *)waresDetailBtn
{
    if (_waresDetailBtn == nil)
    {
        self.waresDetailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.waresDetailBtn.frame = CGRectMake(CGRectGetMaxX(self.waresAmountShowLb.frame)-60, CGRectGetMaxY(self.waresDetailLabel.frame)+5, 66, 22);
        
        self.waresDetailBtn.backgroundColor = [UIColor colorWithRed:147/255.0f green:154/255.0f  blue:160/255.0f alpha:1.0];
        [self.waresDetailBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [self.waresDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.waresDetailBtn addTarget:self action:@selector(infoWaresDetailButton) forControlEvents:UIControlEventTouchUpInside];
        [self.waresDetailBtn setBackgroundColor:[UIColor greenColor]];
        self.waresDetailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _waresDetailBtn;
}

- (void)infoWaresDetailButton{
    if (self.button) {
        self.button();
    }
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
