//
//  UIImage+ImageEffects.h
//  SwiftLive
//
//  Created by 查俊松 on 16/4/29.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

/**
 * 调用示例（毛玻璃效果）
 * UIImage *effectImage = [[UIImage new] applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:1 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil];
 **/

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
