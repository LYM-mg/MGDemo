//
//  UIViewController+HUD.h
//  MGMiaoBo
//
//  Created by ming on 16/9/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (HUD)
/** HUD */
@property (nonatomic, weak, readonly) MBProgressHUD *HUD;

/**
 *  提示信息
 *
 *  @param view 显示在哪个view
 *  @param hint 提示
 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;
- (void)showHudInView:(UIView *)view hint:(NSString *)hint yOffset:(float)yOffset;

/// 如果设置了图片名，mode的其他其他设置将失效
- (void)showHudInView:(UIView *)view hint:(NSString *)hint mode: (MBProgressHUDMode)mode imageName:(NSString *)imageName;

/**
 *  隐藏
 */
- (void)hideHud;

/**
 *  提示信息 mode:MBProgressHUDModeText
 *
 *  @param hint 提示
 */
- (void)showHint:(NSString *)hint;
- (void)showHint:(NSString *)hint inView:(UIView *)view;
- (void)showHint:(NSString *)hint inView:(UIView *)view imageName:(NSString *)imageName;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
@end
