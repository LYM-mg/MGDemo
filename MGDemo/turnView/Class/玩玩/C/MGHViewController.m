//  MGHViewController.m
//  MGDemo
//  Created by i-Techsys.com on 2017/9/26.
//  Copyright © 2017年 ming. All rights reserved.
// https://github.com/LYM-mg
// http://www.jianshu.com/u/57b58a39b70e

#import "MGHViewController.h"
#import "MGHFlowLayout.h"
#import "MGListViewController.h"

@interface MGHViewController ()<UICollectionViewDataSource,MGHFlowLayoutDelegate>
@property (nonatomic,weak) UICollectionView *collectionView;
@end

@implementation MGHViewController

static NSString * const HCellID = @"HCellID";

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            MGHFlowLayout *layout = [MGHFlowLayout new];
            layout.delegate = self;
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            collectionView.dataSource = self;
            collectionView.backgroundColor = [UIColor redColor];
            //            collectionView.delegate = self;
            collectionView;
        });
    }
    return _collectionView;
}

#pragma mark - 生命周期
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HCellID];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试安装App" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
}

- (void)test {
    [self.navigationController pushViewController:[MGListViewController new] animated:true ];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.collectionView reloadData];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HCellID forIndexPath:indexPath];
//    NSString *imageName = [NSString stringWithFormat:@"ming%ld",indexPath.row%4+1];
//    [cell setBGImage:imageName];
    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
}

#pragma mark -- MGHFlowLayoutDelegate



@end
