//
//  JWVideoPlayer.h
//  平台测试
//
//  Created by 一只皮卡丘 on 16/4/5.
//  Copyright © 2016年 一只皮卡丘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWVideoPlayer : UIViewController

@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *videoPath;
@property (nonatomic, copy) NSString *videoTitle;

@property (weak, nonatomic) IBOutlet UIView *mainContainerView;
@property (weak, nonatomic) IBOutlet UIView *playVideoView;
@property (nonatomic, weak) IBOutlet UIView *controlview;
@property (weak, nonatomic) IBOutlet UIView *topControlView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topImgae;

@property (weak, nonatomic) IBOutlet UIView *bottomControlView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UISlider *videoSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *videoProgress;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *tipView;

@end
