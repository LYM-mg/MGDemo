//
//  UITextField+Shake.m
//  VideoShare
//
//  Created by i-Techsys.com on 2017/6/21.
//  Copyright © 2017年 i-Techsys. All rights reserved.
//

#import "UITextField+Shake.h"

@implementation UITextField (Shake)

/**
 * 为textField扩展一个左右晃动的动画
 */
- (void)shakeWithDuration:(CFTimeInterval)duration {
    CAKeyframeAnimation*keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    keyFrame.duration = duration;
    CGFloat x = self.layer.position.x;
    keyFrame.values=@[@(x -20),@(x -15),@(x +20),@(x -20),@(x +10),@(x -10),@(x +5),@(x -5)];
    [self.layer addAnimation:keyFrame forKey:@"shake"];
}

@end
