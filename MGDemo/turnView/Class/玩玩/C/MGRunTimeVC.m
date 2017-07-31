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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBGImage:@"lol"];
//    self.navigationController.navigationBar.mg_hideStatusBarBackgroungView = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"photo布局" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
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
