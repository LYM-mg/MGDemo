//
//  CustomAnimateTransitionPop.h
//  animateTransition
//
//  Created by ming on 16/6/26.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomAnimateTransitionPop : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,strong)id<UIViewControllerContextTransitioning>transitionContext;
@end
