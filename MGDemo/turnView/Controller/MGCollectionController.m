//
//  MGCollectionController.m
//  MGDemo
//
//  Created by ming on 16/6/22.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGCollectionController.h"

/** 重用标识符 */
static NSString *const CellIdentifier = @"CellIdentifier";

@interface MGCollectionController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation MGCollectionController
#pragma mark -懒汉模式
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i<80; i++) {
            NSString *str = [NSString stringWithFormat:@"MG%d",i];
            [_dataArr addObject:str];
        }
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLayout];
}

/// 初始化collectionView
- (void)setUpLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((MGSCREEN_WIDTH-10*5)/4, (MGSCREEN_WIDTH-10*5)/4);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    // 注册
    [collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:CellIdentifier];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 创建长按手势
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    cell.backgroundColor = MGrandomColor;
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] init];

    label.orgin = CGPointMake((cell.width-label.width)/2, (cell.height-label.height)/2);
    label.text = self.dataArr[indexPath.item];
    label.textColor = [UIColor redColor];
    [label sizeToFit];
    [cell.contentView addSubview:label];
    return cell;
}

//返回YES允许其item移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 20) {
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    // 取出源item数据
    id objc = [self.dataArr objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.dataArr removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.dataArr insertObject:objc atIndex:destinationIndexPath.item];
}


#pragma mark - longPress手势
- (void)handleLongGesture:(UILongPressGestureRecognizer *)lpGesture{
    switch(lpGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *selectedIndexPath =  [self.collectionView indexPathForItemAtPoint:[lpGesture locationInView:self.collectionView]];
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            break;
        }
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[lpGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

@end
