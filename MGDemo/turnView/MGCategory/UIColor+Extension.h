//
//  UIColor+Extension.h
//  VideoShare
//
//  Created by i-Techsys.com on 2017/6/20.
//  Copyright © 2017年 i-Techsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
//随机颜色
+ (UIColor *)randomColor;

/** 16禁止转RGB */
+ (UIColor *)colorWithHexString:(NSString *)colorStr;
@end
