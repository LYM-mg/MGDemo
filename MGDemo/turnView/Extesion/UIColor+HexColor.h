//
//  UIColor+HexColor.h
//  HexColor
//
//  Created by ZHANGHAI SHENG on 16/4/26.
//  Copyright © 2016年 ZHANGHAI SHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

//随机颜色
+ (UIColor *)randomColor;

//16进制自动转换RGB颜色
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
