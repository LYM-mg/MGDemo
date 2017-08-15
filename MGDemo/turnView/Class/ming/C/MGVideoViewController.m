//
//  MGVideoViewController.m
//  turnView
//
//  Created by ming on 16/6/14.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreMedia/CoreMedia.h>


#import "SVProgressHUD.h"


static NSString *const MGAssetCollectionName = @"MG的视频集";

@interface MGVideoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *centerFrameImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoDurationLabel;
@property (nonatomic, assign) BOOL shouldAsync;
@end

@implementation MGVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(snap)];
}

- (void)snap {
    _centerFrameImageView.image = [self snapshotScreenInView:self.view];
}

-(UIImage *)snapshotScreenInView:(UIView *)contentView {
    
    CGSize size = contentView.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rect = contentView.frame;
    
    //  自iOS7开始，UIView类提供了一个方法-drawViewHierarchyInRect:afterScreenUpdates: 它允许你截取一个UIView或者其子类中的内容，并且以位图的形式（bitmap）保存到UIImage中
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        [window drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    }
//    [contentView drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

//- (UIImage *)snapImage {
//    CGRect screenFrame = [UIApplication sharedApplication].keyWindow.frame;
//    UIGraphicsBeginImageContextWithOptions(imageSize, YES, [UIScreen mainScreen].scale);
//    for (UIWindow *window in [[UIApplication sharedApplication] windows])
//    {
//        [window drawViewHierarchyInRect:screenFrame afterScreenUpdates:YES];
//    }
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return UIImagePNGRepresentation(image);
//}

// 录制视频
- (IBAction)onRecordVideo:(id)sender {
    [self videoFromcamera];
}

// 从选择视频
- (IBAction)onSelectLocalVideo:(id)sender {
    [self videoFromPhotos];
}

- (IBAction)closeClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 视频相关
/*
 一.保存图片到【Camera Roll】(相机胶卷)
 1.使用函数UIImageWriteToSavedPhotosAlbum
 2.使用AssetsLibrary.framework(iOS9开始, 已经过期)
 3.使用Photos.framework(iOS8开始可以使用, 从iOS9开始完全取代AssetsLibrary.framework)
 
 二.创建新的【自定义Album】(相簿\相册)
 1.使用AssetsLibrary.framework(iOS9开始, 已经过期)
 2.使用Photos.framework(iOS8开始可以使用, 从iOS9开始完全取代AssetsLibrary.framework)
 
 三.将【Camera Roll】(相机胶卷)的图片 添加到 【自定义Album】(相簿\相册)中
 1.使用AssetsLibrary.framework(iOS9开始, 已经过期)
 2.使用Photos.framework(iOS8开始可以使用, 从iOS9开始完全取代AssetsLibrary.framework)
 
 四.Photos.framework须知
 1.PHAsset : 一个PHAsset对象就代表一张图片或者一段视频
 2.PHAssetCollection : 一个PHAssetCollection对象就代表一本相册
 
 五.PHAssetChangeRequest的基本认识
 1.可以对相册图片进行【增\删\改】的操作
 
 六.PHPhotoLibrary的基本认识
 1.对相册的任何修改都必须放在以下其中一个方法的block中
 [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:error:];
 [[PHPhotoLibrary sharedPhotoLibrary] performChanges:completionHandler:];
 */
// 录制视频
- (void)videoFromcamera{
    [self getVideoWithsourceType:UIImagePickerControllerSourceTypeCamera shouldAsync:YES];
}

// 从相册中选择视频"
- (void)videoFromPhotos{
    [self getVideoWithsourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum shouldAsync:NO];
}

- (void)getVideoWithsourceType:(UIImagePickerControllerSourceType)type shouldAsync:(BOOL)shouldAsync{
    // 取得授权状态
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    // 判断当前状态
    if (authStatus == AVAuthorizationStatusRestricted
        || authStatus == AVAuthorizationStatusDenied) {
        // 拒绝当前App访问【Photo】运用
        [SVProgressHUD showInfoWithStatus:@"提醒用户打开访问开关【设置】-【隐私】—【视频】-【MG明明就是你】"];
        return;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = type;
        picker.mediaTypes = @[(NSString *)kUTTypeMovie];
        [self presentViewController:picker animated:YES completion:NULL];
        self.shouldAsync = shouldAsync;
    } else {
        [SVProgressHUD showInfoWithStatus:(@"手机不支持摄像")];
    }
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    if ([UIDevice currentDevice].systemVersion.doubleValue < 9.0) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 判断相册是否兼容视频，兼容才能保存到相册
            if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:videoURL]) {
                [library writeVideoAtPathToSavedPhotosAlbum:videoURL completionBlock:^(NSURL *assetURL, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 写入相册
                        if (error == nil) {
                            AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:assetURL options:nil];
                            Float64 duration = CMTimeGetSeconds(videoAsset.duration);
                            self.videoDurationLabel.text = [NSString stringWithFormat:@"视频时长：%.0f秒",
                                                            duration];
                            
                            if (self.shouldAsync) {
                                __weak __typeof(self) weakSelf = self;
                                // Get center frame image asyncly
                                [self centerFrameImageWithVideoURL:videoURL completion:^(UIImage *image) {
                                    weakSelf.centerFrameImageView.image = image;
                                }];
                            }else {
                                // 同步获取中间帧图片
                                UIImage *image = [self frameImageFromVideoURL:videoURL];
                                self.centerFrameImageView.image = image;
                            }
                            
                            // Begin to compress and export the video to the output path
                            NSString *name = [[NSDate date] description];
                            name = [NSString stringWithFormat:@"%@.mp4", name];
                            [self compressVideoWithVideoURL:videoURL savedName:name completion:^(NSString *savedPath) {
                                if (savedPath) {
                                    NSLog(@"Compressed successfully. path: %@", savedPath);
                                } else {
                                    NSLog(@"Compressed failed");
                                }
                            }];
                            [SVProgressHUD showErrorWithStatus:@"保存视频失败!"];
                        } else {
                            [SVProgressHUD showSuccessWithStatus:@"保存视频成功!"];
                        }
                    });
                }];
            }
        });
    }else{ // iOS9.0以后
        PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = nil;
            // 用来抓取PHAsset的字符串标识
            __block NSString *assetId = nil;
            // 用来抓取PHAssetCollectin的字符串标识符
            __block NSString *assetCollectionId = nil;
            
            // 保存视频到【Camera Roll】(相机胶卷)
            [library performChangesAndWait:^{
                assetId = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:videoURL].placeholderForCreatedAsset.localIdentifier;
            } error:&error];
            
            // 获取曾经创建过的自定义视频相册名字
            PHAssetCollection *createdAssetCollection = nil;
            PHFetchResult <PHAssetCollection *>*assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            for (PHAssetCollection *assetCollection in assetCollections) {
                if ([assetCollection.localizedTitle isEqualToString:MGAssetCollectionName]) {
                    createdAssetCollection = assetCollection;
                    break;
                }
            }
            
            // 如果这个自定义视频相框没有被创建过
            if (createdAssetCollection == nil) {
                // 创建 新的【自定义的Album】(相簿\相册)
                [library performChangesAndWait:^{
                    assetCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:MGAssetCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
                } error:&error];
                
                // 抓取刚刚创建完的视频相册对象
                createdAssetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionId] options:nil].firstObject;
            }
            
            // 将【Camera Roll】(相机胶卷)的视频 添加到 【自定义Album】(相簿\相册)中
            [library performChangesAndWait:^{
                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
                
                // 视频
                [request addAssets:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil]];
            } error:&error];
            
            // 提示信息
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"保存视频失败!"];
            } else {
                [SVProgressHUD showSuccessWithStatus:@"保存视频成功!"];
            }
        });
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        // for fixing iOS 8.0 problem that frame changed when open camera to record video.
        self.tabBarController.view.frame  = [[UIScreen mainScreen] bounds];
        [self.tabBarController.view layoutIfNeeded];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        // for fixing iOS 8.0 problem that frame changed when open camera to record video.
        self.tabBarController.view.frame  = [[UIScreen mainScreen]bounds];
        [self.tabBarController.view layoutIfNeeded];
    }];
}

