//
//  TimerViewController.m
//  RulerDemo
//
//  Created by newunion on 2018/8/6.
//  Copyright © 2018年 ShouBaTeam. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()
/**   */
@property (strong,nonatomic) UILabel *titleLabel;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"10";
    label.center = self.view.center;
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor blueColor];
    
    self.titleLabel = label;
    [self.view addSubview:label];

    __block int i = 10;
    self.titleLabel.text = [NSString stringWithFormat:@"%i",i];
    __weak __typeof(self) weakSelf  = self;
    dispatchTimer(self,1, ^(dispatch_source_t timer) {
        if (i == 0) {
            weakSelf.titleLabel.text = @"定时器被释放";
            dispatch_source_cancel(timer);
        }else {
            i--;
            weakSelf.titleLabel.text = [NSString stringWithFormat:@"%i",i];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}


///**
// 开启一个定时器
// 
// @param target 定时器持有者
// @param timeInterval 执行间隔时间
// @param handler 重复执行事件
// */
//void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer))
//{
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
//    // 通常dispatch_time用于计算相对时间，dispatch_walltime用于计算绝对时间
//    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)),(uint64_t)(timeInterval *NSEC_PER_SEC), 0);
//    //    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
//
//    // 设置回调
//    __weak __typeof(target) weaktarget  = target;
//    dispatch_source_set_event_handler(timer, ^{
//        if (!weaktarget)  {
//            dispatch_source_cancel(timer);
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (handler) handler(timer);
//            });
//        }
//    });
//    // 启动定时器
//    dispatch_resume(timer);
//}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}


@end
