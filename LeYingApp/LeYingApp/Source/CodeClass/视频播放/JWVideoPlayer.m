//
//  JWVideoPlayer.m
//  平台测试
//
//  Created by 一只皮卡丘 on 16/4/5.
//  Copyright © 2016年 一只皮卡丘. All rights reserved.
//

#import "JWVideoPlayer.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved, //横向移动
    PanDirectionVerticalMoved    //纵向移动
};

@interface JWVideoPlayer ()
{
    float videodurationF;
    BOOL  isHidden;
    BOOL  isVolume;
}

@property (nonatomic, strong) AVPlayer *videoplayer;
@property (nonatomic, strong) AVPlayerLayer *videoplayerlayer;
@property (nonatomic, strong) AVPlayerItem *videoplayeritem;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, copy) NSString *videoDuration;

@property (nonatomic, assign) PanDirection panDirection;
@property (nonatomic, strong) UISlider *volumeViewSlider;
@property (nonatomic, strong) UILabel *horizontalLabel;
@property (nonatomic, assign) CGFloat sumTime;
@property (nonatomic, strong) UIImageView *lightView;


@end

@implementation JWVideoPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.videoSlider setThumbImage:[UIImage imageNamed:@"icon_drag.png"] forState:UIControlStateNormal];
    [self.videoSlider setThumbImage:[UIImage imageNamed:@"icon_drag.png"] forState:UIControlStateHighlighted];
    
    self.tipView.hidden = YES;
    self.lightView.hidden = YES;
    self.titleLabel.text = self.videoTitle;
    
    [self settingFrame];
    [self settingVideoPlayer];
    [self settingControlView];
}

#pragma mark - 设置 player
-(void)settingVideoPlayer
{
    self.videoplayerlayer = [AVPlayerLayer playerLayerWithPlayer:self.videoplayer];
    self.videoplayerlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.videoplayerlayer.videoGravity = AVLayerVideoGravityResizeAspect;
    self.videoplayerlayer.player = self.videoplayer;
    self.videoplayerlayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.playVideoView.layer insertSublayer:self.videoplayerlayer atIndex:0];
    
    [self.videoplayer play];
}

-(AVPlayer *)videoplayer
{
    if (!_videoplayer) {
        _videoplayeritem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.videoUrl]];
        [_videoplayeritem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [_videoplayeritem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        _videoplayer = [[AVPlayer alloc] initWithPlayerItem:_videoplayeritem];
        [self sliderChangeForSecond];
        [self configureVolume];
        return _videoplayer;
    }
    return _videoplayer;
}

#pragma  mark - 适配
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.videoplayerlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

-(void)settingFrame
{
    __weak __typeof(self) weakSelf = self;

    [self.mainContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.controlview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
//-----------------------------------播放器控制器适配-------------------------------------------
    [self.playVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
//-----------------------------------顶部控制器适配---------------------------------------------
    [self.topControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(@0);
        make.width.equalTo(weakSelf.controlview);
        make.height.mas_equalTo(@64);
    }];
    [self.topImgae mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.topControlView);
    }];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(weakSelf.topControlView).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.topControlView);
        make.left.and.right.equalTo(weakSelf.topControlView).with.insets(UIEdgeInsetsMake(0, 50, 0, 50));
    }];
//-----------------------------------中部控制器适配--------------------------------------------
    [self.horizontalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.controlview);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.controlview);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    [self.lightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.controlview);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
//-----------------------------------底部控制器适配--------------------------------------------
    [self.bottomControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.mas_equalTo(@0);
        make.width.equalTo(weakSelf.controlview);
        make.height.mas_equalTo(@64);
    }];
    [self.bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.bottomControlView);
    }];
    [self.videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.bottomControlView);
        make.left.and.right.equalTo(weakSelf.bottomControlView).with.insets(UIEdgeInsetsMake(0, 50, 0, 50));
    }];
    [self.videoProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.bottomControlView);
        make.left.and.right.equalTo(weakSelf.bottomControlView).with.insets(UIEdgeInsetsMake(0, 50, 0, 50));
    }];
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(weakSelf.bottomControlView).with.insets(UIEdgeInsetsMake(10, 10, 10, 20));
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.equalTo(weakSelf.bottomControlView).with.insets(UIEdgeInsetsMake(10, 20, 10, 10));
    }];
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(weakSelf.videoSlider).with.insets(UIEdgeInsetsMake(30, 10, 10, 0));
    }];
}

