//
//  ImageScrollBox.m
//  JXPT
//
//  Created by 一只皮卡丘 on 16/3/8.
//  Copyright © 2016年 一只皮卡丘. All rights reserved.
//

#import "ImageScrollBox.h"
//#import "UIImageView+WebCache.h"

@interface ImageScrollBox()<UIScrollViewDelegate>

@property (nonatomic, assign) CGRect mainRect;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) long currentpage;
@property (nonatomic, assign) long imageNumber;
@property (nonatomic, assign) BOOL isUrlImage;

@property (nonatomic, strong) UIImageView *imageview1;
@property (nonatomic, strong) UIImageView *imageview2;
@property (nonatomic, strong) UIImageView *imageview3;


@end

@implementation ImageScrollBox

-(void)drawRect:(CGRect)rect
{
    _mainRect = rect;
    if (self.imageArray) {
        _imageNumber = self.imageArray.count;
        _isUrlImage = NO;
    }else if (self.urlImageArray){
        _imageNumber = self.urlImageArray.count;
        _isUrlImage = YES;
    }else{
        return;
    }
    [self setScrollview];
    [self setImageView];
    [self setpageView];
    [self startTimer];
    
}

-(void)setScrollview
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:_mainRect];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.delegate = self;
    _mainScrollView.bounces = NO;
    
    if (self.sDirection == scrollDirectionHorizontalMoved) {
        _mainScrollView.contentSize = CGSizeMake(3 * _mainScrollView.bounds.size.width, 0);
        [_mainScrollView setContentOffset:CGPointMake(_mainScrollView.bounds.size.width, 0) animated:YES];
        [self addSubview:_mainScrollView];
        
        _imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _mainRect.size.width, _mainRect.size.height)];
        _imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(_mainRect.size.width, 0, _mainRect.size.width, _mainRect.size.height)];
        _imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*_mainRect.size.width, 0, _mainRect.size.width, _mainRect.size.height)];
    }else{
        _mainScrollView.contentSize = CGSizeMake(0, 3 * _mainScrollView.bounds.size.height);
        [_mainScrollView setContentOffset:CGPointMake(0, _mainScrollView.bounds.size.height) animated:YES];
        [self addSubview:_mainScrollView];
        _imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _mainRect.size.width, _mainRect.size.height)];
        _imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, _mainRect.size.height, _mainRect.size.width, _mainRect.size.height)];
        _imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2*_mainRect.size.height, _mainRect.size.width, _mainRect.size.height)];
    }
    
    _imageview2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
    [_imageview2 addGestureRecognizer:tap];
    
    [_mainScrollView addSubview:_imageview1];
    [_mainScrollView addSubview:_imageview2];
    [_mainScrollView addSubview:_imageview3];
    
    _currentpage = 0;
}

-(void)setImageView
{
    _page.currentPage = _currentpage;
    long index1 = _currentpage-1 == -1 ? _imageNumber-1 : _currentpage-1;
    long index2 = _currentpage+1 == _imageNumber ? 0 : _currentpage+1;
    
    if (_isUrlImage) {
        [_imageview1 sd_setImageWithURL:[NSURL URLWithString:_urlImageArray[index1]] placeholderImage:[UIImage imageNamed:@"koubi.jpg"]];
        [_imageview2 sd_setImageWithURL:[NSURL URLWithString:_urlImageArray[_currentpage]] placeholderImage:[UIImage imageNamed:@"koubi.jpg"]];
        [_imageview3 sd_setImageWithURL:[NSURL URLWithString:_urlImageArray[index2]] placeholderImage:[UIImage imageNamed:@"koubi.jpg"]];
    }else{
        _imageview1.image = [UIImage imageNamed:_imageArray[index1]];
        _imageview2.image = [UIImage imageNamed:_imageArray[_currentpage]];
        _imageview3.image = [UIImage imageNamed:_imageArray[index2]];
    }
    
    if (_subViewArray) {
        [_imageview1 addSubview:_subViewArray[index1]];
        [_imageview2 addSubview:_subViewArray[_currentpage]];
        [_imageview3 addSubview:_subViewArray[index2]];
    }
    
    NSArray *imageArray = [NSArray arrayWithObjects:_imageview1,_imageview2,_imageview3,nil];
    for (UIImageView *imageview in imageArray) {
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.layer.masksToBounds = YES;
    }
    
    if (self.sDirection == scrollDirectionHorizontalMoved) {
        _mainScrollView.contentOffset = CGPointMake(self.mainScrollView.frame.size.width, 0);
    }else{
        _mainScrollView.contentOffset = CGPointMake(0, self.mainScrollView.frame.size.height);
    }
}

-(void)setpageView
{
    UIPageControl *page = [[UIPageControl alloc] init];
    page.numberOfPages = _imageNumber;
    CGSize size = [page sizeForNumberOfPages:_imageNumber];
    page.bounds = CGRectMake(0, 0, size.width, size.height);
    page.center = CGPointMake(_mainRect.size.width*0.5, _mainRect.size.height+10);
    page.pageIndicatorTintColor = [UIColor grayColor];
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.currentPage = 0;
    self.page = page;
    
    if (self.sDirection == scrollDirectionHorizontalMoved) {
        _page.hidden = NO;
    }else{
        _page.hidden = YES;
    }
    [self addSubview:_page];
    
}

-(void)clickImageView:(long)currentpage
{
    if ([self.delegate respondsToSelector:@selector(didSelectView:)]) {
        [self.delegate didSelectView:_currentpage];
    }
}

-(void)startTimer{
    self.timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)updateTimer{
    if (self.sDirection == scrollDirectionHorizontalMoved) {
        long x = (_page.currentPage + 1) % _imageNumber;
        _page.currentPage = x;
        _currentpage = _page.currentPage;
        [_mainScrollView setContentOffset:CGPointMake(2*_mainRect.size.width, 0) animated:YES];
    }else{
        long y = (_page.currentPage + 1) % _imageNumber;
        _page.currentPage = y;
        _currentpage = _page.currentPage;
        [_mainScrollView setContentOffset:CGPointMake(0, 2*_mainRect.size.height) animated:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.sDirection == scrollDirectionHorizontalMoved) {
        if (_mainScrollView.contentOffset.x == 0) {
            _currentpage = _currentpage-1 == -1 ? _imageNumber-1 : _currentpage-1;
            [self setImageView];
        }else if ( ABS(_mainScrollView.contentOffset.x - 2*_mainRect.size.width) < 0.000001){
            _currentpage = _currentpage+1 == _imageNumber ? 0 : _currentpage+1;
            [self setImageView];
        }
    }else{
        if ( _mainScrollView.contentOffset.y == 0) {
            _currentpage = _currentpage-1 == -1 ? _imageNumber-1 : _currentpage-1;
            [self setImageView];
        }else if (  ABS(_mainScrollView.contentOffset.y - 2*_mainRect.size.height) < 0.000001){
            _currentpage = _currentpage+1 == _imageNumber ? 0 : _currentpage+1;
            [self setImageView];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self setImageView];
}

@end
