//
//  UIButton+Extension.m

//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.

#import "UIButton+Extension.h"

// 动态绑定，参照NSTimer
static NSString *const target_key = @"mg_btnTarget_key";

@implementation UIButton (Extension)

#pragma mark - SEL回调
+ (UIButton *)ButtonWithTitle:(NSString *)title backgroundColor: (UIColor *)color target:(id)target selector:(SEL)selector; {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString *)image ImagePressed:(NSString *)imagePressed {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imagePressed] forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)cf_buttonWithFrame:(CGRect)frame Target:(id)target Selector:(SEL)selector Image:(NSString*)image ImageSelected:(NSString *)imageSelected {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)cf_buttonWithImage:(NSString*)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)selector {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - 自定义Block作为回调
- (void)addBtnClickActionBlock:(MGBtnBlock)block {
    [self addActionBlock:block];
    [self addTarget:self action:@selector(invoke:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addActionBlock:(MGBtnBlock)block {
    if (block) {
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)invoke:(id)sender {
    MGBtnBlock block = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}

- (instancetype)initWithWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString*)imageName actionBlock:(MGBtnBlock)block {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (title == nil || [title  isEqual: @""] || title.length == 0 || [title isKindOfClass:[NSNull class]]) {
       [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }else {
       [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    [button addBtnClickActionBlock:block];
    return button;
}

+ (instancetype)ButtonWithFrame:(CGRect)frame title:(NSString *)title backgroundColor: (UIColor *)color actionBlock:(MGBtnBlock)block {
    UIButton *button = [[self alloc] initWithWithFrame:frame title:title imageName:nil actionBlock:block];
    [button setBackgroundColor:color];
    return button;
}

+ (UIButton *)ButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName imagePressed:(NSString *)imagePressed  actionBlock:(MGBtnBlock)block{
    UIButton *button = [[self alloc] initWithWithFrame:frame title:nil imageName:imageName actionBlock:block];
    [button setBackgroundImage:[UIImage imageNamed:imagePressed] forState:UIControlStateHighlighted];
    return button;
}

+ (UIButton *)ButtonWithFrame:(CGRect)frame imageName:(NSString*)imageName imageSelected:(NSString *)imageSelected actionBlock:(MGBtnBlock)block{
    UIButton * button = [[self alloc] initWithWithFrame:frame title:nil imageName:imageName actionBlock:block];
    [button setBackgroundImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    return button;
}

+ (UIButton *)ButtonWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(MGBtnBlock)block{
    UIButton * button = [[self alloc] initWithWithFrame:frame title:title imageName:nil actionBlock:block];
    return button;
}

// SizeToFit
+ (instancetype)ButtonWithTitle:(NSString *)title backgroundColor: (UIColor *)color actionBlock:(MGBtnBlock)block {
    UIButton *button = [[self alloc] initWithWithFrame:CGRectZero title:title imageName:nil actionBlock:block];
    [button setBackgroundColor:color];
    [button sizeToFit];
    return button;
}

+ (instancetype)ButtonWithImageName:(NSString *)imageName imagePressed:(NSString *)imagePressed  actionBlock:(MGBtnBlock)block{
    UIButton *button = [[self alloc] initWithWithFrame:CGRectZero title:nil imageName:imageName actionBlock:block];
    [button setBackgroundImage:[UIImage imageNamed:imagePressed] forState:UIControlStateHighlighted];
    [button sizeToFit];
    return button;
}

+ (instancetype)ButtonWithImageName:(NSString*)imageName imageSelected:(NSString *)imageSelected actionBlock:(MGBtnBlock)block{
    UIButton * button = [[self alloc] initWithWithFrame:CGRectZero title:nil imageName:imageName actionBlock:block];
    [button setBackgroundImage:[UIImage imageNamed:imageSelected] forState:UIControlStateSelected];
    [button sizeToFit];
    return button;
}

+ (instancetype)ButtonWithTitle:(NSString *)title actionBlock:(MGBtnBlock)block{
    UIButton * button = [[self alloc] initWithWithFrame:CGRectZero title:title imageName:nil actionBlock:block];
    [button sizeToFit];
    return button;
}

@end
