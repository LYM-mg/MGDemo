//
//  UIViewController+Extension.m
//  NewUnion
//
//  Created by Ming on 16/12/18.
//  Copyright © 2016年 NewUnion. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
+(UIViewController*) findBestViewController:(UIViewController*)vc {
    
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

+(UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
    
}

+ (UIViewController *)mg_currentViewController
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        }else if ([vc isKindOfClass:[UISplitViewController class]]) {
            vc = ((UISplitViewController*) vc).viewControllers.lastObject;
        }
    }
    
    return vc;
}

- (void)backToController:(NSString *)controllerName animated:(BOOL)animated{
    if (self.navigationController) {
        NSArray *childViewControllers = self.navigationController.childViewControllers;
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(controllerName)];
        }];
        NSArray *resluts = [childViewControllers filteredArrayUsingPredicate:predicate];
        [self.navigationController popToViewController:resluts.firstObject animated:animated];
    }
}

- (void)backToControllerClass:(Class)class animated:(BOOL)animated{
    if (self.navigationController) {
        NSArray *childViewControllers = self.navigationController.childViewControllers;
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:class];
        }];
        NSArray *resluts = [childViewControllers filteredArrayUsingPredicate:predicate];
        [self.navigationController popToViewController:resluts.firstObject animated:animated];
    }
}
@end
