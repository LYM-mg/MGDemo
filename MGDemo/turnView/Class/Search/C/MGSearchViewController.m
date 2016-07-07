//
//  MGSearchViewController.m
//  MGDemo
//
//  Created by ming on 16/6/21.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGSearchViewController.h"
#import "MGSearchCell.h"
#import "MGCar.h"
#import "MGCarGroup.h"

#define headH 64
#define LYMheadH 200

@interface MGSearchViewController ()<UISearchBarDelegate,UISearchResultsUpdating>{
    /** 要删除的数据 */
    NSMutableArray *_deleteArray;
}

/** 数据源 */
@property (strong,nonatomic) NSMutableArray *dataList;
/** 搜索数据源 */
@property (strong,nonatomic) NSMutableArray *searchList;

/** 搜索控制器 */
@property (nonatomic, strong) UISearchController *searchController;


@end

@implementation MGSearchViewController
#pragma mark - 懒汉模式
- (NSMutableArray *)dataList{
    if(_dataList == nil){
        // 初始化
        // 1.获得plist的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total" ofType:@"plist"];
        
        // 2.加载字典数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            // 3.1.创建模型对象
            MGCarGroup *group = [MGCarGroup groupWithDict:dict];
            
            // 3.2.添加模型对象到数组中
            [groupArray addObject:group];
        }
        // 4.赋值
        _dataList = groupArray;
    }
    return _dataList;
}

/**
 * 搜索框🔍
 */
- (UISearchController *)searchController{
    if (_searchController == nil) {
        // iOS 8.0上
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
        self.searchController.searchBar.backgroundColor = [UIColor purpleColor];
    
        self.tableView.tableHeaderView = self.searchController.searchBar;

        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    return  _searchController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化导航栏
    [self setUpNav];
    
    // 允许编辑多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

/// 初始化导航栏
- (void)setUpNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(backItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(editButtonItemClick)];
}

/// 导航栏编辑的点击
- (void)backItemClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)editButtonItemClick{
    //获取导航栏右侧的按钮的标题
    NSString*title=self.navigationItem.rightBarButtonItem.title;
    
    if([title isEqualToString:@"删除"])
        
    {
        // 进入表格的多选状态
        self.tableView.editing = YES;
        
        // 将导航栏的按钮改为确定
        self.navigationItem.rightBarButtonItem.title = @"确定";
    }else{
        // 执行删除操作
        //--------将删除数组中的元素从数据源数组中删除- (void)removeObjectsInArray:(NSArray *)otherArray------------
        [self.dataList removeObjectsInArray:_deleteArray];
        
        // 清空删除数组
        [_deleteArray removeAllObjects];
        
        // 取消表格的编辑状态
        self.tableView.editing = NO;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 将导航栏按钮的标题恢复成“删除”
        self.navigationItem.rightBarButtonItem.title = @"删除";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.searchController.active ? self.searchList.count : self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // self.searchController.active进行判断即可，也就是UISearchController的active属性:
    if (self.searchController.active) {
//        return [self.searchList count];
        MGCarGroup *group = self.searchList[section];
        return group.cars.count;
    }else{
        MGCarGroup *group = self.dataList[section];
        return group.cars.count;
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1.循环利用标识符
    static NSString *const cellIdentifier =@"cellIdentifier";
    
    // 2.根据循环利用标识符从缓存池中获取cell
    MGSearchCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        // 创建cell
        cell = [[MGSearchCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (self.searchController.active) { // 展示searchList数据
//        [cell.textLabel setText:self.searchList[indexPath.row]];
        MGCarGroup *group = self.searchList[indexPath.section];
        MGCar *car = group.cars[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:car.icon];
        cell.textLabel.text = car.name;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"3453%d",arc4random_uniform(200000)];
    }
    else{ // 展示dataList数据
        // 4.设置数据
        MGCarGroup *group = self.dataList[indexPath.section];
        MGCar *car = group.cars[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:car.icon];
        cell.textLabel.text = car.name;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"3453%d",arc4random_uniform(200000)];
    }
        
    return cell;
}

/**
 *  第section组显示的头部标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    MGCarGroup *group = self.dataList[section];
    return group.title;
}

/**
 *  返回右边索引条显示的字符串数据
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.dataList valueForKeyPath:@"title"];
}


#pragma mark - UISearchBarDelegate,UISearchResultsUpdating
// 具体调用的时候使用的方法也发生了改变，这个时候使用updateSearchResultsForSearchController进行结果过滤:
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [self.dataList mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems) {

        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        
        
        // friendName field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"title"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        // friendId field matching
        lhs = [NSExpression expressionForKeyPath:@"cars.name"];
        rhs = [NSExpression expressionForConstantValue:searchString];
        finalPredicate = [NSComparisonPredicate
                          predicateWithLeftExpression:lhs
                          rightExpression:rhs
                          modifier:NSDirectPredicateModifier
                          type:NSContainsPredicateOperatorType
                          options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        [searchItemsPredicate addObject:finalPredicate];

        // at this OR predicate to our master AND predicate
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    self.searchList = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    [self.tableView reloadData];
    
    /**
     1.BEGINSWITH ： 搜索结果的字符串是以搜索框里的字符开头的
     2.ENDSWITH   ： 搜索结果的字符串是以搜索框里的字符结尾的
     3.CONTAINS   ： 搜索结果的字符串包含搜索框里的字符
     
     [c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
     
     */
    //    // 1.取得搜索框的文字
//    NSString *searchString = [self.searchController.searchBar text];
//    
//    // 2.过滤
//    searchString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; // 过滤空格
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    
//    // 3.移除上一次的数据
//    if (self.searchList != nil) {
//        [self.searchList removeAllObjects];
//    }
//    
//    // 4.过滤数据
//    self.searchList = [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:predicate]];
//    
//    // 5.刷新表格
//    [self.tableView reloadData];
}

#pragma mark - TableViewDelegate
//选择某一行时讲将该行的内容添加到删除数组
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果在编辑状态
    if(tableView.editing){
#warning 实际开发中取出的应该是model
        //取出选中的对象
        NSString *model =self.dataList[indexPath.row];
        
        //-----------如果删除数组不包含model------- (BOOL)containsObject:(id)anObject;-----
        if(![_deleteArray containsObject:model]){
            // 则添加到删除数组
            [_deleteArray addObject:model];
        }
    }
}