#pragma mark - kvo 监听视频状态和缓冲长度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            // 获取视频总长度
            CMTime duration = self.videoplayeritem.duration;
            // 转换成秒
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;
            self.totalTimeLabel.text = [self convertTime:totalSecond];
            // 转换成播放时间
            self.videoDuration = [self convertTime:totalSecond];
            // 自定义UISlider
            [self customVideoSlider:duration];
            NSLog(@"movie total duration:%f  %@",CMTimeGetSeconds(duration),self.videoDuration);
//            [self monitoringPlayback:self.videoplayeritem];// 监听播放状态
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }else if ([playerItem status] == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayerItemStatusUnknown");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"缓冲Time Interval:%f",timeInterval);
        CMTime duration = self.videoplayeritem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}

#pragma mark - 自定义 slider
- (void)customVideoSlider:(CMTime)duration {
    self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
    // slider开始滑动事件
    [self.videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    // slider滑动中事件
    [self.videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    // slider结束滑动事件
    [self.videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
    
    //progress
    [self.videoProgress setProgressImage:[UIImage imageNamed:@"bar_progress_.png"]];
}

- (void)progressSliderTouchBegan:(UISlider *)sender
{
    [self.videoplayer pause];
}

- (void)progressSliderValueChanged:(UISlider *)sender
{
    [self.videoplayer pause];
}

- (void)progressSliderTouchEnded:(UISlider *)sender
{
    [self.videoplayer pause];
    CMTime dragedCMTime = CMTimeMake(sender.value, 1);
    [self.videoplayer seekToTime:dragedCMTime completionHandler:^(BOOL finished) {
        [self.videoplayer play];
    }];
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.videoplayer currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)sliderChangeForSecond
{
    __weak __typeof(self) weakSelf = self;

    [self.videoplayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //当前播放的时间
        CMTime currentTime = weakSelf.videoplayer.currentItem.currentTime;
        if (currentTime.timescale == 0) {
            
        }else{
            CGFloat surrentSecond = currentTime.value / currentTime.timescale;// 转换成秒
            NSString *curretTime = [weakSelf convertTime:surrentSecond];
            weakSelf.currentTimeLabel.text = curretTime;
            [weakSelf.videoSlider setValue:surrentSecond animated:YES];
        }
    }];
}

#pragma mark - 时间转换
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

#pragma mark - 播放暂停
- (IBAction)playAndPause:(UIButton *)sender
{
    if (sender.tag == 1) {
        [self.videoplayer play];
        [sender setImage:[UIImage imageNamed:@"icon_pause.png"] forState:UIControlStateNormal];
        sender.tag = 2;
    }else if (sender.tag == 2){
        [self.videoplayer pause];
        [sender setImage:[UIImage imageNamed:@"icon_play.png"] forState:UIControlStateNormal];
        sender.tag = 1;
    }
}

#pragma mark - 返回
- (IBAction)backBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        //移除观察者
        [self.videoplayeritem removeObserver:self forKeyPath:@"status" context:nil];
        [self.videoplayeritem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
        [self.videoplayer replaceCurrentItemWithPlayerItem:nil];
    }];
}

#pragma mark - 全屏
- (IBAction)fullScreenBtnClick:(id)sender
{

}

#pragma mark - 设置控制栏
-(void)settingControlView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenControlView)];
    [self.controlview addGestureRecognizer:tap];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDirection:)];
    [self.controlview addGestureRecognizer:pan];
}
//隐藏
-(void)hiddenControlView
{
    if (isHidden) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.topControlView.alpha = 1.0;
            self.bottomControlView.alpha = 1.0;
        } completion:^(BOOL finished) {
            isHidden = NO;
        }];
    }else{
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.topControlView.alpha = 0.0;
            self.bottomControlView.alpha = 0.0;
        } completion:^(BOOL finished) {
            isHidden = YES;
        }];
    }

}

