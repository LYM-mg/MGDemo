//
//  NSTimer+Block.h
//  drawDemo
//
//  Created by newunion on 2018/12/10.
//  Copyright © 2018年 firestonetmt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Block)
+ (NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)(void))block repeats:(BOOL)repeats;

+ (void)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats withAction:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
