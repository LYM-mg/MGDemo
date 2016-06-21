//
//  MGHeadView.m
//  turnView
//
//  Created by ming on 16/6/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGHeadView.h"
#import "MGSectionModel.h"

@interface MGHeadView ()
/** 箭头图片 */
@property (nonatomic, strong) UIImageView *arrowImageView;

/** 头部titke控件 */
@property (nonatomic, strong) UILabel *titleLabel;
@end


@implementation MGHeadView
// 初始化子控件 
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加箭头
        self.arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expend"]];
        [self.contentView addSubview:self.arrowImageView];
        
        // 添加titleLabel
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor purpleColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titleLabel];
        
        // 添加按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClickOnExpand:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        button.frame = CGRectMake(0, 0, MGScreen_W, 44);
        
        CALayer *line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, 44 - 0.5, MGScreen_W, 0.5);
        line.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.contentView.layer addSublayer:line];
        
        self.contentView.backgroundColor = [UIColor grayColor];
    }
    return self;
}

// 重写model的setter方法
- (void)setModel:(MGSectionModel *)model{
    if (_model == model)
        return;
    
    _model = model;
    if (model.isExpanded) { // 已经展开
        self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
    } else { // 未展开
        self.arrowImageView.transform = CGAffineTransformIdentity;
    }
    
    self.titleLabel.text = model.sectionTitle;
}

// 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.arrowImageView.frame = CGRectMake(10, (44 - 8) / 2, 30,  16);
    
    self.titleLabel.frame = CGRectMake(55, 0, 200, 44);
}


// 按钮点击
- (void)buttonClickOnExpand:(UIButton *)btn{
    self.model.isExpanded = !self.model.isExpanded;
    
    // 判断模型是否展开
    [UIView animateWithDuration:0.28 animations:^{
        if (self.model.isExpanded) { // 展开
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
            
        } else { // 未展开
            self.arrowImageView.transform = CGAffineTransformIdentity;
        }
    }];
    
    // 代码回调
    if (self.expandCallback) {
        self.expandCallback(self.model.isExpanded);
    }
}

@end
