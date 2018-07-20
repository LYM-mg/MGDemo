//
//  MGNavVC.m
//  MGDemo
//
//  Created by ming on 16/7/8.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGNavVC.h"

@interface MGNavVC ()<UINavigationBarDelegate,UIGestureRecognizerDelegate>

@end

@implementation MGNavVC

+ (void)load {
    /// 1.UINavigationBar
    UINavigationBar *navBarAppearence = [UINavigationBar appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//    [navBarAppearence setBackgroundImage:[UIImage imageNamed:@"timo"] forBarMetrics:UIBarMetricsDefault];
    [navBarAppearence setTitleTextAttributes:dict];
}

#pragma mark ========= 添加全屏滑动手势 ==========
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setp1:需要获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // setp2:创建全屏滑动手势~调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // step3:设置手势代理~拦截手势触发
    pan.delegate = self;
    
    // step4:别忘了~给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    
    // step5:将系统自带的滑动手势禁用
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // steo6:还记得刚刚设置的代理吗？下面方法什么时候调用？在每次触发手势之前都会询问下代理，是否触发。
}
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan{
}
/** 判断是否为根控制器 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 只要不等于1就返回YES，说明此时具有滑动功能
    return self.childViewControllers.count != 1;
}

#pragma mark ========= 拦截控制器的push操作 ==========
/**
 *   拦截控制器的push操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        // 判断当前控制器是否为根控制器，如果不是，就执行下列代码
        UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:@"navigationButtonReturn"  highImage:nil title:@"返回" target:self action:@selector(leftBtnClick)];
    
        [viewController.navigationItem setLeftBarButtonItem:leftItem animated:YES];
        
        // 隐藏下面的TabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
//    else{
//        viewController.hidesBottomBarWhenPushed = NO;
//    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}


// 监听按钮的点击
- (void)leftBtnClick{
    [self popViewControllerAnimated:YES];
}

@end
