//
//  MGHeaderCollectionVC.m
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGHeaderCollectionVC.h"
#import "MGHeaderFlowLayout.h"
#import "MGBodyCell.h"
#import "MGHomeModel.h"
#import "MGBodyModel.h"
#import "MGHeaderReusableView.h"
#import "MGHeadPushViewController.h"
#import "MGTranstionViewController.h"


@interface MGHeaderCollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/** collectionView  */
@property (nonatomic,weak) UICollectionView *collectionView;
/** 保存模型属性的数组  */
@property (nonatomic, strong) NSMutableArray *bodyArray;
@end

@implementation MGHeaderCollectionVC
#pragma mark -循环利用标识符
static NSString * const KBodyCellIdentifier = @"KBodyCellIdentifier";
static NSString * const KHeaderReusableViewIdentifier = @"KHeaderReusableViewIdentifier";


#pragma mark - 懒加载
- (NSMutableArray *)bodyArray
{
    if (!_bodyArray) {
        _bodyArray = [NSMutableArray array];
        //字典转模型
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"HomeDatas" ofType:@"plist"]];
        
        //保存模型的数组
//        NSMutableArray *temp = [NSMutableArray array];
//        //字典转模型
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"homeDatas" ofType:@"plist"]];
//        for (NSDictionary *dict in dictArray) {
//            MGHomeModel *home = [MGHomeModel homeWithDict:dict];
//            [temp addObject:home];
//        }
//        _bodyArray = temp;
    }
    
    return _bodyArray;
}

/// 刷新加载数据
- (void)setupRefresh{
    // 上拉刷新
    self.collectionView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSArray *shops = [MGHomeModel objectArrayWithFilename:@"homeDatas.plist"];
            //保存模型的数组
            NSMutableArray *tempArray = [NSMutableArray array];
            //字典转模型
            NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"homeDatas" ofType:@"plist"]];
            for (NSDictionary *dict in dictArray) {
                MGHomeModel *home = [MGHomeModel homeWithDict:dict];
                [tempArray addObject:home];
            }

            
            [self.bodyArray removeAllObjects];
            [self.bodyArray addObjectsFromArray:tempArray];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.header endRefreshing];
        });
    }];
    
    // 下拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSArray *shops = [MGHomeModel objectArrayWithFilename:@"homeDatas.plist"];
            [self.bodyArray addObjectsFromArray:shops];
            //保存模型的数组
            NSMutableArray *tempArray = [NSMutableArray array];
            //字典转模型
            NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"homeDatas" ofType:@"plist"]];
            for (NSDictionary *dict in dictArray) {
                MGHomeModel *home = [MGHomeModel homeWithDict:dict];
                [tempArray addObject:home];
            }
            [self.bodyArray addObjectsFromArray:tempArray];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.footer endRefreshing];
        });
    }];
    
    // 隐藏下拉刷新
    if (self.bodyArray.count==0) {
        self.collectionView.footer.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置collectionView
    [self setUpCollectionView];
    
    [self setupRefresh];
    // 第一次刷新手动调用
    [self.collectionView.header beginRefreshing];
}

/** 设置导航栏 */
- (void)setupNav
{
    self.navigationItem.title = @"collectionView的头部视图漂浮";
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"翻转" style:UIBarButtonItemStylePlain target:self action:@selector(transition)];
}

- (void)transition {
    [self showViewController:[MGTranstionViewController new] sender:nil];
}
    
/* 设置collectionView */
- (void)setUpCollectionView
{
    //布局
    MGHeaderFlowLayout *layout = [[MGHeaderFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MGSCREEN_WIDTH, 150);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    //设置头部视图的尺寸
    layout.headerReferenceSize = CGSizeMake(MGSCREEN_WIDTH, MGSCREEN_HEIGHT * 0.085);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, MGNavHeight, MGSCREEN_WIDTH, MGSCREEN_HEIGHT) collectionViewLayout:layout];
    
    collectionView.showsVerticalScrollIndicator = NO;
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    collectionView.bounces = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGBodyCell class]) bundle:nil] forCellWithReuseIdentifier:KBodyCellIdentifier];
//    [self.collectionView registerClass:[MGBodyCell class] forCellWithReuseIdentifier:KBodyCellIdentifier];
    //注册头部视图
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHeaderReusableViewIdentifier];
}


#pragma mark - UICollectionViewDataSource
/** 返回有多少组  */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.bodyArray.count;
}

/** 返回每组有多少个item  */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //每组的模型
    MGHomeModel *homeModel = self.bodyArray[section];
    
    return homeModel.body.count;
}

/** 返回每个item的具体内容  */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGBodyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KBodyCellIdentifier forIndexPath:indexPath];
    
    //组模型
    MGHomeModel *home = self.bodyArray[indexPath.section];
    
    //行模型
    MGBodyModel *body = home.body[indexPath.row];
    
    cell.bodyModel = body;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
//点击collectionView的item的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    MGLogFunc;
}

#pragma mark - 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头部视图
    if (kind == UICollectionElementKindSectionHeader) {
        MGHeaderReusableView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:KHeaderReusableViewIdentifier forIndexPath:indexPath];
        headerRV.homeModel = self.bodyArray[indexPath.section];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerRVTap:)];
        [headerRV addGestureRecognizer:tap];
        return headerRV;
        
    }else
    {
        return nil;
    }
}

#pragma mark - HeadView点击手势
//点击headView推到MGHeadPushViewController控制器
- (void)headerRVTap:(UITapGestureRecognizer *)tap
{
//    MGHeaderReusableView *headView = (MGHeaderReusableView *)tap.view;
    MGHeadPushViewController *headPushVC = [[MGHeadPushViewController alloc] init];
//    headPushVC.headModel = headView.homeModel;
    [self.navigationController pushViewController:headPushVC animated:YES];
}

@end
