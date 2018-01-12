//
//  UINavigationBar+ChangeColor.h
//  ProductionReport
//
//  Created by i-Techsys.com on 17/1/17.
//  Copyright © 2017年 i-Techsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ChangeColor)

/**
 *  隐藏导航栏下的横线，背景色置空
 */
- (void)star;

/**
 *  @param color 最终显示颜色
 *  @param scrollView 当前滑动视图
 *  @param value 滑动临界值，依据需求设置
 */
- (void)changeColor:(UIColor *)color WithScrollView:(UIScrollView *)scrollView AndValue:(CGFloat)value;

/**
 *  还原导航栏
 */
- (void)reset;

@end
