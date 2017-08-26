//
//  MGScrollLabelView.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/8/26.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGScrollLabelView.h"

@interface MGScrollLabelView ()
/**
 正在显示的label
 */
@property (nonatomic, strong) UILabel *currentLabel;
/**
 下一个要显示的label
 */
@property (nonatomic, strong) UILabel *willShowLabel;
/**
 计时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 当前显示的title下标
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MGScrollLabelView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
        _stayInterval = 2;
        _animationDuration = 0.5;
        self.clipsToBounds = YES;
        [self setSubviews];
        [self setTapGesture];
    }
    return self;
}
- (void)setSubviews
{
    _currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _willShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self addSubview:_currentLabel];
    [self addSubview:_willShowLabel];
}
- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    if (titleArray&&titleArray.count) {
        _currentLabel.text = [titleArray firstObject];
        if (titleArray.count>1) {
            _willShowLabel.text = titleArray[1];
        }
    }
}
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.currentLabel.font = titleFont;
    self.willShowLabel.font = titleFont;
}
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.currentLabel.textColor = titleColor;
    self.willShowLabel.textColor = titleColor;
}
- (void)beginScrolling{
    if (self.titleArray.count<2)
        return;

    [self creatTimer];
}
- (void)creatTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.stayInterval target:self selector:@selector(startTimer) userInfo:nil repeats:YES];
}
- (void)startTimer {
    [UIView animateWithDuration:0.5 animations:^{
        _currentLabel.frame = CGRectMake(0, -self.frame.size.height, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _willShowLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } completion:^(BOOL finished) {
        _currentLabel.frame = CGRectMake(0, self.frame.size.height, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        UILabel *label = _willShowLabel;
        _willShowLabel = _currentLabel;
        _currentLabel = label;
        _currentIndex++;
        if (_currentIndex == (self.titleArray.count-1)) {
            _currentLabel.text = self.titleArray[_currentIndex];
            _willShowLabel.text = self.titleArray[0];
        }else{
            if (_currentIndex == self.titleArray.count) {
                _currentIndex = 0;
            }
            _currentLabel.text = self.titleArray[_currentIndex];
            _willShowLabel.text = self.titleArray[_currentIndex+1];
        }
    }];
}
- (void)setTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:tap];
}
- (void)didTap {
    if (_delegate && [_delegate respondsToSelector:@selector(scrollLabelView:didClickAtIndex:)]) {
        [self.delegate scrollLabelView:self didClickAtIndex:_currentIndex];
    }
}

- (void)pauseScrolling {
    [self stopScrolling];
}

- (void)stopScrolling {
    [_timer invalidate];
    _timer = nil;
}

@end
