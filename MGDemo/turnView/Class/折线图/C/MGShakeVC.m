//
//  MGShakeVC.m
//  MGDemo
//
//  Created by ming on 16/7/8.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGShakeVC.h"
#import <AVFoundation/AVFoundation.h>

@interface MGShakeVC ()
/** imgUp */
@property (nonatomic,strong) UIImageView *imgUp;
/** imgDown */
@property (nonatomic,strong) UIImageView *imgDown;
/** imgGif */
@property (nonatomic,strong) UIImageView *imgGif;

@property (nonatomic,strong) AVAudioPlayer *player;

@end

@implementation MGShakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 上半部分的图
//    self.imgUp = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MGSCREEN_WIDTH, 270 * MGSCREEN_WIDTH / 375)];
//    self.imgUp.image = [UIImage imageNamed:@"ShakeUp1"];
//    [self.view addSubview:self.imgUp];
//    
//    // 下半部分的图
//    self.imgDown = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.imgUp.y + self.imgUp.height , MGSCREEN_WIDTH, MGSCREEN_HEIGHT - 64 - self.imgUp.y - self.imgUp.height)];
//    self.imgDown.image = [UIImage imageNamed:@"ShakeDown1"];
//    [self.view addSubview:self.imgDown];
//    // 中间的 GIF
//    self.imgGif = [[UIImageView alloc]initWithFrame:CGRectMake((MGSCREEN_WIDTH - 100 * MGSCREEN_WIDTH / 375) / 2, 210 * MGSCREEN_WIDTH / 375, 100 * MGSCREEN_WIDTH / 375, 100 * MGSCREEN_WIDTH / 375)];
//    self.imgGif.image = [UIImage imageNamed:@"1"];
//    [self.view addSubview:self.imgGif];
//    
//    // 装载图片的数组
//    NSMutableArray *imageArray = [NSMutableArray array];
//    for (int i = 0; i < 6; i ++)
//    {
//        NSString *imageString = [NSString stringWithFormat:@"%d", i + 1];
//        UIImage *image = [UIImage imageNamed:imageString];
//        [imageArray addObject:image];
//    }
//    self.imgGif.animationImages = imageArray;
//    self.imgGif.animationDuration = 0.2;
//    self.imgGif.animationRepeatCount = FLT_MAX;
//    self.imgGif.hidden = YES;
//    
//    // 获得 self.view 的所有子视图
//    NSArray *arr=[self.view subviews];
//    // 将 imgGif 放到最下面
//    [self.view insertSubview:[arr lastObject] belowSubview:[arr firstObject]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"摇一摇";
    // 摇一摇
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 摇一摇
// 检测到摇一摇
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始");
    //振动效果
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    if (event.subtype == UIEventSubtypeMotionShake)
    {
//        [UIView animateWithDuration:0.4 animations:^{
//            self.imgUp.image = [UIImage imageNamed:@"ShakeUp"];
//            self.imgDown.image = [UIImage imageNamed:@"ShakeDown"];
//            self.imgUp.y = -70 * MGSCREEN_WIDTH / 375;
//            self.imgDown.y = (MGSCREEN_HEIGHT - 64 - 263)* MGSCREEN_WIDTH / 375;
//            self.imgGif.hidden = NO;
//            [self.imgGif startAnimating];
//        }];
        NSString *soundFielPath= [[NSBundle mainBundle]pathForResource:@"normal" ofType:@"aac"];
        NSURL *fileURL=[[NSURL alloc]initFileURLWithPath:soundFielPath];
        AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        self.player = newPlayer;
        [self.player prepareToPlay];
        //开始播放
        [self.player play];
    }
}

// 摇一摇取消
-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"取消");
//    [UIView animateWithDuration:0.4 animations:^{
//        self.imgUp.y = 0;
//        self.imgDown.y = 270 * (MGSCREEN_WIDTH / 375);
//        self.imgUp.image = [UIImage imageNamed:@"ShakeUp1"];
//        self.imgDown.image = [UIImage imageNamed:@"ShakeDown1"];
//    } completion:^(BOOL finished) {
//        [self.imgGif stopAnimating];
//        self.imgGif.hidden = YES;
//    }];
}

// 摇一摇结束
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake)
    {
//        [UIView animateWithDuration:0.4 animations:^{
//            self.imgUp.y = 0;
//            self.imgDown.y = 270*( MGSCREEN_WIDTH / 375);
//            self.imgUp.image = [UIImage imageNamed:@"ShakeUp1"];
//            self.imgDown.image = [UIImage imageNamed:@"ShakeDown1"];
//        } completion:^(BOOL finished) {
//            [self.imgGif stopAnimating];
//            self.imgGif.hidden = YES;
//            num -= 1;
//            if (num <= 0)
//            {
//                num = 0;
//            }
//            label.text = [NSString stringWithFormat:@"摇一摇有惊喜, 今日剩余%ld次", (long)num];
//        }];
        NSString *soundFielPath= [[NSBundle mainBundle]pathForResource:@"lose" ofType:@"aac"];
        NSURL *fileURL=[[NSURL alloc] initFileURLWithPath:soundFielPath];
        AVAudioPlayer *newPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        self.player=newPlayer;
        [self.player prepareToPlay];
        [self.player play];
        NSLog(@"摇到 xxx");
    }
}


@end
