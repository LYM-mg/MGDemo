//
//  UIImage+Extension.h
//  MGMiaoBo
//
//  Created by ming on 16/9/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 *  生成原始的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 原始图片
 */
+ (UIImage *)mg_ImageRenderingModeAlwaysOriginal:(NSString *)imageName;


/** 提供一个加载原始图片方法 */
+ (instancetype)mg_imageNamedWithOriganlMode:(NSString *)imageName;

/** 加载拉伸中间1个像素图片 */
- (instancetype)mg_stretchableImage;

/** 对象方法 用drawRect方法生成一张圆形图片 */
- (instancetype)mg_circleImage;

/** 类方法 用drawRect方法生成一张圆形图片 */
+ (instancetype)mg_circleImageName:(NSString *)name;

/** 图片上绘制文字 写一个UIImage的category  */
- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;
@end
