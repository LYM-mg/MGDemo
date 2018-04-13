//
//  MGMarqueeView.m
//  ScrollDemo
//
//  Created by newunion on 2018/4/11.
//  Copyright © 2018年 newunion. All rights reserved.
//

#import "MGMarqueeView.h"
#import "UIView+LYMExtension.h"
#import "UIColor+LYMExtension.h"

@interface MGMarqueeView()
@property (weak,nonatomic) UIButton *closeBtn;
@property (weak,nonatomic) UIImageView *volumeImageView;
@end


@implementation MGMarqueeView
{
    UILabel *_marqueeLabel;
    /** 控制跑马灯的timer */
    CADisplayLink *_timer;
    int64_t count; // 展示的是数组的时候
    BOOL isMarqueeArray;  // 跑马灯展示文字是否是数组
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // UI搭建
        [self setUpUI];
        self.speed = 0.3;
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI {
    self.backgroundColor = [UIColor colorWithHexString:@"fff4d8"];
    
    //------- 左边的喇叭 -------//
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 9, 16, 12)];
    imageView.centerY = self.height/2;
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"new_home_notice"];
    _volumeImageView = imageView;
    
    //------- 右边的关闭按钮 -------//
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 33, 3, 30, 30)];
    closeButton.centerY = self.height/2;
    [self addSubview:closeButton];
    
    [closeButton setImage:[UIImage imageNamed:@"new_notice_close"] forState:UIControlStateNormal];
    [closeButton setImageEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn = closeButton;
    
    //------- marquee View -------//
    // 背景
    UIView *marqueeBgView = [[UIView alloc] initWithFrame:CGRectMake(41, 0, self.width - 41 - 38, self.height)];
    [self addSubview:marqueeBgView];
    marqueeBgView.clipsToBounds = YES;
    
    // marquee label
    _marqueeLabel = [[UILabel alloc] initWithFrame:marqueeBgView.bounds];
    [marqueeBgView addSubview:_marqueeLabel];
    _marqueeLabel.userInteractionEnabled = YES;
    _marqueeLabel.textColor = [UIColor colorWithHexString:@"ff6666"];
    _marqueeLabel.font = [UIFont systemFontOfSize:13];
    
    [_marqueeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
}

#pragma mark - 关闭按钮点击
- (void)tapClick:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(marqueeView:marqueeLabelDidClick:isMarqueeArray:)]) {
        [self.delegate marqueeView:self marqueeLabelDidClick:_marqueeLabel isMarqueeArray:isMarqueeArray];
    }
}


#pragma mark - 关闭按钮点击
/** 关闭按钮点击 */
- (void)closeButtonClicked:(UIButton *)sender {
    [self invalidateTimer];
    
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(marqueeView:closeButtonDidClick:)]) {
        [self.delegate marqueeView:self closeButtonDidClick:sender];
    }
}

#pragma mark - 赋值跑马灯文字
/** 赋值跑马灯文字 */
- (void)setMarqueeText:(NSString *)marqueeText {
    _marqueeText = marqueeText;
    isMarqueeArray = NO;
    
    _marqueeLabel.text = _marqueeText;
    [_marqueeLabel sizeToFit];
    _marqueeLabel.centerY = self.height / 2;
    
    [self invalidateTimer];
    
    // 从最右边开始跑
    _marqueeLabel.x = self.width - 41 - 38;
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshMarqueeLabelFrame)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    // [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshMarqueeLabelFrame) userInfo:nil repeats:YES];
    // [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


/** 刷新跑马灯label的位置 */
- (void)refreshMarqueeLabelFrame {
    _marqueeLabel.x -= _speed;
    if (_marqueeLabel.maxX <= 0) {
        _marqueeLabel.x = self.width - 41 - 38;
    }
}


#pragma mark - 赋值数组 跑马灯文字
- (void)setMarqueeTextArray:(NSArray *)marqueeTextArray {
    _marqueeTextArray = marqueeTextArray;
    isMarqueeArray = YES;
    
    // 默认展示第一条
    [self setMarqueeText:_marqueeTextArray.firstObject];
    // 从最右边开始移动
    _marqueeLabel.x = _marqueeLabel.superview.width;
    
    [self invalidateTimer];
    
    count = 0;
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshMarqueeLabelArrarFrame)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshMarqueeLabelArrarFrame) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


/** 改变label位置 */
- (void)refreshMarqueeLabelArrarFrame {
    _marqueeLabel.maxX -= _speed;
    if (_marqueeLabel.maxX <= 0) { // 当前信息跑完
        count ++;
        _marqueeLabel.x = self.width - 41 - 38; // 回到最右边
        // 取模是关键
        _marqueeLabel.text = _marqueeTextArray[count % self.marqueeTextArray.count];
        _marqueeLabel.tag = count % self.marqueeTextArray.count;
        [_marqueeLabel sizeToFit];
        if (count == 10000*self.marqueeTextArray.count) {
            count = 0;
        }
    }
}


#pragma mark - 其他设置
// 暂停
- (void)setPause:(BOOL)pause {
    _pause = pause;
    if (pause) {
        [self invalidateTimer];
    }else {
        if (self.marqueeTextArray && isMarqueeArray) {
            _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshMarqueeLabelArrarFrame)];
            [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        }else {
            _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(refreshMarqueeLabelFrame)];
            [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        }
    }
}

// 滚动速度 最好是0.0~2.0之间
- (void)setSpeed:(double)speed {
    _speed = speed;
}

- (void)setFont:(UIFont *)font {
    _marqueeLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _marqueeLabel.textColor = textColor;
}

- (void)setCloseImage:(UIImage *)closeImage {
    [_closeBtn setImage:closeImage forState:UIControlStateNormal];
}
- (void)setVoiceImage:(UIImage *)voiceImage {
    _volumeImageView.image = voiceImage;
}

- (void)dealloc {
    NSLog(@"ssssss");
}

- (void)invalidateTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
