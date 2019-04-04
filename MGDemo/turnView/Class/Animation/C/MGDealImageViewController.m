//
//  MGDealImageViewController.m
//  MGDemo
//
//  Created by newunion on 2019/4/4.
//  Copyright © 2019年 ming. All rights reserved.
//

#import "MGDealImageViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface MGDealImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV3;
@property (weak, nonatomic) IBOutlet UIImageView *imageV4;
@property (weak, nonatomic) IBOutlet UIImageView *imageV5;
@property (weak, nonatomic) IBOutlet UIImageView *imageV6;

@end

@implementation MGDealImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"调用相机" style:UIBarButtonItemStyleDone target:self action:@selector(openCamera)];
    [self testImage2];
    [self testImage3];
    [self testImage4];
    [self testHightImage5];
}

- (void)dealloc {
    MGLogFunc;
}


- (void)testImage2 {
    UIImage *image = [UIImage imageNamed:@"ming3"];
    UIImage *newImage = [self convertDataToUIImage:[self convertUIImageToData:image] width:image];
    self.imageV2.image = newImage;
}

- (void)testImage3 {
    UIImage *image = [UIImage imageNamed:@"ming3"];
    unsigned char *data = [self imageGrayWithData:[self convertUIImageToData:image] width:image];
    UIImage *newImage = [self convertDataToUIImage:data width:image];
    self.imageV3.image = newImage;
}

- (void)testImage4 {
    UIImage *image = [UIImage imageNamed:@"ming3"];
    unsigned char *data = [self imageColorWithData:[self convertUIImageToData:image] width:image];
    UIImage *newImage = [self convertDataToUIImage:data width:image];
    self.imageV4.image = newImage;
}

- (void)testHightImage5 {
    UIImage *image = [UIImage imageNamed:@"ming3"];
    unsigned char *data = [self convertUIImageToData:image];
    unsigned char *hightLightdata = [self imageHightLightWithData:data width:image];
    UIImage *newImage = [self convertDataToUIImage:hightLightdata width:image];
    self.imageV5.image = newImage;
}


- (void)openCamera {
    [self openCamera:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - 照相机
/**
 *  打开照相机/打开相册
 */
- (void)openCamera:(UIImagePickerControllerSourceType)type{
    if (![UIImagePickerController isSourceTypeAvailable:type]){
        NSString *tipStr = (type == UIImagePickerControllerSourceTypeCamera) ?@"相机不可用": @"相册不可用";
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;

    NSString *mediaTypes = (__bridge NSString *)kUTTypeImage;
    ipc.mediaTypes = [NSArray arrayWithObjects:mediaTypes, nil];
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

        //1.获取用户选中的图片
    UIImage *selectedImg =  info[UIImagePickerControllerOriginalImage];


        //3.隐藏当前图片选择控制器
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 转换
// 1.UIImage -> CGImage 2.CGColorSpace 3.分配bit空间 4.CGBitmap 5.渲染
- (unsigned char *)convertUIImageToData:(UIImage *)image {
    CGImageRef cgImage = [image CGImage];
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // 每个像素带你占4个字节
    void *data = malloc(width*height*4);

   CGContextRef context = CGBitmapContextCreate(data, width, height, 8, width*4, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);

    return (unsigned char *)data;
}

- (UIImage *)convertDataToUIImage:(unsigned char *)imageData width:(UIImage *)image {

    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    NSInteger dataLength = width*height*4;

    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, imageData, dataLength, NULL);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent intent = kCGRenderingIntentDefault;

    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4*width;

    CGImageRef cgImage = CGImageCreate(width, height,bitsPerComponent,bitsPerPixel, bytesPerRow, colorSpace, bitmapInfo,  provider, NULL, NO, intent);

    UIImage *newImage = [UIImage imageWithCGImage:cgImage];

    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(provider);
    return newImage;
}

#pragma mark - 灰度处理
- (unsigned char *)imageGrayWithData:(unsigned char *)imageData width:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;

    unsigned char *resultData = malloc(width*height*sizeof(unsigned char)*4);
    memset(resultData, 0, width*height*sizeof(unsigned char)*4);
    for (int h = 0; h<height; h++) {
        for (int w = 0; w<width; w++) {
            unsigned int imageIndex = h*width+w;

            unsigned char bitMapRed = *(imageData + 4*imageIndex);
            unsigned char bitMapGreen = *(imageData + 4*imageIndex+1);
            unsigned char bitMapBlue = *(imageData + 4*imageIndex+2);
            int bitMap = bitMapRed*77/255 + bitMapGreen*151/255 + bitMapBlue*88/255;
            int newBitMap = bitMap <= 255 ? bitMap: 255;
            memset(resultData + 4*imageIndex, newBitMap, 1);
            memset(resultData + 4*imageIndex + 1, newBitMap, 1);
            memset(resultData + 4*imageIndex + 2, newBitMap, 1);
        }
    }
    return resultData;
}

#pragma mark - 彩色底板处理
- (unsigned char *)imageColorWithData:(unsigned char *)imageData width:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;

    unsigned char *resultData = malloc(width*height*sizeof(unsigned char)*4);
    memset(resultData, 0, width*height*sizeof(unsigned char)*4);
    for (int h = 0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h*width+w;

            unsigned char bitMapRed = *(imageData + 4*imageIndex);
            unsigned char bitMapGreen = *(imageData + 4*imageIndex+1);
            unsigned char bitMapBlue = *(imageData + 4*imageIndex+2);
            int newBitMapRed = 255-bitMapRed;
            int newBitMapGreen = 255-bitMapGreen;
            int newBitMapBlue = 255-bitMapBlue;
            memset(resultData + 4*imageIndex, newBitMapRed, 1);
            memset(resultData + 4*imageIndex + 1, newBitMapGreen, 1);
            memset(resultData + 4*imageIndex + 2, newBitMapBlue, 1);
        }
    }
    return resultData;
}

