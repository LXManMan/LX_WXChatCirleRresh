//
//  ViewController.m
//  WeChatRefresh
//
//  Created by chuanglong02 on 16/12/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "ViewController.h"

#import "TextViewController.h"
@interface ViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
     __weak  ViewController *weakSelf = self;
    
        LxButton *buttonOne = [LxButton LXButtonWithTitle:@"仿朋友圈刷新" titleFont:[UIFont systemFontOfSize:16.0] Image:nil backgroundImage:nil backgroundColor:[UIColor lightGrayColor] titleColor:[UIColor blackColor] frame:CGRectMake(KWidth/2 - 100, 300, 200, 40)];
    
    [self.view addSubview:buttonOne];
    
    [buttonOne addClickBlock:^(UIButton *button) {
        TextViewController *tab = [[TextViewController alloc]init];
        [weakSelf.navigationController pushViewController:tab animated:YES];
    }];
    
}



@end
