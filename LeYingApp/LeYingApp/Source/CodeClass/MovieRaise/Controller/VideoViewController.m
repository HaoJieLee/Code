//
//  VideoViewController.m
//  LeYingApp
//
//  Created by LiuChenhao on 16/1/20.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "getProjectData.h"
#import "SDCycleScrollView.h"
@interface VideoViewController ()<LGtitleBarViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate>

{
    BOOL _isFullScreen;
}

@property (nonatomic,strong)MPMoviePlayerController *moviePlayer;//视频播放控制器

@end

@implementation VideoViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBarHidden = YES;//用来隐藏；
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden= NO;
    self.navigationController.navigationBarHidden = NO;//用来显示
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //项目浏览量
    
    [[getProjectData shareProjectData] completeClickwithID:self.clickIndex];
    
    
    //MPMoviePlayerViewControllermoviePlayer.controlStyle = MPMovieControlStyleFullscreen;moviePlayer.scalingMode = MPMovieScalingModeAspectFil
    //self.tabBarController.tabBar.hidden=YES;
    //播放
    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
    
    
    //设置播放格式
    self.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    // Do any additional setup after loading the view.
//    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(M_PI / 2);
//    self.moviePlayer.view.transform = landscapeTransform;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                        selector:@selector(willEnterFullScreen:)                                                  name:MPMoviePlayerWillEnterFullscreenNotification
                                               object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self
                                                   selector:@selector(willExitFullScreen:)
                                                         name:MPMoviePlayerWillExitFullscreenNotification
                                                      object:nil];
//
    
}

//轮播图代理事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
    
}

- (void)willEnterFullScreen:(NSNotification *)notification
{
    _isFullScreen = YES;
}

- (void)willExitFullScreen:(NSNotification *)notification
{
     _isFullScreen = NO;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isFullScreen)
    {
              return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
    
    else
    {
      return UIInterfaceOrientationMaskPortrait;
     }
}


-(void)dealloc
{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSURL *)getNetworkUrl
{
    self.videoLoad=[self.videoLoad stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:self.videoLoad];
    return url;
}


-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getNetworkUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态12312312:%li",self.moviePlayer.playbackState);
           
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification
{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
     [self.navigationController popViewControllerAnimated:YES];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
