//
//  MGWanWanViewController.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/25.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGWanWanViewController.h"
#import "MGPolygonVC.h"

@interface MGWanWanViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shakeBtn;

@end

@implementation MGWanWanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBGImage:@"ming3"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    // 截屏功能 iOS7 [_shakeBtn snapView];
    UIView *captureView = [_shakeBtn snapshotViewAfterScreenUpdates:false];
    [self.view addSubview:captureView];
    captureView.frame = CGRectMake(120,150,200,200);
}
- (IBAction)start:(id)sender {
    [_shakeBtn beginWobble:0.1];
    UIColor *color = [_shakeBtn colorOfPoint:CGPointMake(10, 10)];
    NSLog(@"%@", color);
    [self setStatusBarBackgroundColor:[UIColor randomColor]];
    
    UIViewController *vc1 = [self.shakeBtn findCurrentResponderViewController];
    UIViewController *vc2 = [sender findCurrentResponderViewController];
}
- (IBAction)end:(id)sender {
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
@end
