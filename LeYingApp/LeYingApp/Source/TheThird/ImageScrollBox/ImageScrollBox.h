//
//  ImageScrollBox.h
//  JXPT
//
//  Created by 一只皮卡丘 on 16/3/8.
//  Copyright © 2016年 一只皮卡丘. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageScrollBox;
@protocol ImageScrollBoxDelegate <NSObject>

-(void)didSelectView:(long)pageNumber;

@end

typedef NS_ENUM(NSInteger, scrollDirection){
    scrollDirectionHorizontalMoved,
    scrollDirectionVerticalMoved    
};

@interface ImageScrollBox : UIView

@property (nonatomic, strong) NSArray *urlImageArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *subViewArray;
@property (nonatomic, assign) float timeInterval;
@property (nonatomic, assign) scrollDirection sDirection;
@property (nonatomic, weak) id<ImageScrollBoxDelegate> delegate;


@end
