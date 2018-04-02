//
//  XJLTaskCell.m
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import "XJLTaskCell.h"

//static CGFloat receiveBtnHeight = 24;

@implementation XJLTaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.image = ({
            UIImageView *image = [[UIImageView alloc]init];
            [self addSubview:image];
            image;
        });
        
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont boldSystemFontOfSize:15 * ScreenWidthRatio];
            label.textColor = MGColor(27, 27, 27);
            [self addSubview:label];
            label;
        });
        
        self.contentLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont boldSystemFontOfSize:13 * ScreenWidthRatio];
            label.textColor = MGColor(170, 170, 170);
            [self addSubview:label];
            label;
        });
        
        self.receiveBtn = ({
            XJLTaskButten *btn = [[XJLTaskButten alloc]initWithType:self.type];
            [self addSubview:btn];
            btn;
        });
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18 * ScreenHeightRatio);
        make.left.mas_equalTo(15 * ScreenWidthRatio);
        make.size.mas_equalTo(CGSizeMake(14 * ScreenWidthRatio, 14 * ScreenHeightRatio));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.mas_right).offset(7 * ScreenWidthRatio);
        make.centerY.equalTo(self.image.mas_centerY);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.mas_bottom).offset(5 * ScreenHeightRatio);
        make.leading.equalTo(self.image.mas_leading);
    }];
    
    [self.receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-15 * ScreenWidthRatio);
        make.size.mas_equalTo(CGSizeMake(50 * ScreenWidthRatio, 24 * ScreenHeightRatio));
    }];
}

@end
