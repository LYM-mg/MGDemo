//
//  MGScrollViewLabel.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/8/24.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGScrollViewLabel.h"

@interface MGScrollViewLabel ()
@property (nonatomic,strong) UIScrollView *showView;
@property (nonatomic,strong) UILabel *textLabel;
@end

@implementation MGScrollViewLabel

- (UIScrollView *)showView {
    if (!_showView) {
        UIScrollView *showView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:showView];
        [showView addSubview:self.textLabel];
        _showView = showView;
    }
    return _showView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.numberOfLines = 0;
        textLabel.textColor     = [UIColor cyanColor];
        _textLabel = textLabel;
    }
    return _textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        self.direction = Horizontal;
        [self addSubview:self.showView];
    }
    
    return self;
}

//- (void)setDirection:(MGDirection)direction {
//    _direction = direction;
//    if (_scrollStr != nil || ![_scrollStr  isEqual: @""] || _scrollStr != NULL) {
//        [self addScrollViewLabel];
//    }
//}

- (void)setScrollStr:(NSString *)scrollStr {
    _scrollStr = scrollStr;
    if (_scrollStr != nil || ![_scrollStr  isEqual: @""] || _scrollStr != NULL) {
        [self addScrollViewLabel];
    }
}


- (void)addScrollViewLabel {
     self.textLabel.text = @"";
    // 获取文本
//    NSString *string = @"  喜欢这首情思幽幽的曲子，仿佛多么遥远，在感叹着前世的情缘，又是那么柔软，在祈愿着来世的缠绵。《莲的心事》，你似琉璃一样的晶莹，柔柔地拨动我多情的心弦。我，莲的心事，有谁知？我，莲的矜持，又有谁懂？  ";
    self.textLabel.text = _scrollStr;
    // 计算尺寸
    self.textLabel.origin = CGPointZero;
    CGRect rect = CGRectZero;
    
    // 初始化ScrollView
    if (self.direction == Horizontal) { // 水平
        rect = [self.textLabel textRectForBounds:CGRectMake(0, 0, MAXFLOAT, 22) limitedToNumberOfLines:0];
        self.showView.frame = CGRectMake(0, 0, MGSCREEN_WIDTH-40, rect.size.height);
        self.showView.contentSize   = CGSizeMake(rect.size.width+self.showView.frame.size.width/2, rect.size.height);
        self.showView.contentOffset = CGPointMake(-self.showView.frame.size.width/2, 0);
    }else { // 垂直
        rect = [self.textLabel textRectForBounds:CGRectMake(0, 0, MGSCREEN_WIDTH-40, MAXFLOAT) limitedToNumberOfLines:0];
        self.showView.frame = CGRectMake(0, 0, MGSCREEN_WIDTH-40, 22);
        self.showView.clipsToBounds = true;
        self.showView.contentSize   = CGSizeMake(rect.size.width, rect.size.height+self.showView.frame.size.height/2);
        self.showView.contentOffset = CGPointMake(0, -self.showView.frame.size.height/2);
    }
    self.textLabel.frame = rect;
    self.showView.showsHorizontalScrollIndicator = NO;
   
    
    [UIView beginAnimations:@"parent" context:nil];
//    [UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:20.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    // 计算移动的距离
    CGPoint point = self.showView.contentOffset;
    if (self.direction == Horizontal) {
        point.x = rect.size.width + self.showView.frame.size.width/2;
    }else {
        point.y = rect.size.height + self.showView.frame.size.height/2;
    }
    self.showView.contentOffset = point;
    [UIView commitAnimations];
}

- (void)startAni:(NSString *)aniID{
    
}

- (void)stopAni:(NSString *)aniID{
    [UIView animateWithDuration:0.1 animations:^{
        if (self.direction == Horizontal)  {
            self.showView.contentOffset = CGPointMake(-self.showView.frame.size.width/2, 0);
        }else {
            self.showView.contentOffset = CGPointMake(0, -self.showView.frame.size.height/2);
        }
    }];
}

@end
