//
//  UIColor+HexColor.m
//  HexColor
//
//  Created by ZHANGHAI SHENG on 16/4/26.
//  Copyright © 2016年 ZHANGHAI SHENG. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)


//随机颜色
+ (UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256)/255.0;
    CGFloat g = arc4random_uniform(256)/255.0;
    CGFloat b = arc4random_uniform(256)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


/**
 *  16进制自动转换RGB颜色
 *
 *  @param stringToConvert   传入16进制色值
 *
 *  @return 返回iOS中支持的RGB值
 *
 *  注意：iOS中默认不支持16进制色值，但是在公司中或者UI美工一般都使用标准的16进制表示颜色，
 *  我们可以通过这个方法将美工给的16进制颜色进行转换就OK了
 *
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
