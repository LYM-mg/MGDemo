//
//  MGPolygonVC.m
//  MGDemo
//
//  Created by ming on 16/7/7.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGPolygonVC.h"
#import "MGPolygonView.h"
#import "MGShakeVC.h"
#import "MGMapViewController.h"
#import "MQGradientProgressView.h"

#import <AVFoundation/AVFoundation.h>


@interface MGPolygonVC ()
/** 绘制折线图的View */
@property (nonatomic,strong) MGPolygonView *drawView;

@property (nonatomic,strong) AVAudioPlayer *player;
@end

@implementation MGPolygonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"绘图";
    [self setUpShake];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"可用地图" style:UIBarButtonItemStyleDone target:self action:@selector(mapClick)];
    
    MGPolygonView *drawView = [[MGPolygonView alloc] initWithFrame:CGRectMake(10, 200, self.view.width - 20, 250)];
    [self.view addSubview:drawView];
    self.drawView = drawView;
    
    [self setCorrectBtn];
    
    UISlider *slide = [[UISlider alloc] initWithFrame:CGRectMake(0, 100, 300, 10)];
    slide.centerX = self.view.centerX;
    slide.value = 0.75;
    slide.continuous = YES;
    [slide addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slide];
    
    MQGradientProgressView *progressView = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, 70, 300, 10)];
    progressView.centerX = self.view.centerX;
    //    progressView.colorArr = @[(id)MQRGBColor(59, 221, 255).CGColor,(id)MQRGBColor(34, 126, 239).CGColor];
    progressView.colorArr = @[(id)[UIColor greenColor]];
    progressView.progress = slide.value;
    progressView.tag = 100001;
    [self.view addSubview:progressView];
}

- (void)changeProgress:(UISlider *)slide {
    MQGradientProgressView *progressView = [self.view viewWithTag:100001];
    progressView.progress = slide.value;
}

- (void)mapClick {
    [self showViewController:[MGMapViewController new] sender:nil];
}

// 设置按钮    圆角
- (void)setCorrectBtn{
    /*
     * 指定了需要成为圆角的角。该参数是UIRectCorner类型的，可选的值有：
     * UIRectCornerTopLeft
     * UIRectCornerTopRight
     * UIRectCornerBottomLeft
     * UIRectCornerBottomRight
     * UIRectCornerAllCorners
     */
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.drawView.frame) + 30, self.view.width - 20, 50)];
    [btn setTitle:@"开始绘制折线图" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(startDrawLine:) forControlEvents:UIControlEventTouchUpInside];
    // 按下时
    [btn addTarget:self action:@selector(pressEvent:) forControlEvents:UIControlEventTouchDown];
}

// 监听按钮点击操作
- (void)startDrawLine:(UIButton *)btn{
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        //执行动作响应
        [self.drawView.lineChartLayer removeFromSuperlayer];
        for (NSInteger i = 0; i < 12; i++) {
            UILabel * label = (UILabel*)[self.drawView viewWithTag:300 + i];
            [label removeFromSuperview];
        }
        
        [self.drawView drawLine];
    }];
}

// 按下按钮是触发的事件 按钮缩小
- (void)pressEvent:(UIButton *)btn{
    // 缩放比例这边必须大于0，并且设置为小于1
    CGFloat scale = 0.6;
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}



- (void)setUpShake{
    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"摇一摇" style:UIBarButtonItemStyleDone target:self action:@selector(shake)];
}

- (void)shake{
    MGShakeVC *vc = [[MGShakeVC alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - 摇一摇相关方法
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        NSString *soundFielPath= [[NSBundle mainBundle]pathForResource:@"buyao" ofType:@"wav"];
        NSURL *fileURL=[[NSURL alloc]initFileURLWithPath:soundFielPath];
        AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        self.player = newPlayer;
        [self.player prepareToPlay];
        //开始播放
        [self.player play];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"取消摇动");
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        NSLog(@"摇动结束");
        NSString *soundFielPath= [[NSBundle mainBundle]pathForResource:@"buyao" ofType:@"wav"];
        NSURL *fileURL=[[NSURL alloc] initFileURLWithPath:soundFielPath];
        AVAudioPlayer *newPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        self.player=newPlayer;
        [self.player prepareToPlay];
        [self.player play];
        NSLog(@"摇到 xxx");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSArray *array = [infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"];
    NSString *icon = [array lastObject];
    NSLog(@"%@", array);
    NSLog(@"%@", icon);
//    NSArray *arr = @[@"icon_qq"];
//    [infoPlist setValue:arr forKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"];
    
}

@end
