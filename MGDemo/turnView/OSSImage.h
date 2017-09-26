//
//  OSSImage.h
//  ImageUploaderDemo
//
//  Created by apiapia on 8/1/17.
//  Copyright © 2017 cnwoxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UploadImageState) {
    UploadImageFailed   = 0,
    UploadImageSuccess  = 1
};
// (NSString *)uploadUserID
@interface OSSImageUploader : NSObject
    
+ (void)asyncUploadImageID:(NSString *)imageID image:(UIImage *)image complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete;
    
+ (void)syncUploadImageID:(NSString *)imageID image:(UIImage *)image  complete:(void(^)(NSArray<NSString *> *names,UploadImageState state))complete;


+ (void)asyncUploadImagesID:(NSString *)imagesID images:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;
    
+ (void)syncUploadImagesID:(NSString *)imagesID images:(NSArray<UIImage *> *)images complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete;
    
    @end

