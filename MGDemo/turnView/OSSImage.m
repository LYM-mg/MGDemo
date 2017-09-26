//
//  OSSImage.m
//  ImageUploaderDemo
//  Created by apiapia on 8/1/17.
//  Copyright © 2017 cnwoxiang. All rights reserved.

#import "OSSImage.h"
//#import <AliyunOSSiOS/OSSService.h>

@implementation OSSImageUploader
    static NSString *const AccessKey = @"LTAIXkWYpSm1P0Kt";
    static NSString *const SecretKey = @"o02s4o9sPl0kZthnWjdcoTlfnNGL4J";
    static NSString *const BucketName = @"jrcaixun";
    static NSString *const Endpoint = @"https://oss-cn-zhangjiakou.aliyuncs.com/";
    //FIXME:这个文件夹的名称用 用户UserID来区别
    // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // NSString *kTempFolder = [userDefaults objectForKey:@"userLoginID"];

+ (void)asyncUploadImageID:(NSString *)imageID image:(UIImage *)image complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete{
    [self uploadImagesID:imageID Images:@[image] isAsync:YES complete:complete];
}
 

+ (void)syncUploadImageID:(NSString *)imageID image:(UIImage *)image complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete{
    [self uploadImagesID:imageID Images:@[image] isAsync:NO complete:complete];
}


+ (void)asyncUploadImagesID:(NSString *)imagesID images:(NSArray<UIImage *> *)images complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete {
     [self uploadImagesID:imagesID Images:images isAsync:YES complete:complete];
}

+ (void)syncUploadImagesID:(NSString *)imagesID images:(NSArray<UIImage *> *)images complete:(void (^)(NSArray<NSString *> *, UploadImageState))complete {
    [self uploadImagesID:imagesID Images:images isAsync:NO complete:complete];
}

    
+ (void)uploadImagesID:(NSString *)imagesID Images:(NSArray<UIImage *> *)images isAsync:(BOOL)isAsync complete:(void(^)(NSArray<NSString *> *names, UploadImageState state))complete
{
//    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey                                                                                                            secretKey:SecretKey];
//    
//    OSSClient *client = [[OSSClient alloc] initWithEndpoint:Endpoint credentialProvider:credential];
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = images.count;
//    
//    NSMutableArray *callBackNames = [NSMutableArray array];
//    
//    
//    NSString *kTempFolder = imagesID;
//    NSLog(@"%@", kTempFolder);
//    
//    
//    int i = 0;
//    for (UIImage *image in images) {
//        if (image) {
//            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//                //任务执行
//                OSSPutObjectRequest * put = [OSSPutObjectRequest new];
//                put.bucketName = BucketName;
//                NSString *imageName = [kTempFolder stringByAppendingPathComponent:[[NSUUID UUID].UUIDString stringByAppendingString:@".png"]];
//                put.objectKey = imageName;
//                [callBackNames addObject:imageName];
//                NSData *data = UIImageJPEGRepresentation(image, 0.3);
//                put.uploadingData = data;
//                
//                OSSTask * putTask = [client putObject:put];
//                [putTask waitUntilFinished]; // 阻塞直到上传完成
//                if (!putTask.error) {
//                    NSLog(@"上传对象失败!");
//                } else {
//                    NSLog(@"上传对象失败: %@" , putTask.error);
//                }
//                if (isAsync) {
//                    if (image == images.lastObject) {
//                        NSLog(@"所有对象上传完成!");
//                        if (complete) {
//                            complete([NSArray arrayWithArray:callBackNames] ,UploadImageSuccess);
//                        }
//                    }
//                }
//            }];
//            if (queue.operations.count != 0) {
//                [operation addDependency:queue.operations.lastObject];
//            }
//            [queue addOperation:operation];
//        }
//        i++;
//    }
//    if (!isAsync) {
//        [queue waitUntilAllOperationsAreFinished];
//        NSLog(@"haha");
//        if (complete) {
//            if (complete) {
//                complete([NSArray arrayWithArray:callBackNames], UploadImageSuccess);
//            }
//        }
//    }
}
@end



