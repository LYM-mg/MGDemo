//
//  MGSelectViewController.m
//  MGDemo
//
//  Created by ming on 16/6/22.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGSelectViewController.h"
#import "MGCollectionController.h"
#import "MGWaterflowLayout.h"
#import "MGShopCell.h"
#import "MGShopModel.h"
#import "MJRefresh.h"
#import "MJExtension.h"

/** 重用标识符 */
static NSString *const ShopCellIdentifier = @"ShopCellIdentifier";

@interface MGSelectViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,MGWaterflowLayoutDelegate>{
    UIView *pageBgView; //背景透明
    UIView *headView; // 头部选择View
    UITableView *_itemTableView;
    NSInteger selectTag;
    NSInteger flag;
    NSArray *newOrOldArr;
    NSArray *orderArr;
    NSArray *carArr;
    
    NSString  *newString;
    NSString *carString;
    NSString *orderString;
}

/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation MGSelectViewController
#pragma mark - 懒汉模式
- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"可移动collect" style:UIBarButtonItemStyleDone target:self action:@selector(toCollection)];
    
    // 初始化选择view的数据
    carString=[NSString string];
    newString=[NSString string];
    orderString=[NSString string];
    carArr = [NSArray arrayWithObjects:@"法拉利",@"奔腾",@"大汽",@"大众",@"奔驰",@"本田",@"宝马",@"明哥",@"MG",@"摩托车",@"拖拉机",@"摩托车",@"拖拉机",@"MG明明就是你",nil];
    newOrOldArr = [NSArray arrayWithObjects:@"全部",@"全新",@"二手", nil];
    orderArr = [NSArray arrayWithObjects:@"最新发布",@"价格最高",@"价格最低",@"人气最高", nil];
    
    [self setMainView];
    
    [self setupRefresh];
    
    // 第一次刷新手动调用
    [self.collectionView.header beginRefreshing];
}

- (void)toCollection{
    [self.navigationController pushViewController:[[MGCollectionController alloc] init] animated:YES];
}

/// 刷新加载数据
- (void)setupRefresh{
    // 上拉刷新
    self.collectionView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSArray *shops = [MGShopModel objectArrayWithFilename:@"1.plist"];
            [self.shops removeAllObjects];
            [self.shops addObjectsFromArray:shops];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.header endRefreshing];
        });
    }];
    
    // 下拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSArray *shops = [MGShopModel objectArrayWithFilename:@"1.plist"];
            [self.shops addObjectsFromArray:shops];
            
            // 刷新数据
            [self.collectionView reloadData];
            
            [self.collectionView.footer endRefreshing];
        });
    }];
    
    // 隐藏下拉刷新
    self.collectionView.footer.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setMainView{
    ///    透明背景
    pageBgView =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), MGSCREEN_WIDTH, MGSCREEN_HEIGHT-CGRectGetMaxY(headView.frame)+64)];
    pageBgView.backgroundColor=[UIColor blackColor];
    pageBgView.alpha = 0.9f;
    pageBgView.hidden = YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [pageBgView addGestureRecognizer:tap];
    [self.view addSubview:pageBgView];
    
    /// 选择列表头部
    headView = [[UIView alloc] initWithFrame:(CGRectMake(0, 64, MGSCREEN_WIDTH, 35))];
    headView.backgroundColor= [UIColor redColor];
    [self.view addSubview:headView];
    
    /// 类别
    NSArray *arr=@[@"车型",@"分类",@"排序"];
    NSInteger count = arr.count;
    for (int i=0;i<count;i++) {
        UIButton *itemBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        itemBtn.frame=CGRectMake(MGSCREEN_WIDTH/count*i, 0, MGSCREEN_WIDTH/count, 35);
        itemBtn.tag=102+i;
        [itemBtn addTarget:self action:@selector(btnHandled:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:itemBtn];
        
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(MGSCREEN_WIDTH/count*i-10, itemBtn.orgin.y,MGSCREEN_WIDTH/count/count*2, 35)];
        titleLabel.font=[UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment=NSTextAlignmentRight;
        titleLabel.text = arr[i];
        titleLabel.tag=201+i;
        [headView addSubview:titleLabel];
        UIImageView *arrow=[[UIImageView alloc] initWithFrame:(CGRectMake(MGSCREEN_WIDTH/6-20+30+9+3, (35-9)/2, 10, 9))];
        arrow.image=[UIImage imageNamed:@"up1"];
        arrow.contentMode=UIViewContentModeCenter;
        arrow.tag=505;
        [itemBtn addSubview:arrow];
    }
    
    // 创建布局
    MGWaterflowLayout *flowLayout = [[MGWaterflowLayout alloc] init];
    flowLayout.delegate = self;
    
    /// 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(headView.frame), MGSCREEN_WIDTH, MGSCREEN_HEIGHT-CGRectGetMaxY(headView.frame)+64) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view insertSubview:collectionView belowSubview:pageBgView];
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MGShopCell class]) bundle:nil] forCellWithReuseIdentifier:ShopCellIdentifier];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 创建长按手势
//    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
//    [self.collectionView addGestureRecognizer:longPressGesture];
    
    /// 创建_itemTableView(点击header弹出的tableView)
    _itemTableView =[[UITableView alloc] initWithFrame:self.collectionView.frame style:(UITableViewStylePlain)];
    _itemTableView.dataSource = self;
    _itemTableView.delegate = self;
    _itemTableView.hidden = YES;
    _itemTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _itemTableView.backgroundColor=[UIColor blackColor];
    _itemTableView.alpha=0.7f;
    [self.view addSubview:_itemTableView];
}

