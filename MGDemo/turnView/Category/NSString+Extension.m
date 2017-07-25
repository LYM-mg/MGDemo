//
//  NSString+NSString_Extension.m
//  VideoShare
//
//  Created by i-Techsys.com on 2017/6/18.
//  Copyright © 2017年 i-Techsys. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
#pragma mark - 沙盒路径
/* 默认情况下，每个沙盒含有3个文件夹：Documents, Library 和 tmp
 Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 Library：存储程序的默认设置或其它状态信息；
 Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
 tmp：提供一个即时创建临时文件的地方。
 iTunes在与iPhone同步时，备份所有的Documents和Library文件。
 iPhone在重启时，会丢弃所有的tmp文件。
 */
// 获取Cache目录：
- (NSString *)getCachePath {
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"%@", path);
    return path;
}

// 获取documents目录：
- (NSString *)getDocumentPath {
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"%@", path);
    return path;
}

// 获取Libarary目录：
- (NSString *)getLibraryPath {
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"%@", path);
    return path;
}

// 获取tmp目录：
- (NSString *)getTemporaryPath {
    NSString *tmpDir = NSTemporaryDirectory();
    NSLog(@"%@", tmpDir);
    return tmpDir;
}

// NSFileManager创建目录、文件
// 创建文件：
- (NSString *)creatFileUseFileName:(NSString *)fileName {
    NSString *rootPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:plistPath]) {
        [fileManager createFileAtPath:plistPath contents:nil attributes:[NSDictionary dictionary]]; //创建一个dictionary文件
        return plistPath;
    }
    return plistPath;
}

#pragma mark -
/** iOS 获取汉字的拼音 */
+ (NSString *)transform:(NSString *)chinese {
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
}

#pragma mark - 
// 判断空值别直接 if (str) ，如果字符串为空描述时可能出现问题
- (BOOL)isBlank{
    if (self == nil || self == NULL || [self isKindOfClass:[NSNull class]]){
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

#define NUMBERS @"0123456789.-"
#pragma mark - 是否只包含数字，小数点，负号
- (BOOL)isOnlyhasNumberAndpoint {
    NSCharacterSet *cs=[[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filter=[[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filter];
}

#pragma mark 文字高度
- (CGFloat)textHByLineSpace:(CGFloat)lineSpace width:(CGFloat)width font:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil].size;
    return size.height;
}

@end
