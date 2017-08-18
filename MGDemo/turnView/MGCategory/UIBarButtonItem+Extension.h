//
//  UIBarButtonItem+Extension.h
//  03-百思不得姐-我的
//
//  Created by ming on 13/12/5.
//  Copyright © 2013年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/** 设置背景图片和颜色 */
+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)backgroundImage BackgroundhighImage:(NSString *)backgroundhighImage image:(NSString *)image highImage:(NSString *)highImage norColor:(UIColor *)norColor selColor:(UIColor *)selColor title:(NSString *)title target:(id)target action:(SEL)action;

/** 设置图片和背景 */
+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/** 设置图片和文字 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)image  highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;

/** 设置背景图片和选中图片 */
+ (UIButton *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage image:(NSString *)norImage
                         selHighImage:(NSString *)selHighImage target:(id)target action:(SEL)action;

@end