// Get the video's center frame as video poster image
- (UIImage *)frameImageFromVideoURL:(NSURL *)videoURL {
    // result
    UIImage *image = nil;
    
    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    
    // get the image from
    NSError *error = nil;
    CMTime actualTime;
    // Returns a CFRetained CGImageRef for an asset at or near the specified time.
    // So we should mannully release it
    CGImageRef centerFrameImage = [imageGenerator copyCGImageAtTime:midpoint
                                                         actualTime:&actualTime
                                                              error:&error];
    
    if (centerFrameImage != NULL) {
        image = [[UIImage alloc] initWithCGImage:centerFrameImage];
        // Release the CFRetained image
        CGImageRelease(centerFrameImage);
    }
    
    return image;
}


/// 异步获取帧图
// 异步获取帧图片，可以一次获取多帧图片
- (void)centerFrameImageWithVideoURL:(NSURL *)videoURL completion:(void (^)(UIImage *image))completion {
    // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:videoURL];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    
    // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
    // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
    // 通常来说，600是一个常用的公共参数，苹果有说明:
    // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
    // Japan), and 25 fps for PAL (used for TV in Europe).
    // Using a timescale of 600, you can exactly represent any number of frames in these systems
    CMTime midpoint = CMTimeMakeWithSeconds(duration / 2.0, 600);
    
    // 异步获取多帧图片
    NSValue *midTime = [NSValue valueWithCMTime:midpoint];
    [imageGenerator generateCGImagesAsynchronouslyForTimes:@[midTime] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        if (result == AVAssetImageGeneratorSucceeded && image != NULL) {
            UIImage *centerFrameImage = [[UIImage alloc] initWithCGImage:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(centerFrameImage);
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(nil);
                }
            });
        }
    }];
}

