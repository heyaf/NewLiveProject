//
//  TableFooterRefreshView.m
//  TableRefreshDemo
//
//  Created by 宫城 on 16/1/2.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import "TableFooterRefreshView.h"
#import "RefreshView.h"
#import "RefreshLabelView.h"

#define kRefreshViewWidth  200
#define kRefreshViewHeight 80

#define kMaxPullUpDistance   84

typedef void(^RefreshingBlock)(void);

@interface TableFooterRefreshView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) RefreshView *refreshView;
@property (nonatomic, strong) RefreshLabelView *refreshLBView;

@property (nonatomic, assign) CGFloat originOffset;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL notTracking;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, copy) RefreshingBlock refreshingBlock;

@end

@implementation TableFooterRefreshView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView hasNavigationBar:(BOOL)hasNavigationBar {
    self = [super initWithFrame:CGRectMake((CGRectGetWidth(scrollView.frame) - kRefreshViewWidth)/2, CGRectGetHeight(scrollView.frame), kRefreshViewWidth, kRefreshViewHeight)];
    if (self) {
        if (hasNavigationBar) {
            self.originOffset = 64.0;
        }else {
            self.originOffset = 0.0;
        }
        [self setUI];
        self.scrollView = scrollView;
        [self.scrollView insertSubview:self atIndex:0];
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        self.hidden = YES;
    }
    return self;
}

- (void)setUI {
    self.refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(20, 0, 40, CGRectGetHeight(self.frame))];
    [self insertSubview:self.refreshView atIndex:0];
    
    CGFloat lbX = self.refreshView.frame.origin.x + CGRectGetWidth(self.refreshView.frame) + 10;
    CGFloat lbWidth = kRefreshViewWidth - lbX - 30;
    self.refreshLBView = [[RefreshLabelView alloc] initWithFrame:CGRectMake(lbX , 0, lbWidth, CGRectGetHeight(self.frame))];
    self.refreshLBView.direction = UP;
    [self insertSubview:self.refreshLBView aboveSubview:self.refreshView];
}

- (void)setProgress:(CGFloat)progress {
    if (CGRectGetHeight(self.scrollView.frame) > self.contentSize.height) {
        return;
    }
    
    if (!self.scrollView.tracking) {
        self.refreshLBView.isLoading = YES;
    }
    
    if (!self.isLoading) {
        self.refreshView.progress = progress;
        self.refreshLBView.progress = progress;
    }
    
    CGFloat overDistance = self.scrollView.contentOffset.y - (self.scrollView.contentSize.height - CGRectGetHeight(self.scrollView.frame)) - kMaxPullUpDistance + 10;
    if (overDistance > 0) {
        if (!self.scrollView.tracking && self.hidden == NO) {
            if (!self.notTracking) {
                self.notTracking = YES;
                self.isLoading = YES;
                
                [self startLoading:self.refreshView];
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.scrollView.contentInset = UIEdgeInsetsMake(self.originOffset, 0, kMaxPullUpDistance, 0);
                } completion:^(BOOL finished) {
                    if (self.refreshingBlock) {
                        self.refreshingBlock();
                    }
                }];
            }
        }
        
        if (!self.isLoading) {
            self.refreshView.transform = CGAffineTransformMakeRotation(overDistance/40);
        }
    }else {
        self.refreshLBView.isLoading = NO;
        self.refreshView.transform = CGAffineTransformIdentity;
    }
}

- (void)startLoading:(UIView *)view {
    CABasicAnimation *rotationZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationZ.fromValue = @(0);
    rotationZ.toValue = @(M_PI*2);
    rotationZ.repeatCount = HUGE_VAL;
    rotationZ.duration = 1.0;
    rotationZ.cumulative = YES;
    [view.layer addAnimation:rotationZ forKey:@"footerRotationZ"];
}

- (void)stopLoading:(UIView *)view {
    [view.layer removeAllAnimations];
}

- (void)stopRefresh {
    self.progress = 1.0;
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
        self.scrollView.contentInset = UIEdgeInsetsMake(self.originOffset + 0.1, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.alpha = 1.0;
        self.notTracking = NO;
        self.isLoading = NO;
        self.refreshLBView.isLoading = NO;
        [self stopLoading:self.refreshView];
    }];
}

- (void)addRefreshingBlock:(void(^)())block {
    self.refreshingBlock = block;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        self.contentSize = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue];
        if (self.contentSize.height >= CGRectGetHeight(self.scrollView.frame)) {
            self.hidden = NO;
        }
    }
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (contentOffset.y >= (self.contentSize.height - CGRectGetHeight(self.scrollView.frame))) {
            self.progress = MAX(0.0, MIN((contentOffset.y - (self.contentSize.height - CGRectGetHeight(self.scrollView.frame)))/kMaxPullUpDistance, 1.0));
            self.center = CGPointMake(self.center.x, self.contentSize.height + kRefreshViewHeight/2);
        }
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end
