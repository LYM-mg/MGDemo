//
//  MGTableController.m
//  turnView
//
//  Created by ming on 2016/6/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGTableController.h"
#import "UIView+Extension.h"
#import "MGHeadView.h"
#import "TableViewHead.h"

#import "MGSectionModel.h"
#import "MGCellModel.h"


@interface MGTableController ()

/** 顶部的ImageView */
@property (nonatomic,strong) UIImageView *topImageView;

/** 头部数据源 */
@property (nonatomic,strong) NSMutableArray *sectionDataSources;

/** cell数据源不用设置，因为已经在头部设置了数据源 */
//@property (nonatomic,strong) NSArray *dataSources;

@end


@implementation MGTableController

#pragma mark- 循环利用标识符
static NSString *const headViewIdentifier = @"headViewIdentifier";
static NSString *const CellIdentfier = @"CellIdentfier";

#pragma mark-  lazy
// 设置数据源
- (NSMutableArray *)sectionDataSources{
    if (!_sectionDataSources)
    {
        _sectionDataSources = [NSMutableArray array];
        for (NSUInteger i = 0; i < 10; ++i) {
            MGSectionModel *sectionModel = [[MGSectionModel alloc] init];
            sectionModel.isExpanded = NO;
            sectionModel.sectionTitle = [NSString stringWithFormat:@"section: %ld", i];
            NSMutableArray *itemArray = [[NSMutableArray alloc] init];
            for (NSUInteger j = 0; j < 10; ++j)
            {
                MGCellModel *cellModel = [[MGCellModel alloc] init];
                cellModel.title = [NSString stringWithFormat:@"MG明明就是你：section=%ld, row=%ld", i, j];
                [itemArray addObject:cellModel];
            }
            sectionModel.cellModels = itemArray;
            
            [_sectionDataSources addObject:sectionModel];
        }
    }
    return _sectionDataSources;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建头部的imageView
    [self setUpScaleHeaderView];
    
    [self setUpTableViewHead];
    
    // 注册headView
    [self.tableView registerClass:[MGHeadView class] forHeaderFooterViewReuseIdentifier:headViewIdentifier];
    // 注册 cell
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CellIdentfier];
}

#pragma mark- -setUpTableViewHead
- (void)setUpTableViewHead{
    TableViewHead *head = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewHead class]) owner:nil options:nil].lastObject;
    head.frame = CGRectMake(0, 0, MGScreen_W, 170);
    
    self.tableView.tableHeaderView = head;
}

#pragma mark- -createScaleHeaderView
- (void)setUpScaleHeaderView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    topView.backgroundColor = [UIColor clearColor];
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _topImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    _topImageView.backgroundColor = [UIColor whiteColor];
    _topImageView.layer.cornerRadius = _topImageView.bounds.size.width/2;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.image = [UIImage imageNamed:@"12"];
    [topView addSubview:_topImageView];
    self.navigationItem.titleView = topView;
}

#pragma mark - TableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 取得每一组的头部模型
    MGSectionModel *sectionModel = self.sectionDataSources[section];
    
    //                                      展开既有数据，未展开则没有数据
    return sectionModel.isExpanded ? sectionModel.cellModels.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    
    // 先去的sectionModel，再获取cellModel
    MGSectionModel *sectionModel = self.sectionDataSources[indexPath.section];
    MGCellModel *cellModel = sectionModel.cellModels[indexPath.row];
    cell.textLabel.text = cellModel.title;

    
    return cell;
}

#pragma mark - TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MGHeadView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headViewIdentifier];
    
    MGSectionModel *sectionModel = self.sectionDataSources[section];
    sectionHeadView.model = sectionModel;
    
    sectionHeadView.expandCallback = ^(BOOL isExpanded){
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return sectionHeadView;
}

// 返回每一个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

// 返回每一组的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

#pragma mark - UIScrollViewDelegate
//MARK:-滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentSet = scrollView.contentOffset.y + self.tableView.contentInset.top;
    
    if (contentSet >= 0 && contentSet <= 30) {
        _topImageView.transform = CGAffineTransformMakeScale(1 - contentSet/64, 1-contentSet/64);
        _topImageView.y = 0;
    } else if (contentSet > 30) {
        _topImageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        _topImageView.y = 0;
    } else if (contentSet < 0 ) {
        _topImageView.transform = CGAffineTransformMakeScale(1, 1);
        _topImageView.y = 0;
    }
    
}

@end
