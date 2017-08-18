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
//    if ([[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"statusBar")]) {
//        statusBar = [app valueForKey:@"statusBar"];
//    }
    
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


#pragma mark - RunTime
+ (void)mg_SwitchMethod:(Class)cls originalSelector: (SEL)originalSel swizzledSelector:(SEL)swizzledSel {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSel);
    
    // 首先动态添加方法。如果类中不存在这个方法的实现，添加成功
    BOOL isAdded = class_addMethod(cls, originalSel, method_getImplementation(originalMethod), method_getTypeEncoding(swizzledMethod));
    // 因为控制器已经包含了originalSel的实现，所以不会被添加成功
    if (isAdded) {
        //如果类没有originalSel这个方法的实现，那么添加成功，将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(cls, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{ //否则交换两个方法的实现
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void Swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}
@end
