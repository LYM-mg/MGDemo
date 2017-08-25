//
//  UIView+Drag.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/8/18.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "UIView+Drag.h"
#import <objc/runtime.h>

@interface UIView ()
@property (nonatomic,weak) UIPanGestureRecognizer *panG;

@property (nonatomic,assign)CGFloat mg_x;

@property (nonatomic,assign)CGFloat mg_y;

@property (nonatomic,assign)CGFloat mg_centerX;

@property (nonatomic,assign)CGFloat mg_centerY;

@property (nonatomic,assign)CGFloat mg_width;

@property (nonatomic,assign)CGFloat mg_height;

@end

@implementation UIView (Drag)

static char *static_mg_canDrag = "static_mg_canDrag";
static char *static_mg_bounces = "static_mg_bounces";
static char *static_mg_adsorb = "static_mg_adsorb";
static char *static_mg_panG = "static_mg_panG";
/**
 *  @author ming
 *
 *  控件当前的下标
 */
static NSUInteger _currentIndex;
/**
 *  @author ming
 *
 *  防止先设置bounces 再设置 mg_canDrag 而重置mg_bounces的值
 */
BOOL _bounces = YES;
BOOL _absorb = YES;

- (void)setMg_canDrag:(BOOL)mg_canDrag{
    objc_setAssociatedObject(self, &static_mg_canDrag, @(mg_canDrag), OBJC_ASSOCIATION_ASSIGN);
    if (mg_canDrag) {
        [self mg_addPanGesture];
        self.mg_bounces = _bounces;
        self.mg_isAdsorb = _absorb;
        _currentIndex = [self.superview.subviews indexOfObject:self];
    }else{
        [self mg_removePanGesture];
    }
}

- (BOOL)mg_canDrag{
    NSNumber *flagNum = objc_getAssociatedObject(self, &static_mg_canDrag);
    return flagNum.boolValue;
}

- (void)setPanG:(UIPanGestureRecognizer *)panG{
    objc_setAssociatedObject(self, &static_mg_panG, panG, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer *)panG{
    return objc_getAssociatedObject(self, &static_mg_panG);
}

- (void)setMg_bounces:(BOOL)mg_bounces{
    objc_setAssociatedObject(self, &static_mg_bounces, @(mg_bounces), OBJC_ASSOCIATION_ASSIGN);
    _bounces = mg_bounces;
}

- (BOOL)mg_bounces{
    NSNumber *flagNum = objc_getAssociatedObject(self, &static_mg_bounces);
    return flagNum.boolValue;
}

- (void)setMg_isAdsorb:(BOOL)mg_isAdsorb{
    objc_setAssociatedObject(self, &static_mg_adsorb, @(mg_isAdsorb), OBJC_ASSOCIATION_ASSIGN);
    _absorb = mg_isAdsorb;
}

- (BOOL)mg_isAdsorb{
    NSNumber *flagNum = objc_getAssociatedObject(self, &static_mg_adsorb);
    return flagNum.boolValue;
}


#pragma mark -- private method

- (void)mg_addPanGesture{
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOperation:)];
    self.panG = panG;
    [self addGestureRecognizer:panG];
}

- (void)mg_removePanGesture{
    [self removeGestureRecognizer:self.panG];
    self.panG = nil;
}

