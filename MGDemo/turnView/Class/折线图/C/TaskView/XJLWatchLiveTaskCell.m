 //
//  XJLWatchLiveTaskCell.m
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import "XJLWatchLiveTaskCell.h"
#import "XJLTaskLittleView.h"

@interface XJLWatchLiveTaskCell()

@property (nonatomic, strong) XJLTaskLittleView *firstTimeView;
@property (nonatomic, strong) XJLTaskLittleView *secondTimeView;
@property (nonatomic, strong) XJLTaskLittleView *thirdTimeView;
@property (nonatomic, strong) UIImageView *watchImage;
@property (nonatomic, strong) UILabel *watchLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UIImageView *leftImage;

@end

@implementation XJLWatchLiveTaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.watchImage = ({
            UIImageView *image = [[UIImageView alloc]init];
            image.image = [UIImage imageNamed:@"icon_watching_mission"];
            [self addSubview:image];
            image;
        });
        
        self.watchLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:15 * ScreenWidthRatio];
            label.textColor = MGColor(27, 27, 27);
            label.text = NSLocalizedString(@"PC_RANK_WATCH_LIVE", nil);
            [self addSubview:label];
            label;
        });
        
        self.introduceLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:13 * ScreenWidthRatio];
            label.textColor = MGColor(170, 170, 170);
            label.text = NSLocalizedString(@"PC_TASK_ENOUGH_TIME", nil);
            [self addSubview:label];
            label;
        });
        
        self.leftImage = ({
            UIImageView *image = [[UIImageView alloc]init];
            image.image = [UIImage imageNamed:@"icon_into_mission"];
            [self addSubview:image];
            image;
        });
        
        self.rightImage = ({
            UIImageView *image = [[UIImageView alloc]init];
            image.image = [UIImage imageNamed:@"icon_into_mission"];
            [self addSubview:image];
            image;
        });
        
        self.firstTimeView = ({
            XJLTaskLittleView *view = [[XJLTaskLittleView alloc]initWithType:XJLTaskUnComplete];
            view.backgroundColor = [UIColor clearColor];
            view.image.image = [UIImage imageNamed:@"icon_olive_rank"];
            view.ruleLabel.text = [NSString stringWithFormat:@"5%@/5%@",NSLocalizedString(@"PC_TASK_NUMBER_OLIVES", nil),NSLocalizedString(@"PC_RANK_MINS", nil)];
            [self addSubview:view];
            view;
        });
        
        self.secondTimeView = ({
            XJLTaskLittleView *view = [[XJLTaskLittleView alloc]initWithType:XJLTaskReceived];
            view.backgroundColor = [UIColor clearColor];
            view.image.image = [UIImage imageNamed:@"icon_olive_rank"];
            view.ruleLabel.text = [NSString stringWithFormat:@"30%@/30%@",NSLocalizedString(@"PC_TASK_NUMBER_OLIVES", nil),NSLocalizedString(@"PC_RANK_MINS", nil)];
            [self addSubview:view];
            view;
        });
        
        self.thirdTimeView = ({
            XJLTaskLittleView *view = [[XJLTaskLittleView alloc]initWithType:XJLTaskUnReceive];
            view.backgroundColor = [UIColor clearColor];
            view.image.image = [UIImage imageNamed:@"pic_olive_unfinished"];
            view.ruleLabel.text = [NSString stringWithFormat:@"60%@/60%@",NSLocalizedString(@"PC_TASK_NUMBER_OLIVES", nil),NSLocalizedString(@"PC_RANK_MINS", nil)];
            [self addSubview:view];
            view;
        });
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self.watchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15 * ScreenWidthRatio);
        make.top.mas_equalTo(18 * ScreenHeightRatio);
        make.size.mas_equalTo(CGSizeMake(14 * ScreenWidthRatio, 14 * ScreenHeightRatio));
    }];
    
    [self.watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.watchImage.mas_right).offset(7 * ScreenWidthRatio);
        make.centerY.equalTo(self.watchImage.mas_centerY);
    }];
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.watchImage.mas_bottom).offset(5 * ScreenHeightRatio);
        make.leading.equalTo(self.watchImage.mas_leading);
        make.height.mas_equalTo(14 * ScreenHeightRatio);
    }];
    
    [self.secondTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.introduceLabel.mas_bottom).offset(18 * ScreenHeightRatio);
        make.size.mas_equalTo(CGSizeMake(90 * ScreenWidthRatio, 109 * ScreenHeightRatio));
    }];
    
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondTimeView.mas_top).offset(19);
        make.right.equalTo(self.secondTimeView.mas_left).offset(-12 * ScreenWidthRatio);
        make.size.mas_equalTo(CGSizeMake(13 * ScreenWidthRatio, 13 * ScreenHeightRatio));
    }];
    
    [self.firstTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.secondTimeView.mas_left).offset(-38 * ScreenWidthRatio);
        make.top.equalTo(self.secondTimeView.mas_top);
        make.size.mas_equalTo(CGSizeMake(90 * ScreenWidthRatio, 109 * ScreenHeightRatio));
    }];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondTimeView.mas_right).offset(12 * ScreenHeightRatio);
        make.top.equalTo(self.secondTimeView.mas_top).offset(19);
        make.size.mas_equalTo(CGSizeMake(13 * ScreenWidthRatio, 13 * ScreenHeightRatio));
    }];
    
    [self.thirdTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondTimeView.mas_right).offset(38 * ScreenWidthRatio);
        make.top.equalTo(self.secondTimeView.mas_top);
        make.size.equalTo(self.secondTimeView);
    }];
}


@end
