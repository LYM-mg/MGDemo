//
//  MGAlertController.m
//  MGDemo
//
//  Created by newunion on 2018/1/17.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGAlertController.h"

@interface MGAlertController ()
{
    UIView *redView;
    UIImageView *iconView;
    UILabel *titleLabel;
    UIButton *btn;
}
@end

@implementation MGAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:redView];
    
    iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"晴60x60@3x"]];
    iconView.backgroundColor = [UIColor greenColor];
    [redView addSubview:iconView];

    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"你就是一个大笨蛋，我读不想理你了  你自己去玩耍吧 再见！！！！";
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.numberOfLines = 0;
    [redView addSubview:titleLabel];
    
    btn = [UIButton new];
    [btn setTitle: @"ok" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
}

- (void)updateViewConstraints {
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(MGSCREEN_WIDTH*0.6);
//        make.height.mas_equalTo(200);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(btn.mas_top);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.centerY.mas_equalTo(redView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.centerY.mas_equalTo(redView);
        make.top.mas_equalTo(redView).offset(20);
        make.bottom.mas_equalTo(redView).offset(-20);
    }];
    [super updateViewConstraints];
}

- (void)close {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
