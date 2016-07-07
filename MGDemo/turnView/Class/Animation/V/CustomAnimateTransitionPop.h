//
//  CustomAnimateTransitionPop.h
//  animateTransition
//
//  Created by 战明 on 16/5/26.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CustomAnimateTransitionPop : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,strong)id<UIViewControllerContextTransitioning>transitionContext;
@end
