//
//  CALayer+PauseAimate.h
//  MGDemo
//
//  Created by ming on 15/8/14.
//  Copyright (c) 2015年 xiaoming. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (PauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end
