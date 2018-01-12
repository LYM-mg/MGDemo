//  MGHeTableViewController.m
//  MGDemo
//  Created by i-Techsys.com on 2017/8/16.
//  Copyright © 2017年 ming. All rights reserved.
// https://github.com/LYM-mg
// http://www.jianshu.com/u/57b58a39b70e

#import "MGHeTableViewController.h"
#import "MGPolygonVC.h"
#import "MJRefresh.h"

@interface MGHeTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MGHeTableViewController

- (UITableView *)tableView {
    if (!_tableView) {
        /// 创建_itemTableView(点击header弹出的tableView)
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.alpha = 0.7f;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点我啊";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    // 上拉刷新
    self.tableView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新数据
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
        });
    }];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tableView.contentOffset.y <= 0) {
        self.tableView.contentOffset = CGPointZero;
        self.navigationController.navigationBar.hidden = YES;
//        [self.navigationController setNavigationBarHidden:YES  animated:animated];
    }else {
        self.navigationController.navigationBar.hidden = NO;
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.backgroundColor = [UIColor randomColor];
    cell.textLabel.text = [NSString stringWithFormat:@"mg明明%ld",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showViewController:[MGPolygonVC new] sender:nil];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"+++++++%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > 0) {
        self.navigationController.navigationBar.hidden = NO;
    }else {
        self.navigationController.navigationBar.hidden = YES;
    }
    
}

 @end