#pragma mark - 美白处理
- (unsigned char *)imageHightLightWithData:(unsigned char *)imageData width:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;

    unsigned char *resultData = malloc(width*height*sizeof(unsigned char)*4);
    memset(resultData, 0, width*height*sizeof(unsigned char)*4);
    NSArray *colorBaseArray = @[@"55",@"110",@"155",@"185",@"220",@"240",@"250",@"255"];

    NSMutableArray *colorArray = [NSMutableArray array];
    int beforeNum = 0;
    for (int i = 0; i<8; i++) {
        NSString *numStr = colorBaseArray[i];
        int num = numStr.intValue;
        float step = 0;

        if (i == 0) {
            step = num/32.0;
            beforeNum = num;
        }else {
            step = (num - beforeNum)/32;
        }
        for (int j=0; j<32; j++) {
            int newNum = 0;
            if (i == 0) {
                newNum = (int)(j*step);
            }else {
                newNum = (int)(beforeNum+j*step);
            }
            NSString *newNumStr = [NSString stringWithFormat:@"%d",newNum];
            [colorArray addObject:newNumStr];
        }
        beforeNum = num;
    }


    for (int h = 0; h<height; h++) {
        for (int w=0; w<width; w++) {
            unsigned int imageIndex = h*width+w;

            unsigned char bitMapRed = *(imageData + 4*imageIndex);
            unsigned char bitMapGreen = *(imageData + 4*imageIndex+1);
            unsigned char bitMapBlue = *(imageData + 4*imageIndex+2);

            NSString *redStr = [colorArray objectAtIndex:bitMapRed];
            NSString *greenStr = [colorArray objectAtIndex:bitMapGreen];
            NSString *bluedStr = [colorArray objectAtIndex:bitMapBlue];
            int newBitMapRed = redStr.intValue;
            int newBitMapGreen = greenStr.intValue;
            int newBitMapBlue = bluedStr.intValue;
            memset(resultData + 4*imageIndex, newBitMapRed, 1);
            memset(resultData + 4*imageIndex + 1, newBitMapGreen, 1);
            memset(resultData + 4*imageIndex + 2, newBitMapBlue, 1);
        }
    }
    return resultData;
}
@end
