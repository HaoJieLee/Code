//
//  myUILabel.h
//  LeYingApp
//
//  Created by sks on 15/12/15.
//  Copyright © 2015年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface myUILabel : UILabel


{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

-(void)setVerticalAlignment:(VerticalAlignment)verticalAlignment;



@end