// 取消选择表示不需要删除这条数据，将该行的内容从删除数组中移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 如果在编辑状态
    if(tableView.editing){
        // 取出选中的对象
        NSString *model =self.dataList[indexPath.row];

        if(![_deleteArray containsObject:model]){
            // 则从删除数组中移除
            [_deleteArray removeObject:model];
        }
    }
}


// 重写系统的编辑按钮的点击方法
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}
// 设置哪些行可以进行编辑,通过返回yes和no来判断.
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //每行都可以编辑
    return  YES;
}
// 设置编辑的样式.
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - 左划出现删除
// 默认状态只有是delete的时候可以左划出现删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //根据不同的判断结果实现不同的效果
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 要实现删除,第一件事是删除数组里对应的数据
        [self.dataList removeObjectAtIndex:indexPath.row];
        // 将要消失的行加动画,消失画面变得柔和
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

/** 自定义左滑出现的按钮 */
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *firstAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [UIView animateWithDuration:1.0 animations:^{
            //在block里,写对应rowaction的点击事件
            // 1.左滑消失，正常显示
            [self.tableView setEditing:NO animated:NO];
            // 2.将该indexPath移动到第一行
            [tableView moveRowAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            // 3.让tableView滚动到顶部
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    firstAction.backgroundColor = [UIColor purpleColor];
    deleteAction.backgroundColor = [UIColor blueColor];
    return @[firstAction,deleteAction];
}

// tableview的移动
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //1.先获取要移动的数据/model
    NSString *str = self.dataList[sourceIndexPath.row];
    //2.把数组里对应的字符串从数组中移除掉
    [self.dataList removeObjectAtIndex:sourceIndexPath.row];
    [self.dataList insertObject:str atIndex:destinationIndexPath.row];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat offset = scrollView.contentOffset.y;
//    if (offset<0) {
//        CGRect frame = self.contV.frame;
//
//        frame.origin.y += offset;
//        frame.size.height -= offset;
//        self.headV.frame = frame;
//    }
//}

@end
