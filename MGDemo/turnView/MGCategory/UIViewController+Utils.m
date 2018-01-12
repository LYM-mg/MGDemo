//
//  UIViewController+Utils.m
//  SwiftLive
//
//  Created by Victor on 16/6/12.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)
+ (UIViewController *)findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
    }
    
}

+ (UIViewController *)backToRealRootController:(UIViewController *)viewController {
    if (viewController.presentingViewController != nil) {
       
        UIViewController *parentVC = viewController.parentViewController;
        [viewController dismissViewControllerAnimated:NO completion:nil];
        return [UIViewController backToRealRootController:parentVC];
        
    } else if (viewController.parentViewController != nil) {
        
        if ([viewController.parentViewController isKindOfClass:[UINavigationController class]]) {
          
            UINavigationController *parentVC = (UINavigationController *)viewController.parentViewController;
            [parentVC popToRootViewControllerAnimated:NO];
            return [UIViewController backToRealRootController:parentVC];
            
        } else if ([viewController.parentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tabVC = (UITabBarController *)viewController.parentViewController;
            return tabVC;
            
        } else {
            
            return viewController.parentViewController;
            
        }
        
    } else {
        
        return viewController;
        
    }
}

+ (UIViewController *)currentVC {
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}
@end
