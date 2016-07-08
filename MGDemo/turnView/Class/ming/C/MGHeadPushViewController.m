//
//  MGHeadPushViewController.m


#import "MGHeadPushViewController.h"
#import "MGBodyModel.h"
#import "MGRmndCell.h"

#import "PMElasticRefresh.h"

@interface MGHeadPushViewController ()<UITableViewDataSource, UITableViewDelegate>
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation MGHeadPushViewController

#pragma mark - 懒加载数据
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化UI
    [self setUI];
    
    // 模拟刷新
    self.tableView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             self.datas = (NSMutableArray *)[MGBodyModel objectArrayWithFilename:@"cellDatas.plist"];
             [self.tableView reloadData];
             [self.tableView endRefresh];
         });
    }];
    
    [self.tableView.header beginRefreshing];
}

//设置导航条
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 系统的导航条颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

- (void)setUI
{
    //设置tableView的frame把系统
    self.tableView.frame = CGRectMake(0, 64, MGSCREEN_WIDTH, MGSCREEN_HEIGHT - 64);
    
    //添加tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MGSCREEN_WIDTH, MGSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    //不需要系统自动处理顶部内容伸缩
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置tableView的背景色
    self.tableView.backgroundColor = MGColor(51, 52, 53);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGBodyModel *model = self.datas[indexPath.row];
    MGRmndCell *cell = [MGRmndCell cellWithTableView:self.tableView model:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGLog(@"%ld",indexPath.row);
}

@end
