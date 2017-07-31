//
//  MGPhotoCollectionViewController.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGPhotoCollectionViewController.h"
#import "MGPhotoFlowLayout.h"

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
            collectionView.delegate = self;
            collectionView;
        });
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
