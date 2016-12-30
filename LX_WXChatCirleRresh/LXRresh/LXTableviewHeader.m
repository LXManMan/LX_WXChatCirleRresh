//
//  LXTableviewHeader.m
//  WeChatRefresh
//
//  Created by chuanglong02 on 16/12/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "LXTableviewHeader.h"

@implementation LXTableviewHeader
{
    UIImageView *_backgroundImageView;
    UIImageView *_iconView;
    UILabel *_nameLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        
        self.backgroundColor =[UIColor redColor];
        
    }
    return self;
}
- (void)setup
{
    
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.image = [UIImage imageNamed:@"IMG_2936.jpg"];
    [self addSubview:_backgroundImageView];
    
    _iconView = [UIImageView new];
    _iconView.image = [UIImage imageNamed:@"icon.jpg"];
    
    
    _iconView.layer.borderWidth = 3;
    _iconView.layer.borderColor = [UIColor lightTextColor].CGColor;
    [self addSubview:_iconView];
    
    _nameLabel = [UILabel new];
    _nameLabel.text = @"漫漫";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentRight;
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_nameLabel];
    
    _backgroundImageView.frame = CGRectMake(0, -60, KWidth, CGRectGetHeight(self.frame)+60);
  
    _iconView.frame = CGRectMake(KWidth - 70 -15, CGRectGetHeight(self.frame)-40, 70, 70);
   
    _nameLabel.frame = CGRectMake(KWidth - 70 -15 -20-200, CGRectGetHeight(self.frame)-20-10, 200, 20);
    
}
@end
