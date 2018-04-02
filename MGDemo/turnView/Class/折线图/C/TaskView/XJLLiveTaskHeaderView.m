//
//  XJLLiveTaskHeaderView.m
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import "XJLLiveTaskHeaderView.h"

@interface XJLLiveTaskHeaderView()

@property (nonatomic, strong) UILabel *titleTask;

@end

@implementation XJLLiveTaskHeaderView

- (instancetype)init{
    if ([super init]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleTask = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont boldSystemFontOfSize:15 * ScreenWidthRatio];
            label.textColor = MGColor(27, 27, 27);
            label.text = NSLocalizedString(@"PC_TASK_DAILY_TASK", nil);
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15 * ScreenWidthRatio);
                make.top.mas_equalTo(15 * ScreenHeightRatio);
            }];
            label;
        });   
         
    }
    return self;
}

@end
