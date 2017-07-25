//
//  UIButton+XXExtension.h
//  
//
//  Created by 花菜ChrisCai on 2016/9/20.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
+ (UIButton *)BuuttonWithTitle:(NSString *)title backgroundColor: (UIColor *)color target:(id)target selector:(SEL)selector;

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImagePressed:(NSString *)imagePressed;

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImageSelected:(NSString *)imageSelected;
+ (UIButton *)cf_buttonWithImage:(NSString*)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)selector;
@end