/// 压缩并导出视频
- (void)compressVideoWithVideoURL:(NSURL *)videoURL
                        savedName:(NSString *)savedName
                       completion:(void (^)(NSString *savedPath))completion {
    // Accessing video by URL
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    // Find compatible presets by video asset.
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    // Begin to compress video
    // Now we just compress to low resolution if it supports
    // If you need to upload to the server, but server does't support to upload by streaming,
    // You can compress the resolution to lower. Or you can support more higher resolution.
    if ([presets containsObject:AVAssetExportPreset640x480]) {
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:videoAsset  presetName:AVAssetExportPreset640x480];
        
        NSString *doc = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *folder = [doc stringByAppendingPathComponent:@"MGVideos"];
        BOOL isDir = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:folder isDirectory:&isDir];
        if (!isExist || (isExist && !isDir)) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:folder
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error == nil) {
                [SVProgressHUD showInfoWithStatus:@"目录创建成功"];
            } else {
                [SVProgressHUD showInfoWithStatus:@"目录创建失败"];
            }
        }
        
        NSString *outPutPath = [folder stringByAppendingPathComponent:savedName];
        session.outputURL = [NSURL fileURLWithPath:outPutPath];
        
        // Optimize for network use.
        session.shouldOptimizeForNetworkUse = true;
        
        NSArray *supportedTypeArray = session.supportedFileTypes;
        if ([supportedTypeArray containsObject:AVFileTypeMPEG4]) {
            session.outputFileType = AVFileTypeMPEG4;
        } else if (supportedTypeArray.count == 0) {
            [SVProgressHUD showInfoWithStatus:@"No supported file types"];
            return;
        } else {
            session.outputFileType = [supportedTypeArray objectAtIndex:0];
        }
        
        // Begin to export video to the output path asynchronously.
        [session exportAsynchronouslyWithCompletionHandler:^{
            if ([session status] == AVAssetExportSessionStatusCompleted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion([session.outputURL path]);
                    }
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(nil);
                    }
                });
            }
        }];
    }
}


@end