//点击事件
- (void)btnHandled:(UIButton *)sender{
    if(sender.tag>=102&&sender.tag<200){
        UIImageView *arrow=(UIImageView *)[sender viewWithTag:505];
        for(UIView *view in headView.subviews){

            if(view.tag>101&&view.tag<200){

                UIImageView *arrow=(UIImageView *)[view viewWithTag:505];
                [UIView animateWithDuration:0.25f animations:^{
                    arrow.transform = CGAffineTransformMakeRotation(6.28);
                } completion:nil];
            }
        }
       
        
        // 是否点击的是同一个
        if(selectTag==sender.tag){

            selectTag=0;
            _itemTableView.hidden=YES;
            [UIView animateWithDuration:0.25f animations:^{
                arrow.transform = CGAffineTransformMakeRotation(6.28);
            } completion:^(BOOL finished) {
                pageBgView.hidden = YES;
            }];

        }else{
            [UIView animateWithDuration:0.25f animations:^{
                arrow.transform = CGAffineTransformMakeRotation(3.14);
            } completion:nil];
            selectTag = sender.tag;
            flag=sender.tag-101;
            _itemTableView.hidden = NO;
            pageBgView.hidden = NO;
            [_itemTableView reloadData];
        }
    }
}

#pragma mark - 手势
- (void)onTap{
    _itemTableView.hidden=YES;
    pageBgView.hidden=YES;
    for(UIView *view in headView.subviews){
        
        if(view.tag>101&&view.tag<200){
            UIImageView *arrow=(UIImageView *)[view viewWithTag:505];
            [UIView animateWithDuration:0.5f animations:^{
                arrow.transform = CGAffineTransformMakeRotation(6.28);
            } completion:nil];
        }
    }
}

#pragma mark - UITableDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _itemTableView){
        switch (flag) {
            case 1:
                _itemTableView.frame=CGRectMake(0, _itemTableView.frame.origin.y, MGSCREEN_WIDTH, 44*[carArr count]);
                return [carArr count];
                break;
            case 2:
                _itemTableView.frame=CGRectMake(0, _itemTableView.frame.origin.y, MGSCREEN_WIDTH, 44*[newOrOldArr count]);
                return [newOrOldArr count];
                break;
            case 3:
                _itemTableView.frame=CGRectMake(0, _itemTableView.frame.origin.y, MGSCREEN_WIDTH, 44*orderArr.count);
                return [orderArr count];
                break;
            default:
                return 0;
                break;
        }
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kcell = @"kcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcell];
    if(tableView ==_itemTableView){
        if(cell == nil){
            
            cell=[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kcell];
            UIView *line=[[UIView alloc] initWithFrame:(CGRectMake(0 ,43.5,MGSCREEN_WIDTH ,0.5))];
            line.backgroundColor = MGrandomColor;
            line.tag=101;
            [cell addSubview:line];
            
        }
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.tintColor= [UIColor redColor];
        UIView *line =(UIView *)[cell viewWithTag:101];
        switch (flag) {
            case 1:{
                
                cell.textLabel.text=[carArr objectAtIndex:indexPath.row];
                if([cell.textLabel.text isEqualToString:carString]){
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else{
                    cell.accessoryType=UITableViewCellAccessoryNone;
                    line.backgroundColor = MGrandomColor;
                }
                break;
            }
            case 2:{
                
                cell.textLabel.text=[newOrOldArr objectAtIndex:indexPath.row];
                if([cell.textLabel.text isEqualToString:newString]){
                    cell.accessoryType=UITableViewCellAccessoryCheckmark;
                }
                else{
                    cell.accessoryType=UITableViewCellAccessoryNone;
                    line.backgroundColor = MGrandomColor;
                }
                break;
            }
            case 3:{
                cell.textLabel.text=[orderArr objectAtIndex:indexPath.row];
                if([cell.textLabel.text isEqualToString:orderString]){
                    cell.accessoryType=UITableViewCellAccessoryCheckmark;
                    
                }
                else{
                    cell.accessoryType=UITableViewCellAccessoryNone;
                    line.backgroundColor= MGrandomColor;
                }
                break;
            }
            default:
                break;
        }
        cell.backgroundColor=[UIColor blackColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
// 处理不同的逻辑
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==_itemTableView){
        
        _itemTableView.hidden=YES;
        pageBgView.hidden=YES;
        UILabel *label=(UILabel *)[headView viewWithTag:flag+200];
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        label.text=cell.textLabel.text;
        UIButton *sender=(UIButton *)[headView viewWithTag:101+flag];
        UIImageView *arrow=(UIImageView *)[sender viewWithTag:505];
        [UIView animateWithDuration:0.25f animations:^{
            arrow.transform = CGAffineTransformMakeRotation(6.28);
        } completion:^(BOOL finished) {
            
        }];
        switch (flag) {
            case 1:{
                carString = cell.textLabel.text;
                [_itemTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
                // 网络操作
                break;
            }
            case 2:{
                newString = cell.textLabel.text;
                [_itemTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                // 网络操作
                break;
            }
            case 3:
                orderString = cell.textLabel.text;
                // 网络操作
                break;
            default:
                
                break;
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopCellIdentifier forIndexPath:indexPath];

    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark - MGWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(MGWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    MGShopModel *shop = self.shops[indexPath.item];
    
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout
{
    return 20;
}

- (CGFloat)columnCountInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout
{
    if (self.shops.count <= 50) return 4;
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 20, 30, 10);
}



@end
