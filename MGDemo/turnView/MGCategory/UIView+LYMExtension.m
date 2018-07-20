//
//  UIView+LYMExtension.m
//  UIView+LYMExtension.h
//
//  Created by ming on 13/12/10.
//  Copyright © 2013年 ming. All rights reserved.
/**
    此类不仅封装了控件的Frame，还封装了快速从XIB创建View的方法(仅限于XIB中只有一个View的时候)
    此外，还封装了两个View是否有重叠的方法
 */

#import "UIView+LYMExtension.h"
#import <Foundation/Foundation.h>

@implementation UIView (LYMExtension)

#pragma mark - setter
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setX:(CGFloat)x{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}

- (void)setY:(CGFloat)y{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y  = y;
    self.frame = tempFrame;
}

- (void)setWidth:(CGFloat)width{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}

- (void)setHeight:(CGFloat)height{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - getter
- (CGFloat)centerX {  return self.center.x; }
- (CGFloat)centerY {  return self.center.y; }
- (CGFloat)x       {  return self.frame.origin.x; }
- (CGFloat)y       {  return self.frame.origin.y; }
- (CGFloat)width   {  return self.frame.size.width; }
- (CGFloat)height  {  return self.frame.size.height; }
- (CGPoint)origin  {  return self.frame.origin; }
- (CGSize)size     {  return self.frame.size; }


/// MARK: - Layer相关属性方法圆角方法
- (CGFloat)cornerRadius {
    // 没必要添加UIImageView，直接在layer上画
    return self.layer.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = (cornerRadius != 0);
}

- (CGFloat)borderWidth {
    return self.layer.cornerRadius;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}
- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}
- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor: self.layer.shadowColor];
}
- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}
- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
    self.layer.masksToBounds = (shadowRadius > 0);
}

- (CGFloat)shadowOpacity {
    return self.layer.shadowOpacity;
}
- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}


#pragma mark - 方法
/** UIView/UILabel设置图片 */
- (void)setBGImage:(NSString *)imageName {
    self.layer.contents = (__bridge id _Nullable)(([UIImage imageNamed:imageName].CGImage));
}

// 从Xib加载View(仅限于XIB中只有一个View的时候)
+ (instancetype)viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

// iOS7.0后系统封装了截屏方法: - snapshotViewAfterScreenUpdates:
- (UIView *)snapView {
     UIView *captureView = [self snapshotViewAfterScreenUpdates:YES];
    return captureView;
}



/**
 *  判断两个View是否有重叠
 *  otherView：跟当前View比较的，如果为空，就代表是窗口控制器的View
 */
- (BOOL)intersectsOtherView:(UIView *)otherView{
    if (otherView == nil) {
        otherView = [UIApplication sharedApplication].keyWindow;
    }
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect otherRect = [otherView convertRect:otherView.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, otherRect);
    
}

#pragma mark - 查找 获取
/** 获取某一点的颜色 */
- (UIColor *)colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}

// 查找一个视图的所有子视图
- (NSMutableArray *)allSubViewsForView:(UIView *)view {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (UIView *subView in view.subviews) {
        [array addObject:subView];
        if (subView.subviews.count > 0) {
            [array addObjectsFromArray:[self allSubViewsForView:subView]];
        }
    }
    return array;
}

// 获取某个view所在的控制器
- (UIViewController *)viewController {
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}

- (UIViewController *)findCurrentResponderViewController{
    UIViewController *currentVC = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        currentVC = nextResponder;
    else {
        UIViewController *topVC = window.rootViewController.presentedViewController;
        if (topVC) {
            currentVC = topVC;
        }else{
            currentVC = window.rootViewController;
        } 
    } 
    return currentVC;
}

#pragma mark - 动画
#pragma mark iOS动画，左右(移动)效果。
- (void)shake {
    // 获取到当前的View
    CALayer *viewLayer = self.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 5, position.y);
    CGPoint y = CGPointMake(position.x - 5, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:0.2];
    // 设置次数
    [animation setRepeatCount:1];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}

// 动画
#define angle2Radio(angle) ((angle)*M_PI/180)
- (void)shaking {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Radio(-5)),  @(angle2Radio(5)), @(angle2Radio(-5))];
    anim.duration = 0.25;
    //动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    //保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:anim forKey:@"shake"];
}

// 开始动画 抖动 类似与长按删除App的动画
- (void)beginWobble:(float)rotateValue{
    srand([[NSDate date] timeIntervalSince1970]);
    float rand=(float)random();
    CFTimeInterval t=rand*0.0000000001;
    
    [UIView animateWithDuration:0.1 delay:t options:0  animations:^{
         self.transform=CGAffineTransformMakeRotation(-rotateValue);
     } completion:^(BOOL finished){
         [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^{
             self.transform=CGAffineTransformMakeRotation(rotateValue);
          } completion:^(BOOL finished) {}];
     }];
}

// 结束动画
- (void)endWobble{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
         self.transform=CGAffineTransformIdentity;
     } completion:^(BOOL finished) {}];
}

@end

// 模态推出透明界面
//UIViewController *vc = [[UIViewController alloc] init];
//UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:vc];
//
//if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
//    na.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//}else {
//    self.modalPresentationStyle = UIModalPresentationCurrentContext;
//}
//
//[self presentViewController:na animated:YES completion:nil];

//// 判断当前ViewController是push还是present的方式显示的
//NSArray *viewcontrollers = self.navigationController.viewControllers;
//if (viewcontrollers.count > 1){
//    if ([viewcontrollers objectAtIndex:viewcontrollers.count - 1] == self) {
//        //push方式
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}else{
//    //present方式
//    [self dismissViewControllerAnimated:YES completion:nil];
//}



