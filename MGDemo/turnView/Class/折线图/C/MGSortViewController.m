//
//  MGSortViewController.m
//  MGDemo
//
//  Created by newunion on 2018/4/13.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGSortViewController.h"

#pragma mark- 循环利用标识符
static NSString *const kSortCellIdentfier = @"kSortCellIdentfier";

@interface MGSortViewController ()
@property (strong,nonatomic) NSMutableArray *data;
@end

@implementation MGSortViewController
- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray arrayWithCapacity:30];
        Person *p1 = [[Person alloc] initWithName:@"许笨蛋" age:20 score:97];
        Person *p2 = [[Person alloc] initWithName:@"anne" age:8 score:33];
        Person *p3 = [[Person alloc] initWithName:@"zhng" age:54 score:11];
        Person *p4 = [[Person alloc] initWithName:@"tuoma" age:76 score:54];
        Person *p5 = [[Person alloc] initWithName:@"笨蛋" age:95 score:12];
        Person *p6 = [[Person alloc] initWithName:@"boy" age:21 score:76];
        Person *p7 = [[Person alloc] initWithName:@"傻瓜" age:53 score:98];
        Person *p8 = [[Person alloc] initWithName:@"hack" age:33 score:66];
        Person *p9 = [[Person alloc] initWithName:@"MG明明" age:33 score:21];
        Person *p10 = [[Person alloc] initWithName:@"无法原谅" age:69 score:88];
        
        [_data addObject:p1];
        [_data addObject:p2];
        [_data addObject:p3];
        [_data addObject:p4];
        [_data addObject:p5];
        [_data addObject:p6];
        [_data addObject:p7];
        [_data addObject:p8];
        [_data addObject:p9];
        [_data addObject:p10];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数组排序";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(sortClick)];
    // 注册 cell
//    [self.tableView registerClass:[UITableViewCell class]
//           forCellReuseIdentifier:kSortCellIdentfier];
}

- (void)sortClick {
    NSSortDescriptor *ageSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];//ascending:YES 代表升序 如果为NO 代表降序
    NSSortDescriptor *scoreSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];//ascending:YES 代表升序 如果为NO 代表降序
//    [self.data sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        
//    }];
    [self.data sortUsingDescriptors:@[scoreSortDescriptor,ageSortDescriptor]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSortCellIdentfier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSortCellIdentfier];
    }
    Person *p = self.data[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@  年龄：%d",p.name,p.age];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%f", p.score];
    return cell;
}

@end



@implementation Person
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age score:(float)score
{
    if (self = [super init]) {
        
        self.name = name;
        self.age = age;
        self.score = score;
        
    }
    return self;
}
@end
