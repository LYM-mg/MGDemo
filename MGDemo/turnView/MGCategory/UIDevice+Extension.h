//
//  UIDevice+Extension.h
//  MGMiaoBo
//
//  Created by ming on 16/9/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extension)
/** 当前试试设备 */
+ (NSString*)deviceVersion;

/** 是否横屏 */
- (BOOL)isLandscape;

/**
 *  强制屏幕转屏
 *
 *  @param orientation 屏幕方向
 */
+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation;
+ (void)setOrientationLandscapeRight;
+ (void)setOrientationPortrait;

/** 监听屏幕发生旋转 */
void addObserverDeviceOrientationDidChange(id target, SEL method);

/**
 开启一个定时器
 
 @param target 定时器持有者
 @param timeInterval 执行间隔时间
 @param handler 重复执行事件
 */
void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer));
@end
