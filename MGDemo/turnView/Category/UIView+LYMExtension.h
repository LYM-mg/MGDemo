//
//  UIView+LYMExtension.h
//  UIView+LYMExtension.h
//
//  Created by ming on 13/12/10.
//  Copyright © 2013年 ming. All rights reserved.
/**
 此类不仅封装了控件的Frame，还封装了快速从XIB创建View的方法(仅限于XIB中只有一个View的时候)
 此外，还封装了两个View是否有重叠的方法
 */

#import <UIKit/UIKit.h>

@interface UIView (LYMExtension)
#pragma mark - 属性
/** 中心点的X */
@property (nonatomic, assign) CGFloat centerX;
/** 中心点的Y */
@property (nonatomic, assign) CGFloat centerY;
/** origin的X */
@property (nonatomic, assign) CGFloat x;
/** origin的Y */
@property (nonatomic, assign) CGFloat y;
/** 控件的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 控件的高度 */
@property (nonatomic, assign) CGFloat height;
/** 控件的origin */
@property(nonatomic,assign) CGPoint origin;
/** 控件的尺寸 */
@property (nonatomic, assign) CGSize size;

/// MARK: - Layer相关属性方法圆角方法
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic,assign) IBInspectable CGFloat borderWidth;
@property (nonatomic,weak)   IBInspectable UIColor *borderColor;
@property (nonatomic,assign) IBInspectable CGSize shadowOffset;
@property (nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property (nonatomic,assign) IBInspectable CGFloat shadowOpacity;
@property (nonatomic,weak)   IBInspectable UIColor *shadowColor;

#pragma mark - 方法
/** UIView/UILabel设置图片 */
- (void)setBGImage:(NSString *)imageName;

/** 从Xib加载View(仅限于XIB中只有一个View的时候) */
+ (instancetype)viewFromXib;

/** iOS7.0后系统封装了截屏方法: - snapshotViewAfterScreenUpdates: */
- (UIView *)snapView;

/**
 *  判断两个View是否有重叠
 *  otherView：跟当前View比较的，如果为空，就代表是窗口控制器的View
 */
- (BOOL)intersectsOtherView:(UIView *)otherView;

#pragma mark - 获取查找
/** 获取某一点的颜色 */
- (UIColor *) colorOfPoint:(CGPoint)point;

/** 查找一个视图的所有子视图 */
- (NSMutableArray *)allSubViewsForView:(UIView *)view;

/** 获取某个view所在的控制器 */
- (UIViewController *)viewController;

/** 查找视图当前控制器 */
- (UIViewController *)findCurrentResponderViewController;

#pragma mark - 动画
/** iOS动画，左右(移动)效果。 */
- (void)shake;

/** 抖动动画 */
- (void)shaking;


// 开始动画 抖动 类似与长按删除App的动画
- (void)beginWobble:(float)rotateValue;
// 结束动画
- (void)endWobble;

@end
