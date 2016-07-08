//
//  MGCollectionController.m
//  MGDemo
//
//  Created by ming on 16/6/22.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGCollectionController.h"
#import "MGHeaderCollectionVC.h"
#import "SVProgressHUD.h"

/** 重用标识符 */
static NSString *const CellIdentifier = @"CellIdentifier";

@interface MGCollectionController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/** 数据 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation MGCollectionController
#pragma mark - 懒汉模式
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

#pragma mark - 生命周期方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpLayout];
}

#pragma mark - Nav
- (void)setUpNav{
//    self.navigationController.hidesBarsOnSwipe = YES;
//    self.navigationController.hidesBarsWhenKeyboardAppears = YES;
//    self.navigationController.hidesBarsOnTap = YES;
//    self.navigationController.hidesBarsWhenVerticallyCompact = YES;
    
    UIBarButtonItem *mingItem = [[UIBarButtonItem alloc] initWithTitle:@"明哥" style:UIBarButtonItemStylePlain target:self action:@selector(mingItemClick:)];
    UIBarButtonItem *headItem = [[UIBarButtonItem alloc] initWithTitle:@"headItem" style:UIBarButtonItemStylePlain target:self action:@selector(headItemClick:)];
    self.navigationItem.rightBarButtonItems = @[mingItem,headItem];
}

- (void)mingItemClick:(UIBarButtonItem *)item{
    [SVProgressHUD showImage:[UIImage imageNamed:@"12"] status:@"明哥"];
}

- (void)headItemClick:(UIBarButtonItem *)item{
    MGHeaderCollectionVC *headVC = [[MGHeaderCollectionVC alloc] init];
    headVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:headVC animated:NO];
}

#pragma mark - collectionView
/// 初始化collectionView
- (void)setUpLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((MGSCREEN_WIDTH-10*3)/4, (MGSCREEN_WIDTH-10*3)/4);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
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
    cell.backgroundColor = MGrandomColor;
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.center = CGPointMake(cell.contentView.centerX-20, cell.contentView.centerY - 10);
    label.text = self.dataArr[indexPath.item];
    label.textColor = [UIColor redColor];
    [label sizeToFit];
    [cell addSubview:label];
    
    /** 在MGCollectionController中发现一处崩溃的地方。 长按cells间空白的地方，拖动程序就会崩溃
     *
     *  解法2：注释掉给self.collectionView添加的手势方法
     */
    // 把长按手势添加到cell上，而不是self.collectionView
    // 创建长按手势
//    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
//    [cell addGestureRecognizer:longPressGesture];
    
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
    // 1.取出源item数据
    id objc = [self.dataArr objectAtIndex:sourceIndexPath.item];

    // 2.从资源数组中移除该数据
    [self.dataArr removeObject:objc];
    
    // 3.将数据插入到资源数组中的目标位置上
    [self.dataArr insertObject:objc atIndex:destinationIndexPath.item];
}


#pragma mark - longPress手势
- (void)handleLongGesture:(UILongPressGestureRecognizer *)lpGesture{
       switch(lpGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *selectedIndexPath =  [self.collectionView indexPathForItemAtPoint:[lpGesture locationInView:self.collectionView]];
            
            /** 在MGCollectionController中发现一处崩溃的地方。 长按cells间空白的地方，拖动程序就会崩溃
             *  
             *  解法1：
             */
            // 当移动空白处时，indexPath是空的，移除nil的index时就会崩溃。直接返回
            if (selectedIndexPath == nil){
                return;
            }
            
            
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            break;
        }
        case UIGestureRecognizerStateChanged:
            // 移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[lpGesture locationInView:self.collectionView]];
                break;
        case UIGestureRecognizerStateEnded:
            // 移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - scrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    self.navigationController.hidesBarsOnSwipe = NO;
//}

@end
