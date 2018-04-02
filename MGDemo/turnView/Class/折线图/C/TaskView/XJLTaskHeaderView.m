//
//  XJLTaskHeaderView.m
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import "XJLTaskHeaderView.h"
#import "XJLTaskButten.h"

static CGFloat headerHeight = 60;
static CGFloat completeBtnHeight = 24;

@interface XJLTaskHeaderView()

@property (nonatomic, strong) UILabel *titleTask;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *uplodeHeader;
@property (nonatomic, strong) UILabel *awardDescribe;
@property (nonatomic, strong) XJLTaskButten *completeBtn;
//@property (nonatomic, strong) UILabel *dailyTask;

@end

@implementation XJLTaskHeaderView

- (instancetype)init{
    if ([super init]) {
    
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.titleTask = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont boldSystemFontOfSize:15 * ScreenWidthRatio];
            label.textColor = MGColor(27, 27, 27);
            label.text = NSLocalizedString(@"PC_TASK_NEW_TASK", nil);
            [self addSubview:label];
            label;
        });
        
        self.headerImage = ({
            UIImageView *image = [[UIImageView alloc]init];
            image.layer.cornerRadius = headerHeight * 0.5 * ScreenWidthRatio;
            image.image = [UIImage imageNamed:@"user_head"];
            [self addSubview:image];
            image;
        });
        
        self.uplodeHeader = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:15 * ScreenWidthRatio];
            label.textColor = MGColor(27, 27, 27);
            label.text = NSLocalizedString(@"PC_TASK_UPLODE_HEADS_TASK", nil);
            [self addSubview:label];
            label;
        });
        
        self.awardDescribe = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13 * ScreenWidthRatio];
            label.textColor = MGColor(170, 170, 170);
            label.text = [NSString stringWithFormat:@"%@150%@",NSLocalizedString(@"PC_TASK_RECEIVE", nil),NSLocalizedString(@"PC_TASK_NUMBER_OLIVES", nil)];
            [self addSubview:label];
            label;
        });
        
        self.completeBtn = ({
            XJLTaskButten *btn = [[XJLTaskButten alloc]initWithType:XJLTaskReceived];
            [self addSubview:btn];
            btn;
        });
        
//        self.dailyTask = ({
//            UILabel *label = [[UILabel alloc]init];
//            label.font = [UIFont boldSystemFontOfSize:15 * ScreenWidthRatio];
//            label.textColor = RGB(27, 27, 27);
//            label.text = NSLocalizedString(@"PC_TASK_DAILY_TASK", nil);
//            [self addSubview:label];
//            label;
//        });
        
         [self setupConstraints];
    }
    return self;
}

- (void)setupConstraints{
    [self.titleTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * ScreenWidthRatio);
        make.top.mas_equalTo(15 * ScreenHeightRatio);
        make.height.mas_equalTo(15 * ScreenHeightRatio);
    }];
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * ScreenWidthRatio);
        make.top.equalTo(self.titleTask.mas_bottom).offset(15 * ScreenHeightRatio);
        make.size.mas_equalTo(CGSizeMake(headerHeight * ScreenWidthRatio, headerHeight * ScreenWidthRatio));
    }];
    
    [self.uplodeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImage.mas_right).offset(10 * ScreenWidthRatio);
        make.top.equalTo(self.headerImage).offset(14 * ScreenHeightRatio);
    }];
    
    [self.awardDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.uplodeHeader);
        make.bottom.equalTo(self.headerImage).offset(-14 * ScreenHeightRatio);
    }];
    
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15 * ScreenWidthRatio);
        make.centerY.equalTo(self.headerImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50 * ScreenWidthRatio, completeBtnHeight * ScreenHeightRatio));
    }];
    
//    [self.dailyTask mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15 * ScreenWidthRatio);
//        make.top.equalTo(self.headerImage.mas_bottom).offset(29 * ScreenHeightRatio);
//    }];
}

@end
