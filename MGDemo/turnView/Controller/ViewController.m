//
//  ViewController.m
//  turnView
//
//  Created by ming on 16/5/28.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ViewController.h"
#import "MGVideoViewController.h"


#define MGSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MGSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;
    UITableView *_leftView;
    UITableView *_rightnView;
    UIView *_topBgView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)setMainView{
    _leftView=[[UITableView alloc] initWithFrame:(CGRectMake(0, 64, MGSCREEN_WIDTH, MGSCREEN_HEIGHT-64))];
    _leftView.delegate = self;
    _leftView.dataSource = self;
    [self.view addSubview:_leftView];
    
    _rightnView=[[UITableView alloc] initWithFrame:(CGRectMake(0, 64, MGSCREEN_WIDTH, MGSCREEN_HEIGHT-64))];
    _rightnView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:_rightnView];

    _topBgView=[[UIView alloc] initWithFrame:(CGRectMake(0, 0, MGSCREEN_WIDTH, 64))];
//    _topBgView.alpha = 0.0f;
    [self.view addSubview:_topBgView];
    
    NSArray *segArr=@[@"订单",@"商品"];
    //设置segment
    segment=[[UISegmentedControl alloc] initWithItems:segArr];
    segment.frame=CGRectMake(MGSCREEN_WIDTH/2-266/4, 25, 266/2, 30);
    [segment addTarget:self action:@selector(selectIndex:) forControlEvents:(UIControlEventValueChanged)];
    segment.layer.borderColor=[UIColor whiteColor].CGColor;
    segment.tintColor=[UIColor orangeColor];
    NSDictionary *dics = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15.0f] forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:dics forState:UIControlStateNormal];
    segment.selectedSegmentIndex = 0;
    [self.view insertSubview:segment aboveSubview:_topBgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"视频界面" forState:UIControlStateNormal];
    btn.frame  = CGRectMake(MGSCREEN_WIDTH - 80, 20, 40, 24);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(videoClick) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    [self.view insertSubview:btn aboveSubview:_topBgView];
    
    [self.view bringSubviewToFront:_leftView];
}

- (void)videoClick{
    MGVideoViewController *videoVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MGVideoViewController"];
    videoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoVC animated:NO];
}

#pragma mark - segment的target
- (void)selectIndex:(UISegmentedControl *)segmentor{
    if(segmentor.selectedSegmentIndex==0){
        
        [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionFlipFromLeft)];
        [self.view bringSubviewToFront:_leftView];
        
    }else{
        [self animationWithView:self.view WithAnimationTransition:(UIViewAnimationTransitionFlipFromRight)];
        [self.view bringSubviewToFront:_rightnView];
    }
}

#pragma mark - 翻转动画
- (void) animationWithView:(UIView *)view WithAnimationTransition:(UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:0.5f animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

#pragma mark - scrollView代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:1 animations:^{
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = [UIColor brownColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = 1 - ((64 - offsetY) / 64);
        if (alpha>1) {
            alpha = 1;
        }
        _topBgView.backgroundColor = [color colorWithAlphaComponent:alpha];
    } else {
        _topBgView.backgroundColor = [color colorWithAlphaComponent:0];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [UIView animateWithDuration:1.0 delay:0.8 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
    } completion:nil];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"ming-%ld",indexPath.row];
    return  cell;
}

#pragma mark - 代理
/**
 *   添加cell滚动的动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 防止重复添加动画
    [cell.layer removeAnimationForKey:@"ming"];
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    keyframeAnimation.values = @[@(-2),@(-1),@(1),@(2)];
    keyframeAnimation.duration = 0.3;
    [cell.layer addAnimation:keyframeAnimation forKey:@"ming"];
}

@end
