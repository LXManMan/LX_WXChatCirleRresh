//
//  TextViewController.m
//  WeChatRefresh
//
//  Created by chuanglong02 on 16/12/30.
//  Copyright © 2016年 漫漫. All rights reserved.
//

#import "TextViewController.h"
#import "LXTableviewHeader.h"

#import "LX_RefreshView.h"
NSString *const ScrollkeyPath = @"contentOffset";
@interface TextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation TextViewController
{
    LX_RefreshView *_refreshHeader;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_refreshHeader.superview) {
        
        _refreshHeader = [LX_RefreshView refreshHeaderWithCenter:CGPointMake(40, 45)];
        _refreshHeader.scrollView = self.tableview;
        __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
        __weak typeof(self) weakSelf = self;
        [_refreshHeader setRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSArray *array =@[@"人上一百，形形色色",@"林深时见鹿，深蓝时见鲸",@"情开一朵，爱难临摹",@"一生一世一双人",@"于小事成佛，于小人成魔"];
                [weakSelf.data removeAllObjects];
                for (int  i = 0; i< 100; i++) {
                    NSString *string =array[arc4random() % 5];
                    [weakSelf.data addObject:string];
                }
                
                [weakHeader endRefreshing];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableview reloadData];
                });
            });
        }];
        [self.tableview.superview addSubview:_refreshHeader];
    } else {
        [self.tableview.superview bringSubviewToFront:_refreshHeader];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];

//
    [self.view addSubview:self.tableview];
    LXTableviewHeader *header = [[LXTableviewHeader alloc]initWithFrame:CGRectMake(0, 0, KWidth, 260)];
    self.tableview.tableHeaderView = header;
   
    
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.data[indexPath.row];
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView =[UIView new];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}
-(NSMutableArray *)data
{
    if (!_data) {
        _data =[NSMutableArray array];
    }
    return _data;
    
}@end
