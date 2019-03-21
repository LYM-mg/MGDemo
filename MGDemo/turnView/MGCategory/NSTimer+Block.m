//
//  NSTimer+Block.m
//  drawDemo
//
//  Created by newunion on 2018/12/10.
//  Copyright © 2018年 firestonetmt. All rights reserved.
//

#import "NSTimer+Block.h"
#import <objc/runtime.h>

static const NSString *BlockActionTag = @"BlockActionTag";
@implementation NSTimer (Block)
+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)(void))block repeats:(BOOL)repeats{
    
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)blockInvoke:(NSTimer*)timer {
    void (^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}

+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withAction:(void(^)(void))block {
    objc_setAssociatedObject(self, &BlockActionTag, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self scheduledTimerWithTimeInterval:interval
                                  target:self
                                selector:@selector(blockAction:)
                                userInfo:[block copy]
                                 repeats:repeats];
}

- (void)blockAction:(NSTimer*)timer {
   void(^block)(void) = objc_getAssociatedObject(self, &BlockActionTag);
    if (block) {
        block();
    }
}

@end
