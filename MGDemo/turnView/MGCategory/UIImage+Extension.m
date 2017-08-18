//
//  UIImage+Extension.m
//  MGMiaoBo
//
//  Created by ming on 16/9/10.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Extension)

/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur {
    // 模糊度越界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    if (inBitmapData) {
        inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    }
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (color) {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    return nil;
}

/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    //设置边框宽度
    CGFloat imageWH = originImage.size.width;
    
    //计算外圆的尺寸
    CGFloat ovalWH = imageWH + 2 * borderWidth;
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    
    //画一个大的圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    [path fill];
    
    //设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageWH, imageWH)];
    [clipPath addClip];
    
    //绘制图片
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    //从上下文中获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)mg_ImageRenderingModeAlwaysOriginal:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



#pragma mark - MG
/** 加载拉伸中间1个像素图片 */
- (instancetype)mg_stretchableImage{
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}

/** 提供一个加载原始图片方法 */
+ (instancetype)mg_imageNamedWithOriganlMode:(NSString *)imageName {
    // 加载原始图片
    UIImage *selImage = [UIImage imageNamed:imageName];
    
    // imageWithRenderingMode:返回每一个没有渲染图片给你
    return  [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/** 对象方法 用drawRect方法生成一张圆形图片 */
- (instancetype)mg_circleImage {
    // 1.开启位图上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 2.添加一个圆(贝瑟尔曲线画圆)
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.裁剪图片
    [path addClip];
    [path stroke];
    
    // 4.将图片绘制到当前
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 5.获取当前图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.结束图文上下文
    UIGraphicsEndImageContext();
    
    // 7.返回一张图片
    return image;
}

/** 类方法 用drawRect方法生成一张圆形图片 */
/**
 *  生成圆角的图片
 *  @param name 原始图片名字
 *  @return 圆形图片
 */
+ (instancetype)mg_circleImageName:(NSString *)name {
    return [[UIImage imageNamed:name] mg_circleImage];
}


#pragma mark - 图片上绘制文字 写一个UIImage的category
- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize{
    //画布大小
    CGSize size=CGSizeMake(self.size.width,self.size.height);
    //创建一个基于位图的上下文
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//opaque:NO  scale:0.0
    
    [self drawAtPoint:CGPointMake(0.0,0.0)];
    
    //文字居中显示在画布上
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    
    //计算文字所占的size,文字居中显示在画布上
    CGSize sizeText=[title boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}context:nil].size;
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);
    //绘制文字
    [title drawInRect:rect withAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[ UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    //返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//// 获取图片某一点的颜色
//- (UIColor*) getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image{
//    
//    UIColor* color = nil;
//    CGImageRef inImage = image.CGImage;
//    UIgraphics
//    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
//    
//    if (cgctx == NULL) {
//        return nil; /* error */
//    }
//    size_t w = CGImageGetWidth(inImage);
//    size_t h = CGImageGetHeight(inImage);
//    CGRect rect = {{0,0},{w,h}};
//    
//    CGContextDrawImage(cgctx, rect, inImage);
//    unsigned char* data = CGBitmapContextGetData (cgctx);
//    if (data != NULL) {
//        int offset = 4*((w*round(point.y))+round(point.x));
//        int alpha =  data[offset];
//        int red = data[offset+1];
//        int green = data[offset+2];
//        int blue = data[offset+3];
//        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:
//                 (blue/255.0f) alpha:(alpha/255.0f)];
//    }
//    CGContextRelease(cgctx);
//    if (data) {
//        free(data);
//    }
//    return color;
//}


@end
