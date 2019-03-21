//
//  MGButton+Delay.h
//  MGDemo
//
//  Created by newunion on 2018/1/22.
//  Copyright © 2018年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval 1.0//默认时间间隔
@interface MGButton_Delay: UIButton
@property(nonatomic,assign) IBInspectable CGFloat timeInterval;//用这个给重复点击加间隔
@property(nonatomic,assign) IBInspectable BOOL isIgnoreEvent;//YES不允许点击NO允许点击
@end
