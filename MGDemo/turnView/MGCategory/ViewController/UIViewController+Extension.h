//
//  UIViewController+Extension.h
//  NewUnion
//
//  Created by Ming on 16/12/18.
//  Copyright © 2016年 NewUnion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
/**
 *  导航栏当前控制器
 */
+ (UIViewController*) currentViewController;
/**
 *  导航栏当前控制器
 */
+ (UIViewController *)mg_currentViewController;

/**
 *  导航栏回到指定控制器
 *  controllerName：控制器名字（字符串）
 */
- (void)backToController:(NSString *)controllerName animated:(BOOL)animated;
/**
 *  导航栏回到指定控制器
 *  controllerName：控制器名字（class）
 */
- (void)backToControllerClass:(Class)class animated:(BOOL)animated;
@end
