//
//  UIBarButtonItem+Extension.m
//  03-百思不得姐-我的
//
//  Created by ming on 13/12/5.
//  Copyright © 2013年 ming. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/** 设置图片和文字 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)image  highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action {
    return [UIBarButtonItem itemWithBackgroundImage:nil BackgroundhighImage:nil image:image highImage:highImage norColor:nil selColor:nil title:title target:target action:action];
}

+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage  target:(id)target action:(SEL)action{
    return [self itemWithBackgroundImage:image BackgroundhighImage:highImage image:nil highImage:nil norColor:nil selColor:nil title:nil target:target action:action];
}

// UIBarButtonItem的封装
+ (UIBarButtonItem *)itemWithBackgroundImage:(NSString *)backgroundImage BackgroundhighImage:(NSString *)backgroundhighImage image:(NSString *)image highImage:(NSString *)highImage norColor:(UIColor *)norColor selColor:(UIColor *)selColor title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    /// 1.设置照片
    [backBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [backBtn setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:backgroundhighImage] forState:UIControlStateHighlighted];
    /// 2.设置文字以及颜色
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setTitleColor:norColor forState:UIControlStateNormal];
    [backBtn setTitleColor:selColor forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:backBtn];
}


+ (UIButton *)itemWithBackgroundImage:(NSString *)image highImage:(NSString *)highImage image:(NSString *)norImage
    selHighImage:(NSString *)selHighImage target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selHighImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    return btn;
}



@end
