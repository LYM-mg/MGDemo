//
//  MGPhotoCollectionViewController.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGPhotoCollectionViewController.h"
#import "MGPhotoFlowLayout.h"
#import "AppDelegate.h"

@interface MGPhotoCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDataSource>
@property (nonatomic,weak) UICollectionView *collectionView;
@end

@implementation MGPhotoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            MGPhotoFlowLayout *layout = [MGPhotoFlowLayout new];
            layout.ColOfPortrait = 3;
            layout.ColOfLandscape = 4;
            layout.LayoutDirection = 0;
            layout.DoubleColumnThreshold = 70;
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
            collectionView.dataSource = self;
//            collectionView.delegate = self;
            collectionView;
        });
    }
    return _collectionView;
}

#pragma mark - 生命周期
- (void)viewDidDisappear:(BOOL)animated {
    //将试图还原为竖屏
    AppDelegate *KAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    KAppDelegate.isLandscape = NO;
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKeyPath:@"orientation"];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // 通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    //将试图还原为竖屏
    AppDelegate *KAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    KAppDelegate.isLandscape = true;
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeLeft) forKeyPath:@"orientation"];
}

- (void)onDeviceOrientationChange {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown || orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationPortraitUpsideDown) { return; }
    if ([[UIDevice currentDevice] isLandscape]) {
        NSLog(@"横屏适配");
    } else {
        NSLog(@"竖屏适配");
    }
    [self.view layoutIfNeeded];
    [self.collectionView reloadData];
}

//  是否支持自动转屏
- (BOOL)shouldAutorotate {
    return true;
}

// 支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

// 页面展示的时候默认屏幕方向（当前ViewController必须是通过模态ViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


#pragma mark -- RotateToReLayout
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    MGPhotoFlowLayout *layout = (MGPhotoFlowLayout *)self.collectionView.collectionViewLayout;
    [layout invalidateLayout];
}


#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"ming%ld",indexPath.row%4+1];
    [cell setBGImage:imageName];
    
    return cell;
}



@end
