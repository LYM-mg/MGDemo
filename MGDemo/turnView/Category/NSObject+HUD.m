//
//  NSObject+HUD.m
//  MGMiaoBo
//
//  Created by ming on 16/9/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "NSObject+HUD.h"

@implementation NSObject (HUD)
/**
 *  弹框提示
 *
 *  @param info 要提醒的内容
 */
- (void)showInfo:(NSString *)info{
    // 只有是控制器的话才会弹框
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:info message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:cancelAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
    }
}

#pragma mark - 打印系统所有已注册的字体名称
void enumerateFonts() {
    for(NSString *familyName in [UIFont familyNames])
    {
        NSLog(@"%@",familyName);
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for(NSString *fontName in fontNames)
        {
            NSLog(@"\t|- %@",fontName);
        }
    }
}

#pragma mark - 手动更改iOS状态栏的颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - iOS在当前屏幕获取第一响应
- (id)getFirstResponder {
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow.subviews[0] performSelector:@selector(firstResponder)];
    return firstResponder;
}

@end
