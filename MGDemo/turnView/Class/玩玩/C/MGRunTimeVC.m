//
//  MGRunTimeVC.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGRunTimeVC.h"
#import "MGPhotoCollectionViewController.h"
#import "MGHeTableViewController.h"
#import "UIView+Drag.h"

@interface MGRunTimeVC ()
@property (nonatomic,weak)UIView *firstView;
@end

@implementation MGRunTimeVC

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBGImage:@"lol"];
//    self.navigationController.navigationBar.mg_hideStatusBarBackgroungView = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"photo布局" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    __weakSelf;
    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,100, 100, 30)];
    tapLabel.text = @"点我啊";
    tapLabel.userInteractionEnabled = YES;
    [tapLabel addGestureRecognizer:[UITapGestureRecognizer mg_gestureRecognizerWithActionBlock:^(id gesture) {
        [weakSelf showHint:@"响应tap手势点击"];
        [weakSelf.navigationController pushViewController:[MGHeTableViewController new] animated:true ];
//        [weakSelf showDetailViewController:[MGHeTableViewController new] sender:nil];
    }]];
    [self.view addSubview:tapLabel];
    
    // 按钮测试
    UIButton *btn = [UIButton ButtonWithTitle:@"嘿嘿" actionBlock:^(id btn) {
        [weakSelf showHint:@"响应按钮事件的点击"];
    }];
    btn.origin = CGPointMake(220, 100);
    [self.view addSubview:btn];
    
    [self DragView];
}

- (void)DragView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    view.backgroundColor = [UIColor grayColor];
    view.mg_isAdsorb = NO;
    view.mg_bounces = YES;
    view.mg_canDrag = YES;
    self.firstView = view;
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [view addSubview:slider];
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    view1.center = self.view.center;
    NSLog(@"vc = %.2lf",view1.frame.origin.x);
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 70)];
    view2.backgroundColor = [UIColor redColor];
    
    view2.mg_canDrag = YES;
    view2.mg_bounces = NO;
    view2.mg_isAdsorb = YES;
    [view1 addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 40, 50)];
    view3.backgroundColor = [UIColor greenColor];
    view3.mg_canDrag = YES;
    view3.mg_bounces = YES;
    view3.mg_isAdsorb = YES;
    [view1 addSubview:view3];
}

- (void)tapClick {
     [self showHint:@"响应tap -- init 手势点击"];
}


- (void)rightClick {
    [self showViewController:[MGPhotoCollectionViewController new] sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
+ (void)load {
    [self mg_SwitchMethod:self originalSelector:@selector(viewWillAppear:) swizzledSelector:@selector(mg_layoutSubviews)];
    [self mg_SwitchMethod:self originalSelector:@selector(viewDidAppear:) swizzledSelector:@selector(__layoutSubviews)];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.mg_hideStatusBarBackgroungView = YES;
}

- (void)mg_layoutSubviews {
    NSLog(@"我是来替换layoutSubviews的");
}

- (void)__layoutSubviews {
     NSLog(@"我是来替换__layoutSubviews的");
}

@end