- (void)panOperation:(UIPanGestureRecognizer *)gesR{
    
    CGPoint translatedPoint = [gesR translationInView:self];
    CGFloat x = gesR.view.mg_centerX + translatedPoint.x;
    CGFloat y = gesR.view.mg_centerY + translatedPoint.y;
    
    switch (gesR.state) {
        case UIGestureRecognizerStateBegan:{
            // 遮盖处理
            [[self superview] bringSubviewToFront:self];
            break;
        }
        case UIGestureRecognizerStateChanged:{
            if (!self.mg_bounces) {
                if (x < self.mg_width / 2) {
                    x = self.mg_width / 2;
                }
                else if (x > self.superview.mg_width - self.mg_width / 2) {
                    x = self.superview.mg_width - self.mg_width / 2;
                }
                if (y < self.mg_height / 2) {
                    y = self.mg_width / 2;
                }
                else if(y > self.superview.mg_height - self.mg_height / 2){
                    y = self.superview.mg_height - self.mg_height / 2;
                }
            }
            gesR.view.center = CGPointMake(x, y);
            break;
        }
        case UIGestureRecognizerStateEnded:{
            [self layoutIfNeeded];
            if (y < self.mg_height / 2) {
                y = self.mg_height / 2;
            }
            else if(y > self.superview.mg_height - self.mg_height / 2){
                y = self.superview.mg_height - self.mg_height / 2;
            }
            
            if (!self.mg_isAdsorb) {
                if (gesR.view.mg_x < self.superview.mg_x) {
                    x = self.superview.mg_x + gesR.view.mg_width / 2;
                }
                else if (gesR.view.mg_x + gesR.view.mg_width > self.superview.mg_width){
                    x = self.superview.mg_width - gesR.view.mg_width / 2;
                }
                [UIView animateWithDuration:0.25 animations:^{
                    gesR.view.center = CGPointMake(x, y);
                }];
            }
            else{
                // 此时需要加上父类的x值，比较的应该是绝对位置，而不是相对位置
                if (gesR.view.mg_centerX + self.superview.mg_x > self.superview.mg_centerX) { // 右边 居右
                    [UIView animateWithDuration:0.25 animations:^{
                        gesR.view.center = CGPointMake(self.superview.mg_width - self.mg_width / 2, y);
                    }];
                }else{ // 左边 居左
                    [UIView animateWithDuration:0.25 animations:^{
                        gesR.view.center = CGPointMake(self.mg_width / 2, y);
                    }];
                    
                }
            }
            // 遮盖处理，如果不遮盖，重置原来位置
            if (![self mg_isCover]) {
                [self.superview insertSubview:self atIndex:_currentIndex];
            }
            else{
                [self.superview bringSubviewToFront:self];
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:{
            break;
        }
        case UIGestureRecognizerStateFailed:{
            NSAssert(YES, @"手势失败");
            break;
        }
        default:
        break;
    }
    // 重置
    [gesR setTranslation:CGPointMake(0, 0) inView:self];
}

- (BOOL)mg_isCover{
    BOOL flag = NO;
    for (UIView *view in self.superview.subviews) {
        if (view == self) continue;
        if ([self mg_intersectsWithView:view]) {
            flag = YES;
        }
    }
    return flag;
}

- (BOOL)mg_intersectsWithView:(UIView *)view{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}


- (CGFloat)mg_x{
    return self.frame.origin.x;
}

- (CGFloat)mg_y{
    return self.frame.origin.y;
}

- (CGFloat)mg_centerX{
    return self.center.x;
}

- (CGFloat)mg_centerY{
    return self.center.y;
}

- (CGFloat)mg_width{
    return self.frame.size.width;
}

- (CGFloat)mg_height{
    return self.frame.size.height;
}

- (void)setMg_x:(CGFloat)mg_x{
    self.frame = (CGRect){
        .origin = {.x = mg_x, .y = self.mg_y},
        .size   = {.width = self.mg_width, .height = self.mg_height}
    };
}

- (void)setMg_y:(CGFloat)mg_y{
    self.frame = (CGRect){
        .origin = {.x = self.mg_x, .y = mg_y},
        .size   = {.width = self.mg_width, .height = self.mg_height}
    };
}

- (void)setMg_centerX:(CGFloat)mg_centerX{
    CGPoint center = self.center;
    center.x = mg_centerX;
    self.center = center;
}

- (void)setMg_centerY:(CGFloat)mg_centerY{
    CGPoint center = self.center;
    center.y = mg_centerY;
    self.center = center;
}


- (void)setMg_width:(CGFloat)mg_width{
    self.frame = (CGRect){
        .origin = {.x = self.mg_x, .y = self.mg_y},
        .size   = {.width = mg_width, .height = self.mg_height}
    };
}

- (void)setMg_height:(CGFloat)mg_height{
    self.frame = (CGRect){
        .origin = {.x = self.mg_x, .y = self.mg_y},
        .size   = {.width = self.mg_width, .height = self.mg_height}
    };
}

@end
