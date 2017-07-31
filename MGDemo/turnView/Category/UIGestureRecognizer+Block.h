//
//  UIGestureRecognizer+Block.h
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MGGestureBlock)(id);

@interface UIGestureRecognizer (Block)
/// Creates and returns a new NSTimer object initialized with the specified block object.
/// - parameter:  block  The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
+(instancetype)mg_gestureRecognizerWithActionBlock:(MGGestureBlock)block;
- (instancetype)initWithActionBlock:(MGGestureBlock)block;


@end
