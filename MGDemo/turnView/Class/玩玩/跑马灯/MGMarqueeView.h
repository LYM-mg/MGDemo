//
//  MGMarqueeView.h
//  ScrollDemo
//
//  Created by newunion on 2018/4/11.
//  Copyright © 2018年 newunion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGMarqueeView;

@protocol MGMarqueeViewDelegate <NSObject>

/** 跑马灯view上的关闭按钮点击时回调 */
- (void)marqueeView:(MGMarqueeView *)marqueeView closeButtonDidClick:(UIButton *)sender;
/** 跑马灯view上的关闭按钮点击时回调 */
- (void)marqueeView:(MGMarqueeView *)marqueeView marqueeLabelDidClick:(UILabel *)sender isMarqueeArray:(BOOL)isMarqueeArray;

@end

@interface MGMarqueeView : UIView

/** 跑马灯展示的文本数组 */
@property (nonatomic, strong) NSArray *marqueeTextArray;
/** 跑马灯展示的文本 */
@property (copy,nonatomic) NSString *marqueeText;

/** 跑马灯关闭图片 */
@property (nonatomic, strong) UIImage *closeImage;
/** 跑马灯关闭左边声音图片 */
@property (copy,nonatomic) UIImage *voiceImage;
/** 跑马灯的文本颜色 */
@property (copy,nonatomic) UIColor *textColor;
/** 跑马灯的文本大小 */
@property (copy,nonatomic) UIFont *font;

@property (assign,nonatomic) double speed;  // defaults to 0.3 不宜过大
@property (assign,nonatomic) BOOL pause; // defaults to NO

@property (nonatomic, weak) id <MGMarqueeViewDelegate> delegate;

/** 释放定时器 */
- (void)invalidateTimer;
@end
