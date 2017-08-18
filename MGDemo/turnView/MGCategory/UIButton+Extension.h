//
//  UIButton+Extension.m

//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.

#import <UIKit/UIKit.h>

typedef void(^MGBtnBlock)(id btn);

@interface UIButton (Extension)
#pragma mark - SEL回调
+ (UIButton *)ButtonWithTitle:(NSString *)title backgroundColor: (UIColor *)color target:(id)target selector:(SEL)selector;

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImagePressed:(NSString *)imagePressed;

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImageSelected:(NSString *)imageSelected;
+ (UIButton *)cf_buttonWithImage:(NSString*)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)selector;

#pragma mark - 闭包回调
- (void)addBtnClickActionBlock:(MGBtnBlock)block;
- (instancetype)initWithWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString*)imageName actionBlock:(MGBtnBlock)block;

+ (instancetype)ButtonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor: (UIColor *)color actionBlock:(MGBtnBlock)block;
+ (UIButton *)ButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName imagePressed:(NSString *)imagePressed  actionBlock:(MGBtnBlock)block;
+ (UIButton *)ButtonWithFrame:(CGRect)frame imageName:(NSString*)imageName imageSelected:(NSString *)imageSelected actionBlock:(MGBtnBlock)block;
+ (UIButton *)ButtonWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(MGBtnBlock)block;


+ (instancetype)ButtonWithTitle:(NSString *)title backgroundColor: (UIColor *)color actionBlock:(MGBtnBlock)block;
+ (instancetype)ButtonWithImageName:(NSString *)imageName imagePressed:(NSString *)imagePressed  actionBlock:(MGBtnBlock)block;
+ (instancetype)ButtonWithImageName:(NSString*)imageName imageSelected:(NSString *)imageSelected actionBlock:(MGBtnBlock)block;
+ (instancetype)ButtonWithTitle:(NSString *)title actionBlock:(MGBtnBlock)block;
@end
