//
//  MGRunTimeVC.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGRunTimeVC.h"
#import "MGPhotoCollectionViewController.h"

@interface MGRunTimeVC ()

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
    }]];
    [self.view addSubview:tapLabel];
    
    // 按钮测试
    UIButton *btn = [UIButton ButtonWithTitle:@"嘿嘿" actionBlock:^(id btn) {
        [weakSelf showHint:@"响应按钮事件的点击"];
    }];
    btn.origin = CGPointMake(220, 100);
    [self.view addSubview:btn];
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
    self.navigationController.navigationBar.mg_hideStatusBarBackgroungView = YES;
}

- (void)mg_layoutSubviews {
    NSLog(@"我是来替换layoutSubviews的");
}

- (void)__layoutSubviews {
     NSLog(@"我是来替换__layoutSubviews的");
}

@end
