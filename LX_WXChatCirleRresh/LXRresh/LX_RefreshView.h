//
//  LX_RefreshView.h
//  WeChatRefresh
//
//  Created by chuanglong02 on 16/12/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LXWXRefreshViewStateNormal,
    LXWXRefreshViewStateWillRefresh,
    LXWXRefreshViewStateRefreshing,
} LXWXRefreshViewState;

@interface LX_RefreshView : UIView <CAAnimationDelegate>


+ (instancetype)refreshHeaderWithCenter:(CGPoint)center;

@property(nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic, copy) void(^refreshingBlock)();

@property (nonatomic, assign) LXWXRefreshViewState refreshState;
- (void)endRefreshing;

@end
