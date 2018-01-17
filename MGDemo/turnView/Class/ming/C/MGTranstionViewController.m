//
//  MGTranstionViewController.m
//  MGDemo
//
//  Created by newunion on 2018/1/16.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGTranstionViewController.h"
#import "MGAlertController.h"

@interface MGTranstionViewController ()
@property (strong,nonatomic) UIViewController *vc1;
@property (strong,nonatomic) UIViewController *vc2;
@property (weak,nonatomic) UIViewController *currentVc;

@property (nonatomic, copy) NSArray<NSString *> *weathers;
@end

@implementation MGTranstionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _vc1 = [ UIViewController new];
    _vc1.view.backgroundColor = [UIColor redColor];
    _vc2 = [UIViewController new];
    _vc2.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:_vc1];
    [self addChildViewController:_vc2];
    
    [self.view addSubview:_vc2.view];
    [self.view addSubview:_vc1.view];
    
    self.weathers = @[@"晴", @"多云", @"小雨", @"大雨", @"雪", @""];

    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"动态更换图标" style: UIBarButtonItemStylePlain target:self action:@selector(changeIcon)];
}

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
//        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(dy_presentViewController:animated:completion:));
//        // 交换方法实现
//        method_exchangeImplementations(presentM, presentSwizzlingM);
//    });
}

- (void)dy_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
        
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        } else {
            [self dy_presentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    
    [self dy_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)changeIcon {
    NSString *weather = self.weathers[0];
    [self setAppIconWithName:weather];
}

- (void)setAppIconWithName:(NSString *)iconName {
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        MGLog(@"不支持更改图标");
        return;
    }
    
    if (iconName) {
        
    }
    
    [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
        if (error) {
            MGLog(@"更换app图标发生错误了 ： %@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int i = 0;
    i += 1;
    if (i%2 == 1) {
        [self transitionFromViewController:_vc1 toViewController:_vc2 duration:1.0 options:UIViewAnimationOptionPreferredFramesPerSecondDefault animations:nil completion:^(BOOL finished) {
//            self.currentVc = _vc2;
        }];
    }else {
        [self transitionFromViewController:_vc2 toViewController:_vc1 duration:1.0 options:UIViewAnimationOptionPreferredFramesPerSecond30 animations:nil completion:^(BOOL finished) {
//            self.currentVc = _vc1;
        }];
    }
    
    MGAlertController *alertVc = [MGAlertController new];
    [alertVc setValue: @(UIAlertControllerStyleActionSheet) forKeyPath:@"preferredStyle"];
    alertVc.title = @"dsa";
    [self presentViewController:alertVc animated:true completion:nil];
}

@end
