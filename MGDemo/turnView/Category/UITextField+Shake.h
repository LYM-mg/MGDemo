//
//  UITextField+Shake.h
//  VideoShare
//
//  Created by i-Techsys.com on 2017/6/21.
//  Copyright © 2017年 i-Techsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Shake)

/**
 * 为textField扩展一个左右晃动的动画
 */
- (void)shakeWithDuration:(CFTimeInterval)duration;

@end
