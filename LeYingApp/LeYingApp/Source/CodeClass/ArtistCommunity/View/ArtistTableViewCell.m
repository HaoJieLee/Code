//
//  ArtistTableViewCell.m
//  LeYingApp
//
//  Created by sks on 15/12/11.
//  Copyright © 2015年 sks. All rights reserved.
//

#import "ArtistTableViewCell.h"

@implementation ArtistTableViewCell

-(UIImageView *)artImage
{
    if (_artImage == nil)
    {
        self.artImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        [self.contentView addSubview:_artImage];
    }
    return _artImage;
}

-(UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.artImage.frame) + 5, CGRectGetMinY(self.artImage.frame) , CGRectGetWidth(self.frame) - CGRectGetWidth(self.artImage.frame) - 20, 20)];
        self.titleLable.font = [UIFont fontWithName:@"Helvetica" size:16];
        self.titleLable.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f  blue:83/255.0f  alpha:1.0];
        
        [self.contentView addSubview:_titleLable];
    }
    return _titleLable;
}

-(UIImageView *)imgTime
{
    if (_imgTime == nil) {
        self.imgTime = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.artImage.frame) + 5, CGRectGetMaxY(self.titleLable.frame) + 7, 15, 15)];
        [self.contentView addSubview:_imgTime];
    }
    return _imgTime;
}

-(UILabel *)lblTime
{
    if (_lblTime == nil) {
        self.lblTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgTime.frame) + 5, CGRectGetMinY(self.imgTime.frame), CGRectGetWidth(self.frame) - CGRectGetMaxX(self.imgTime.frame) - 25, CGRectGetHeight(self.imgTime.frame))];
        self.lblTime.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f  blue:83/255.0f  alpha:1.0];
        self.lblTime.font = [UIFont fontWithName:@"Helvetica" size:14];
        [self.contentView addSubview:_lblTime];
    }
    return _lblTime;
}

-(UIImageView *)imgLocation
{
    if (_imgLocation == nil) {
        CGFloat imgX = CGRectGetMinX(self.imgTime.frame);
        CGFloat imgY = CGRectGetMaxY(self.imgTime.frame) + 5;
        CGFloat imgW = CGRectGetWidth(self.imgTime.frame);
        CGFloat imgH = CGRectGetHeight(self.imgTime.frame);
        self.imgLocation = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
        [self.contentView addSubview:_imgLocation];
    }
    return _imgLocation;
}

-(UILabel *)lblLocation
{
    if (_lblLocation == nil) {
        CGFloat lblX = CGRectGetMinX(self.lblTime.frame);
        CGFloat lblY = CGRectGetMinY(self.imgLocation.frame);
        CGFloat lblW = CGRectGetWidth(self.lblTime.frame);
        CGFloat lblH = CGRectGetHeight(self.imgLocation.frame);
        self.lblLocation = [[UILabel alloc] initWithFrame:CGRectMake(lblX, lblY, lblW, lblH)];
        self.lblLocation.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f  blue:83/255.0f  alpha:1.0];
        self.lblLocation.font = [UIFont fontWithName:@"Helvetica" size:14];
        [self.contentView addSubview:_lblLocation];
    }
    return _lblLocation;
}

-(UIImageView *)imgModol
{
    if (_imgModol == nil) {
        CGFloat imgX = CGRectGetMinX(self.imgTime.frame);
        CGFloat imgY = CGRectGetMaxY(self.imgLocation.frame) + 5;
        CGFloat imgW = CGRectGetWidth(self.imgTime.frame);
        CGFloat imgH = CGRectGetHeight(self.imgTime.frame);
        self.imgModol = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
        [self.contentView addSubview:_imgModol];
    }
    return _imgModol;
}

-(UILabel *)lblModol
{
    if (_lblModol == nil) {
        CGFloat lblX = CGRectGetMinX(self.lblTime.frame);
        CGFloat lblY = CGRectGetMinY(self.imgModol.frame);
        CGFloat lblW = CGRectGetWidth(self.lblTime.frame);
        CGFloat lblH = CGRectGetHeight(self.imgModol.frame);
        self.lblModol = [[UILabel alloc] initWithFrame:CGRectMake(lblX, lblY, lblW, lblH)];
        self.lblModol.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f  blue:83/255.0f  alpha:1.0];
        self.lblModol.font = [UIFont fontWithName:@"Helvetica" size:14];
        [self.contentView addSubview:_lblModol];
    }
    return _lblModol;
}

-(UIImageView *)imgClick
{
    if (_imgClick == nil) {
        CGFloat imgX = CGRectGetMinX(self.imgTime.frame);
        CGFloat imgY = CGRectGetMaxY(self.imgModol.frame) + 5;
        CGFloat imgW = CGRectGetWidth(self.imgTime.frame);
        CGFloat imgH = CGRectGetHeight(self.imgTime.frame);
        self.imgClick = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
        [self.contentView addSubview:_imgClick];
    }
    return _imgClick;
}

-(UILabel *)lblClick
{
    if (_lblClick == nil) {
        CGFloat lblX = CGRectGetMinX(self.lblTime.frame);
        CGFloat lblY = CGRectGetMinY(self.imgClick.frame);
        CGFloat lblW = CGRectGetWidth(self.lblTime.frame);
        CGFloat lblH = CGRectGetHeight(self.imgClick.frame);
        self.lblClick = [[UILabel alloc] initWithFrame:CGRectMake(lblX, lblY, lblW, lblH)];
        self.lblClick.textColor = [UIColor colorWithRed:85/255.0f green:85/255.0f  blue:83/255.0f  alpha:1.0];
        self.lblClick.font = [UIFont fontWithName:@"Helvetica" size:14];
        [self.contentView addSubview:_lblClick];
    }
    return _lblClick;
}

-(UIButton *)btnEventDetails
{
    if (_btnEventDetails == nil) {
        self.btnEventDetails = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnW = 65;
        CGFloat btnH = 25;
        CGFloat btnX = CGRectGetWidth(self.frame) - btnW - 10;
        CGFloat btnY = CGRectGetMaxY(self.imgModol.frame) + 3;
        self.btnEventDetails.frame = CGRectMake(btnX, btnY, btnW, btnH);
        self.btnEventDetails.titleLabel.font = [UIFont systemFontOfSize:13];
        self.btnEventDetails.backgroundColor = [UIColor colorWithRed:159.0/255 green:169.0/255 blue:170.0/255 alpha:1];
        [self.contentView addSubview:_btnEventDetails];
    }
    return _btnEventDetails;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
