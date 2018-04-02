//
//  XJLTaskLittleView.m
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import "XJLTaskLittleView.h"

static CGFloat completeBtnHeight = 24;

@implementation XJLTaskLittleView

- (instancetype)initWithType:(XJLTaskCompleteType)type{
    if ([super init]) {
        
        self.image = ({
            UIImageView *imagView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_olive_rank"]];
            [self addSubview:imagView];
            imagView;
        });
        
        self.ruleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:11 * ScreenWidthRatio];
            label.textColor = MGColor(170, 170, 170);
            [self addSubview:label];
            label;
        });
        
        self.receiveBtn = ({
            XJLTaskButten *btn = [[XJLTaskButten alloc]initWithType:type];
            [self addSubview:btn];
            btn;
        });
        
        [self setUpUIWithType:type];
    }
    return self;
}

- (void)setUpUIWithType:(XJLTaskCompleteType)type{
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50 * ScreenWidthRatio, 50 * ScreenWidthRatio));
    }];
    
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.mas_bottom).offset(8 * ScreenHeightRatio);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(12 * ScreenHeightRatio);
    }];
    
    [self.receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ruleLabel.mas_bottom).offset(13 * ScreenHeightRatio);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(50 * ScreenWidthRatio, completeBtnHeight * ScreenHeightRatio));
    }];
    
    if (type == XJLTaskUnComplete) {
        self.image.image = [UIImage imageNamed:@"pic_olive_unfinished"];
    }else{
        self.image.image = [UIImage imageNamed:@"icon_olive_rank"];
    }
}

@end
