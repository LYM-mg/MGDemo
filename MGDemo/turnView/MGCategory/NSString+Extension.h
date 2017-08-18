//
//  NSString+NSString_Extension.h
//  VideoShare
//
//  Created by i-Techsys.com on 2017/6/18.
//  Copyright © 2017年 i-Techsys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**  获取Cache目录： */
- (NSString *)getCachePath;

/**  获取documents目录： */
- (NSString *)getDocumentPath;
/**  获取Libarary目录： */
- (NSString *)getLibraryPath;
/**  获取tmp目录： */
- (NSString *)getTemporaryPath;

// NSFileManager创建目录、文件
// 创建文件：
- (NSString *)creatFileUseFileName:(NSString *)fileName;

/** iOS 获取汉字的拼音 */
+ (NSString *)transform:(NSString *)chinese;

/** 判断空值别直接 if (str) ，如果字符串为空描述时可能出现问题 */
- (BOOL)isBlank;

/** 是否只包含数字，小数点，负号 */
- (BOOL)isOnlyhasNumberAndpoint;

/** 计算文字高度 */
- (CGFloat)textHByLineSpace:(CGFloat)lineSpace width:(CGFloat)width font:(UIFont *)font;
@end
