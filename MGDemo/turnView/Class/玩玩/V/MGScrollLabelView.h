//
//  MGScrollLabelView.h
//  MGDemo
//
//  Created by i-Techsys.com on 2017/8/26.
//  Copyright © 2017年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGScrollLabelView;
@protocol MGScrollLabelViewDelegate <NSObject>

- (void)scrollLabelView:(MGScrollLabelView *)scrollLabelView didClickAtIndex:(NSInteger)index;

@end

@interface MGScrollLabelView : UIView
/**
 代理
 */
@property (nonatomic, weak) id<MGScrollLabelViewDelegate> delegate;
/**
 标题数组
 */
@property (nonatomic, strong) NSArray *titleArray;
/**
 标题字体大小
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 停留时间 默认2s
 */
@property (nonatomic, assign) CGFloat stayInterval;
/**
 滚动动画持续时间 默认0.5s
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;


/// 开始滚动
- (void)beginScrolling;
/// 暂停滚动
- (void)pauseScrolling;
/** 停止滚动释放定时器 */
- (void)stopScrolling;

@end
