//
//  UIButton+EnlargeTouchArea.m
//  SwiftLive
//
//  Created by Victor on 16/4/25.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import "UIButton+EnlargeTouchArea.h"
#import <objc/runtime.h>

@implementation UIButton (EnlargeTouchArea)

static char TopNameKey;
static char BottomNameKey;
static char LeftNameKey;
static char RightNameKey;

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &TopNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &RightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &BottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &LeftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber *topEdge = objc_getAssociatedObject(self, &TopNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &RightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &BottomNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &LeftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
