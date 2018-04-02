//
//  XJLTaskViewController.m
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import "XJLTaskViewController.h"
#import "XJLTaskCell.h"
#import "XJLWatchLiveTaskCell.h"
#import "XJLTaskHeaderView.h"
#import "XJLLiveTaskHeaderView.h"

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *taskCellIdentifier = @"taskCellIdentifier";
static NSString *watchLivetaskCellIdentifier = @"watchLivetaskCellIdentifier";

@interface XJLTaskViewController ()

@end

@implementation XJLTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.isLiveTask == YES) {
        self.view.layer.cornerRadius = 5 * ScreenWidthRatio;
        self.view.layer.masksToBounds = YES;
    }
    [self setUpUI];
    self.title = NSLocalizedString(@"PC_TASK_CENTER", nil);
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}


- (void)setUpUI{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerClass:[XJLTaskCell class] forCellReuseIdentifier:taskCellIdentifier];
    [self.tableView registerClass:[XJLWatchLiveTaskCell class] forCellReuseIdentifier:watchLivetaskCellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//        for (UIView *view in cell.subviews) {
//            if (view.y < 0) {
//                [view removeFromSuperview];
//            }
//        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15 * ScreenWidthRatio];
        cell.textLabel.textColor = MGColor(27, 27, 27);
        cell.textLabel.text = NSLocalizedString(@"PC_TASK_DAILY_TASK", nil);
        return cell;
    }else if (indexPath.row == 1) {
        XJLWatchLiveTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:watchLivetaskCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        XJLTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:taskCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 2) {
            cell.image.image = [UIImage imageNamed:@"icon_anchor_mission"];
            cell.titleLabel.text = NSLocalizedString(@"PC_TASK_FOLLOW_IDOLS", nil);
            cell.contentLabel.text =  [NSString stringWithFormat:@"%@3%@120%@",NSLocalizedString(@"PC_TASK_FOLLOW_RECIVE", nil),NSLocalizedString(@"PC_TASK_OLIVE_WHEN_FOLLOW", nil),NSLocalizedString(@"PC_TASK_IDOLS", nil)];
            cell.type = XJLTaskReceived;
        }else if (indexPath.row == 3) {
            cell.image.image = [UIImage imageNamed:@"icon_share_mission"];
            cell.titleLabel.text = NSLocalizedString(@"PC_TASK_SHARE", nil);
            cell.contentLabel.text =  [NSString stringWithFormat:@"%@3%@150%@",NSLocalizedString(@"pc_TASK_SHARE_SUCCESS_RECEIVE", nil),NSLocalizedString(@"PC_TASK_IF_YOU_SHARE", nil),NSLocalizedString(@"PC_TASK_TIMES_OLIVE", nil)];
            cell.type = XJLTaskUnComplete;
        }else {
            cell.image.image = [UIImage imageNamed:@"icon_barrage_mission"];
            cell.titleLabel.text = NSLocalizedString(@"PC_TASK_SEND_MESSAGE", nil);
            cell.contentLabel.text =  [NSString stringWithFormat:@"%@20%@50%@",NSLocalizedString(@"PC_TASK_SEND_RECEIVE", nil),NSLocalizedString(@"PC_TASK_OLIVES_SEND_MESSAGE", nil),NSLocalizedString(@"PC_TASK_OLIVES_MESSAGE", nil)];
            cell.type = XJLTaskUnReceive;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return 44 * ScreenHeightRatio;
    }else if (indexPath.row == 1) {
        return 191 * ScreenHeightRatio;
    }else{
        return 69 * ScreenHeightRatio;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.isLiveTask) {

        return [[UIView alloc]init];
    }else{
        XJLTaskHeaderView *view = [[XJLTaskHeaderView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 118 * ScreenHeightRatio, MGSCREEN_WIDTH, 2)];
        bgview.backgroundColor = [UIColor whiteColor];
        [view addSubview:bgview];
        view.clipsToBounds = NO;
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.isLiveTask) {
        return 0;
    }else{
        return 118 * ScreenHeightRatio;
    }
}

@end
