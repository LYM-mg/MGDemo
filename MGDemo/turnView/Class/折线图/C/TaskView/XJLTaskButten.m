//
//  XJLTaskButten.m
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/22.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import "XJLTaskButten.h"

@interface XJLTaskButten()

@end

@implementation XJLTaskButten

#pragma mark 重写初始化方法
- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithType:(XJLTaskCompleteType)type
{
    self = [super init];
    if (self) {
        [self setUpWithType:type];
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    XJLTaskButten *button = [super buttonWithType:buttonType];
    if (button) {
        [button setUp];
    }
    return button;
}

- (void)setUp
{
    // 解决约束警告
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.cornerRadius = 12 * ScreenHeightRatio;
    self.layer.masksToBounds = YES;
    
    if (self.type == XJLTaskUnComplete) {
        self.backgroundColor = MGColor(238, 238, 238);
        [self setTitle:NSLocalizedString(@"PC_TASK_NOT_COMPLETED", nil) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11 * ScreenWidthRatio];
        [self setTitleColor:MGColor(170, 170, 170) forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }else if(self.type == XJLTaskUnReceive){
        self.backgroundColor = MGColor(255, 121, 121);
        [self setTitle:NSLocalizedString(@"PC_TASK_RECEIVE_TIP", nil) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11 * ScreenWidthRatio];
        [self setTitleColor:MGColor(254, 254, 254) forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    }else{
        self.backgroundColor = MGColor(238, 238, 238);
        [self setTitle:NSLocalizedString(@"PC_TASK_RECEIVED_TIP", nil) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11 * ScreenWidthRatio];
        [self setTitleColor:MGColor(170, 170, 170) forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }
}

- (void)setUpWithType:(XJLTaskCompleteType)type
{
    // 解决约束警告
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.cornerRadius = 12 * ScreenHeightRatio;
    self.layer.masksToBounds = YES;
    if (type == XJLTaskUnComplete) {
        self.backgroundColor = MGColor(238, 238, 238);
        [self setTitle:NSLocalizedString(@"PC_TASK_NOT_COMPLETED", nil) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11 * ScreenWidthRatio];
        [self setTitleColor:MGColor(170, 170, 170) forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }else if(type == XJLTaskUnReceive){
        self.backgroundColor = MGColor(255, 121, 121);
        [self setTitle:NSLocalizedString(@"PC_TASK_RECEIVE_TIP", nil) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11 * ScreenWidthRatio];
        [self setTitleColor:MGColor(254, 254, 254) forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    }else{
        self.backgroundColor = MGColor(238, 238, 238);
        [self setTitle:NSLocalizedString(@"PC_TASK_RECEIVED_TIP", nil) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11 * ScreenWidthRatio];
        [self setTitleColor:MGColor(170, 170, 170) forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }
}


@end
