//
//  MGWanWanViewController.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/25.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGWanWanViewController.h"
#import "MGPolygonVC.h"
#import "MGRunTimeVC.h"
#import "AppDelegate.h"
#import "MGScrollViewLabel.h"

@interface MGWanWanViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shakeBtn;
@property (nonatomic,strong) UIScrollView *showView;
@end

@implementation MGWanWanViewController

//  是否支持自动转屏
- (BOOL)shouldAutorotate {
    return true;
}

//// 支持哪些转屏方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskAll;
//}
//
//// 页面展示的时候默认屏幕方向（当前ViewController必须是通过模态ViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *KAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    KAppDelegate.isLandscape = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    AppDelegate *KAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    KAppDelegate.isLandscape = false;
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKeyPath:@"orientation"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBGImage:@"ming3"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"RunTime" style:UIBarButtonItemStylePlain target:self action:@selector(runtimeClick)];
    
//    self.navigationController.toolbarHidden = NO;
    [self addScrollViewLabel];
}

- (void)runtimeClick {
    [self showViewController:[MGRunTimeVC new] sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%@", self.toolbarItems);
    
    // 截屏功能 iOS7 [_shakeBtn snapView];
//    UIView *captureView = [_shakeBtn snapshotViewAfterScreenUpdates:false];
//    [self.view addSubview:captureView];
//    captureView.frame = CGRectMake(120,150,200,200);
}
- (IBAction)start:(id)sender {
    [UIDevice setOrientationLandscapeRight];
    [_shakeBtn beginWobble:0.1];
    UIColor *color = [_shakeBtn colorOfPoint:CGPointMake(10, 10)];
    NSLog(@"%@", color);
    [self setStatusBarBackgroundColor:[UIColor randomColor]];
    
    UIViewController *vc1 = [self.shakeBtn findCurrentResponderViewController];
    UIViewController *vc2 = [sender findCurrentResponderViewController];
}
- (IBAction)end:(id)sender {
    [UIDevice setOrientationPortrait];
    [_shakeBtn endWobble];
    UIViewController *vc = [self.view findCurrentResponderViewController];
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"停止动画" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"测试window" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIViewController *vc1 = [self.view findCurrentResponderViewController];
        NSLog(@"dsadsa");
    }];

    [alertVc addAction:cancelAction];
    [alertVc addAction:action];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVc animated:YES completion:nil];
    
    [self setStatusBarBackgroundColor:[UIColor redColor]];
}


- (IBAction)change:(UITextField *)sender {
    id nextResponder = [self getFirstResponder];
    NSLog(@"%@", nextResponder);
}

- (IBAction)changePushAnimation:(UIBarButtonItem *)sender {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.8;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"cube";
//    transition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    // 之后push
    [self.navigationController pushViewController:[MGPolygonVC new] animated:NO];
}



- (void)addScrollViewLabel {
    MGScrollViewLabel *sl = [[MGScrollViewLabel alloc] initWithFrame:CGRectMake(20, 200, MGSCREEN_WIDTH-40, 22)];
    sl.scrollStr = @"  喜欢这首情思幽幽的曲子，仿佛多么遥远，在感叹着前世的情缘，又是那么柔软，在祈愿着来世的缠绵。《莲的心事》，你似琉璃一样的晶莹，柔柔地拨动我多情的心弦。我，莲的心事，有谁知？我，莲的矜持，又有谁懂？  ";
    sl.direction = Horizontal;
    [self.view addSubview:sl];
    [sl beginScolling];
}
//    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    // 获取文本
//    NSString *string = @"  喜欢这首情思幽幽的曲子，仿佛多么遥远，在感叹着前世的情缘，又是那么柔软，在祈愿着来世的缠绵。《莲的心事》，你似琉璃一样的晶莹，柔柔地拨动我多情的心弦。我，莲的心事，有谁知？我，莲的矜持，又有谁懂？  ";
//    tapLabel.text = string;
//    tapLabel.numberOfLines = 0;
//    tapLabel.textColor     = [UIColor cyanColor];
//    
//    // 计算尺寸
//    CGRect rect = [tapLabel textRectForBounds:CGRectMake(0, 0, MGSCREEN_WIDTH-40, MAXFLOAT) limitedToNumberOfLines:0];
//    tapLabel.frame = rect;
////    CGSize size         = [tapLabel boundingRectWithSize:CGSizeMake(0, 0)];
////    tapLabel.frame         = (CGRect){CGPointZero, size};
//    // 初始化ScrollView
//    UIScrollView *showView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 200, MGSCREEN_WIDTH-40, 22)];
//    showView.contentSize   = rect.size;
//    showView.clipsToBounds = true;
//    showView.showsHorizontalScrollIndicator = NO;
//    [showView addSubview:tapLabel];
//    [self.view addSubview:showView];
//    self.showView = showView;
////    rect.size.height
//    
//    // 动画
////    [UIView animateKeyframesWithDuration:20
////                                   delay:1
////                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction
////                              animations:^{
////                                  // 计算移动的距离
////                                  CGPoint point = showView.contentOffset;
////                                  point.x = rect.size.width - (MGSCREEN_WIDTH-40);
////                                  showView.contentOffset = point;
////                              } completion:^(BOOL finished) {
////                                  showView.contentOffset = CGPointZero;
////                              }];
//    
//    
//    [UIView beginAnimations:@"parent" context:nil];
//    [UIView setAnimationDelay:1.0];
//    [UIView setAnimationDuration:15.0f];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationRepeatCount:MAXFLOAT];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationWillStartSelector:@selector(startAni:)];
//    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
//    // 计算移动的距离
//    CGPoint point = showView.contentOffset;
//    point.x = rect.size.width - (MGSCREEN_WIDTH-40);
////    point.y = rect.size.height - 22;
//    showView.contentOffset = point;
//    [UIView commitAnimations];
//}
//
//- (void)startAni:(NSString *)aniID{
//    
//}
//
//- (void)stopAni:(NSString *)aniID{
//    [UIView animateWithDuration:0.1 animations:^{
//       self.showView.contentOffset = CGPointZero;
//    }];
//}
@end
