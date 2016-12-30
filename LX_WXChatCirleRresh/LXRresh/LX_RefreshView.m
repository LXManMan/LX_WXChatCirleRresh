//
//  LX_RefreshView.m
//  WeChatRefresh
//
//  Created by chuanglong02 on 16/12/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "LX_RefreshView.h"
NSString *const ObserveKeyPath = @"contentOffset";
static const CGFloat contentOffetY = -64.f;
NSString *const  AnimationKey =@"animationKey";
NSString *const  PositionKey =@"position";
@implementation LX_RefreshView
{
    CABasicAnimation *_rotateAnimation;
}
+ (instancetype)refreshHeaderWithCenter:(CGPoint)center
{
    LX_RefreshView *refreshView = [LX_RefreshView new];
    refreshView.center = center;
    return refreshView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"]];
    self.bounds = imageView.bounds;
    [self addSubview:imageView];
    
    _rotateAnimation = [[CABasicAnimation alloc] init];
    _rotateAnimation.keyPath = @"transform.rotation.z";
    _rotateAnimation.fromValue = @0;
    _rotateAnimation.toValue = @(M_PI * 2);
    _rotateAnimation.duration = 1.0;
    _rotateAnimation.repeatCount = MAXFLOAT;
    
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    
    [scrollView addObserver:self forKeyPath:ObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:ObserveKeyPath];
    }
}
- (void)endRefreshing
{
    self.refreshState = LXWXRefreshViewStateNormal;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
   
    if (keyPath != ObserveKeyPath) return;
    
    [self updateRefreshHeaderWithOffsetY:self.scrollView.contentOffset.y];
}
- (void)updateRefreshHeaderWithOffsetY:(CGFloat)y
{
   
    CGFloat rotateValue = y / 47.0 * M_PI;
   
    if (y < contentOffetY) {
        y = contentOffetY;
               if (self.scrollView.isDragging && self.refreshState != LXWXRefreshViewStateWillRefresh) {
            self.refreshState = LXWXRefreshViewStateWillRefresh;
            
        } else if (!self.scrollView.isDragging && self.refreshState == LXWXRefreshViewStateWillRefresh) {
            
            self.refreshState = LXWXRefreshViewStateRefreshing;
        }    }
    
    if (self.refreshState == LXWXRefreshViewStateRefreshing) return;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, -y);
    transform = CGAffineTransformRotate(transform, rotateValue);
    
    self.transform = transform;
    
}

- (void)setRefreshState:(LXWXRefreshViewState)refreshState
{
    _refreshState =  refreshState;

    if (refreshState  == LXWXRefreshViewStateWillRefresh) {
        
        self.hidden = NO;
    }
    if (refreshState == LXWXRefreshViewStateRefreshing) {
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        
        [self.layer addAnimation:_rotateAnimation forKey:AnimationKey];
    } else if (refreshState == LXWXRefreshViewStateNormal) {
        
        [self.layer removeAnimationForKey:AnimationKey];
        self.transform = CGAffineTransformIdentity;
        CABasicAnimation *basic =[CABasicAnimation animation];
        basic.keyPath = @"position";
        basic.fromValue =[NSValue valueWithCGPoint:self.center];
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, -self.center.y)];
        basic.duration = 0.5;
        basic.delegate = self;
        [self.layer addAnimation:basic forKey:PositionKey];
    }
}
-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    if ([anim.keyPath isEqualToString:PositionKey]) {
        [self.layer removeAnimationForKey:PositionKey];
        self.hidden = YES;
    }
}
@end
