//
//  UINavigationBar+Extension.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "UINavigationBar+Extension.h"

@implementation UINavigationBar (Extension)

//添加关联对象
-(void)setMg_hideStatusBarBackgroungView:(BOOL)yesOrNo{
    objc_setAssociatedObject(self, @selector(mg_hideStatusBarBackgroungView), @(yesOrNo), OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsLayout];
}

//获取关联对象
-(BOOL)mg_hideStatusBarBackgroungView{
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)load {
    [self mg_SwitchMethod:self originalSelector:@selector(layoutSubviews) swizzledSelector:@selector(mg_layoutSubviews)];
}

- (void)mg_layoutSubviews{
    //这不是递归，其实调用了[self layoutSubviews];
    [self mg_layoutSubviews];
    UIView *statusBarView = nil;
    if (self.mg_hideStatusBarBackgroungView){
        Class backgroundClass = NSClassFromString(@"_UINavigationBarBackground");
        Class statusBarBackgroundClass = NSClassFromString(@"_UIBarBackgroundTopCurtainView");
        for (UIView * aSubview in self.subviews){
            if ([aSubview isKindOfClass:backgroundClass]) {
                aSubview.backgroundColor = [UIColor clearColor];
                for (UIView * aaSubview in aSubview.subviews){
                    if ([aaSubview isKindOfClass:statusBarBackgroundClass]) {
                        aaSubview.hidden = YES;
                        aaSubview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.01];
                    }
                }
            }
        }
    }
    statusBarView.hidden = self.mg_hideStatusBarBackgroungView;
}

@end
