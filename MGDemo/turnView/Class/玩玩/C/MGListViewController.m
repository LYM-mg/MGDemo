//  MGListViewController.m
//  MGDemo
//  Created by i-Techsys.com on 2017/9/26.
//  Copyright © 2017年 ming. All rights reserved.
// https://github.com/LYM-mg
// http://www.jianshu.com/u/57b58a39b70e

#import "MGListViewController.h"
#import "MGApplication.h"

@interface MGListViewController ()
@property (nonatomic,strong) NSMutableArray *appList;
@end

@implementation MGListViewController

- (NSMutableArray *)appList {
    if (!_appList) {
        _appList = [NSMutableArray array];
    }
    return _appList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
}

- (void)test {
//        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//        NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//        NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSMutableArray *appsInfoList = [workspace performSelector:@selector(allApplications)];
    //    NSMutableArray *appsInfoList = [workspace performSelector:@selector(allInstalledApplications)];
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    NSLog(@"appsInfoList.count = %lu", (unsigned long)appsInfoList.count);
    [appsInfoList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         MGApplication *app = [[MGApplication alloc] init];
         app.appId = [obj performSelector:NSSelectorFromString(@"applicationIdentifier")];
         app.appVersion = [obj performSelector:NSSelectorFromString(@"shortVersionString")];
         [tmpList addObject:app];
     }];
    self.appList = tmpList;
    NSLog(@"22222222222222222222222222");
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.appList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const listCellID = @"listCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listCellID];
    }
    MGApplication *app = self.appList[indexPath.row];
    cell.textLabel.text = app.appId;
    cell.detailTextLabel.text = app.appVersion;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
