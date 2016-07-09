//
//  MGAnimationPushVC.m
//  MGDemo
//
//  Created by ming on 16/7/8.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGAnimationPushVC.h"
#import "CustomAnimateTransitionPop.h"
#import "MGAnimationVC.h"

@interface MGAnimationPushVC ()<UINavigationControllerDelegate>

@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation MGAnimationPushVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置图片
    [self setImage];
    
    // 给view添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
}


/**
 *  设置图片
 */
- (void)setImage{
    // 1.设置图片
    UIImageView * backImageView = [[UIImageView alloc] initWithImage:self.myImage];
    backImageView.frame = self.view.bounds;
    [self.view addSubview:backImageView];
    self.backImageView = backImageView;
    [self.view bringSubviewToFront:self.backImageView];
    self.backImageView.userInteractionEnabled = YES;
    
    // 2.添加双击手势
    /// 点按
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.backImageView addGestureRecognizer:tap];
    
    /// 长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.backImageView addGestureRecognizer:longPress];
    
    /// 捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.backImageView addGestureRecognizer:pinch];
    
    /// 旋转
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.backImageView addGestureRecognizer:rotate];
}
/// 点按
- (void)tap:(UITapGestureRecognizer *)tap{
    [self.interactiveTransition updateInteractiveTransition:0.9];
    [self.interactiveTransition finishInteractiveTransition];
    [self.navigationController popViewControllerAnimated:YES];
}
/// 长按
- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    [self.navigationController popViewControllerAnimated:YES];
}
/// 旋转
- (void)rotation:(UIRotationGestureRecognizer *)rotate
{
    self.backImageView.transform = CGAffineTransformRotate(self.backImageView.transform, rotate.rotation);
    // 复位
    [rotate setRotation:0];
}
/// 捏合
- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    self.backImageView.transform = CGAffineTransformScale(self.backImageView.transform, pinch.scale, pinch.scale);
    
    // 复位
    [pinch setScale:1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate=self;
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    /*调用UIPercentDrivenInteractiveTransition的updateInteractiveTransition:方法可以控制转场动画进行到哪了，
     当用户的下拉手势完成时，调用finishInteractiveTransition或者cancelInteractiveTransition，UIKit会自动执行剩下的一半动画，
     或者让动画回到最开始的状态。*/
    if([gestureRecognizer translationInView:self.view].x >= 0)
    {
        //手势滑动的比例
        CGFloat per = [gestureRecognizer translationInView:self.view].x / (self.view.bounds.size.width);
        per = MIN(1.0,(MAX(0.0, per)));
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            
            self.interactiveTransition=[UIPercentDrivenInteractiveTransition new];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            if([gestureRecognizer translationInView:self.view].x ==0)
            {
                [self.interactiveTransition updateInteractiveTransition:0.01];
            }
            else
            {
                [self.interactiveTransition updateInteractiveTransition:per];
            }
        }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled){
            
            if([gestureRecognizer translationInView:self.view].x == 0)
            {
                [self.interactiveTransition cancelInteractiveTransition];
                self.interactiveTransition = nil;
            }
            else if (per > 0.3) {
                [self.interactiveTransition finishInteractiveTransition];
            }else{
                [self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
        }
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        [self.interactiveTransition updateInteractiveTransition:0.01];
        [self.interactiveTransition cancelInteractiveTransition];
    }else if ((gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled))
    {
        self.interactiveTransition = nil;
    }
}

//为这个动画添加用户交互
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return self.interactiveTransition;
}
//用来自定义转场动画
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        CustomAnimateTransitionPop *pingInvert = [CustomAnimateTransitionPop new];
        return pingInvert;
    }else{
        return nil;
    }
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
