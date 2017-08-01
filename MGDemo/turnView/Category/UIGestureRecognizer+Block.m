//
//  UIGestureRecognizer+Block.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
// 原理就是把 block 动态地绑成 UIGestureRecognizer 的一个变量，invoke 的时候再调用这个 block。

#import "UIGestureRecognizer+Block.h"

// 动态绑定，参照NSTimer
static NSString *const target_key = @"mg_gesTarget_key";

@implementation UIGestureRecognizer (Block)

/// Creates and returns a new UIGestureRecognizer object initialized with the specified block object.
/// - parameter:  block  The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
+(instancetype)mg_gestureRecognizerWithActionBlock:(MGGestureBlock)block {
    return [[self alloc] initWithActionBlock:block];
}

- (instancetype)initWithActionBlock:(MGGestureBlock)block {
    self = [self init];
    [self addActionBlock:block];
    [self addTarget:self action:@selector(invoke:)];
    return self;
}


- (void)addActionBlock:(MGGestureBlock)block {
    if (block) {
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)invoke:(id)sender {
    MGGestureBlock block = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}
@end
