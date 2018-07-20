//
//  ViewController.m
//  turnView
//
//  Created by ming on 16/5/28.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "ViewController.h"
#import "MGVideoViewController.h"
#import "MGSelectViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;
    UITableView *_leftView;
    UITableView *_rightnView;
    UIView *_topBgView;
    BOOL isFirst;
    
    BOOL isPush; // 是否是push过去的 （默认false）
}
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    if (isPush) {
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
            self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    self->isPush = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    if (isPush) {
        [UIView animateWithDuration:0 animations:^{
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
        }];
    }
    
    self.navigationController.navigationBar.hidden = YES;
    
    if (isFirst == NO) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        // 添加启动页的图片
        UIImageView *welcomeImage = [[UIImageView alloc]initWithFrame:window.bounds];
        welcomeImage.image = [self  getWelcomeImage];
        [window addSubview:welcomeImage];
        [window bringSubviewToFront:welcomeImage]; // 把背景图放在最上层
        welcomeImage.alpha = 0.99;//这里alpha的值和下面alpha的值不能设置为相同的，否则动画相当于瞬间执行完，启动页之后动画瞬间消失。这里alpha设为0.99，动画就不会有一闪而过的效果，而是一种类似于静态背景的效果。设为0，动画就相当于是淡入的效果了。
        
        // UIViewAnimationOptionCurveEaseOut
        [UIView animateKeyframesWithDuration:2.5 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            welcomeImage.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
            //        welcomeImage.transform = CGAffineTransformMakeScale(1.3, 1.3);
            welcomeImage.alpha = 0.0;
        } completion:^(BOOL finished) {
            [welcomeImage removeFromSuperview];
        }];
        isFirst = YES;
    }
}

/**
 *  获取启动页的图片
 */
- (UIImage *)getWelcomeImage{
    CGSize viewSize = [[UIApplication sharedApplication]keyWindow].bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImageName];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainView];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    _leftView.contentInset = UIEdgeInsetsMake( 44, 0, 0, 0);
//    _rightnView.contentInset = UIEdgeInsetsMake( 44, 0, 0, 0);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
}

- (void)setMainView{
    _leftView=[[UITableView alloc] initWithFrame:(CGRectMake(0, 64, MGSCREEN_WIDTH, MGSCREEN_HEIGHT-64))];
    _leftView.delegate = self;
    _leftView.dataSource = self;
    [self.view addSubview:_leftView];
    
    _rightnView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, MGSCREEN_WIDTH, MGSCREEN_HEIGHT-64))];
    _rightnView.backgroundColor=[UIColor greenColor];
    [self.view addSubview:_rightnView];

    _topBgView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, MGSCREEN_WIDTH, 64))];
//    _topBgView.alpha = 0.0f;
    [self.view addSubview:_topBgView];
    
    NSArray *segArr=@[@"订单",@"商品"];
    //设置segment
    segment=[[UISegmentedControl alloc] initWithItems:segArr];
    segment.frame=CGRectMake(MGSCREEN_WIDTH/2-266/4, 25, 266/2, 30);
    [segment addTarget:self action:@selector(selectIndex:) forControlEvents:(UIControlEventValueChanged)];
    segment.layer.cornerRadius = 15;
    segment.clipsToBounds = YES;
    
//    segment.layer.borderColor=[UIColor whiteColor].CGColor;
    segment.tintColor=[UIColor orangeColor];
    NSDictionary *dics = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15.0f] forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:dics forState:UIControlStateNormal];
    segment.selectedSegmentIndex = 0;
    [_topBgView addSubview:segment];
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [videoBtn setTitle:@"视频界面" forState:UIControlStateNormal];
    videoBtn.frame  = CGRectMake(MGSCREEN_WIDTH - 80, 20, 40, 24);
    videoBtn.backgroundColor = [UIColor orangeColor];
    [videoBtn sizeToFit];
    [videoBtn addTarget:self action:@selector(videoClick) forControlEvents:UIControlEventTouchUpInside];
    [_topBgView addSubview:videoBtn];

    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setTitle:@"选择" forState:UIControlStateNormal];
    selectBtn.frame  = CGRectMake( 15, 20, 40, 24);
    selectBtn.backgroundColor = [UIColor orangeColor];
    [selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn sizeToFit];
    [_topBgView addSubview:selectBtn];
    [self.view bringSubviewToFront:_leftView];
}

- (void)selectClick{
    self->isPush = YES;
    MGSelectViewController *selectVc = [[MGSelectViewController alloc] init];
    selectVc.hidesBottomBarWhenPushed = YES;
    selectVc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:selectVc animated:NO];
}

- (void)videoClick{
    self->isPush = YES;
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