- (void)panDirection:(UIPanGestureRecognizer *)pan
{
    //根据在view上Pan的位置，确定是调音量还是亮度
    CGPoint locationPoint = [pan locationInView:self.controlview];
    
    // 我们要响应水平移动和垂直移动
    // 根据上次和本次移动的位置，算出一个速率的point
    CGPoint veloctyPoint = [pan velocityInView:self.controlview];
    
    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ // 开始移动
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) {
                //水平
                self.tipView.hidden = NO;
                self.panDirection = PanDirectionHorizontalMoved;

                // 给sumTime初值
                CMTime time = self.videoplayer.currentTime;
                self.sumTime = time.value/time.timescale;
                
                // 暂停视频播放
                [self.videoplayer pause];
            }
            else if (x < y){
                // 垂直移动
                self.panDirection = PanDirectionVerticalMoved;
                // 开始滑动的时候,状态改为正在控制音量
                if (locationPoint.x > self.controlview.bounds.size.width * 0.5) {
                    isVolume = YES;
                }else { // 状态改为显示亮度调节
                    self.tipView.hidden = NO;
                    self.horizontalLabel.hidden = YES;
                    self.lightView.hidden = NO;
                    isVolume = NO;
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{ // 正在移动
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{
                    [self horizontalMoved:veloctyPoint.x]; // 水平移动的方法只要x方向的值
                    break;
                }
                case PanDirectionVerticalMoved:{
                    [self verticalMoved:veloctyPoint.y];   // 垂直移动方法只要y方向的值
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case UIGestureRecognizerStateEnded:{ // 移动停止
            // 移动结束也需要判断垂直或者平移
            // 比如水平移动结束时，要快进到指定位置，如果这里没有判断，当我们调节音量完之后，会出现屏幕跳动的bug
            switch (self.panDirection) {
                case PanDirectionHorizontalMoved:{
                    self.tipView.hidden = YES;

                    break;
                }
                case PanDirectionVerticalMoved:{
                    // 垂直移动结束后，把状态改为不再控制音量
                    self.tipView.backgroundColor = [UIColor clearColor];
                    self.lightView.hidden = YES;
                    self.horizontalLabel.hidden = NO;
                    self.tipView.hidden = YES;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - 音量和亮度
- (void)verticalMoved:(CGFloat)value
{
    if (isVolume) {
        // 更改系统的音量
        self.volumeViewSlider.value      -= value / 10000;// 越小幅度越小
    }else {
        //亮度
        [UIScreen mainScreen].brightness -= value / 10000;
    }
}

//获取系统音量
- (void)configureVolume
{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    _volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
}

#pragma mark - 快进快退
- (void)horizontalMoved:(CGFloat)value
{
    // 快进快退的方法
    NSString *style = @"";
    if (value < 0) {
        style = @"<<";
    }
    else if (value > 0){
        style = @">>";
    }
    // 每次滑动需要叠加时间
    self.sumTime += value / 200;
    // 需要限定sumTime的范围
    CMTime totalTime = self.videoplayeritem.duration;
    CGFloat totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
    if (self.sumTime > totalMovieDuration) {
        self.sumTime = totalMovieDuration;
    }else if (self.sumTime < 0){
        self.sumTime = 0;
    }
    // 当前快进的时间
    NSString *nowTime         = [self convertTime:(float)self.sumTime];
    // 总时间
    NSString *durationTime    = [self convertTime:(float)totalMovieDuration];
    // 给label赋值
    self.horizontalLabel.text = [NSString stringWithFormat:@"%@ %@ / %@",style, nowTime, durationTime];
    
    [self.videoplayer seekToTime:CMTimeMake(self.sumTime, 1) completionHandler:^(BOOL finished) {
        //
    }];
    
    [self.videoplayer play];
}

- (UILabel *)horizontalLabel
{
    if (!_horizontalLabel) {
        _horizontalLabel = [[UILabel alloc] init];
        _horizontalLabel.textColor = [UIColor whiteColor];
        _horizontalLabel.textAlignment = NSTextAlignmentCenter;
        // 设置快进快退label
        _horizontalLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_bottom.png"]];
        [self.tipView addSubview:_horizontalLabel];
    }
    return _horizontalLabel;
}

-(UIImageView *)lightView
{
    if (!_lightView) {
        _lightView = [[UIImageView alloc] init];
        _lightView.image = [UIImage imageNamed:@"lightImage.png"];
        _lightView.alpha = 0.5;
        [self.tipView addSubview:_lightView];
        return _lightView;
    }
    return _lightView;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

//当前 viewcontroller 是否支持转屏
-(BOOL)shouldAutorotate
{
    return YES;
}
//支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


//如果该 vc 是通过 present 出来的  用下面这个方法可以让它坚持摸个特定的方向
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationLandscapeRight;
//}




@end
