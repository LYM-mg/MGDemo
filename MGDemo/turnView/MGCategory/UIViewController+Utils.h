//
//  UIViewController+Utils.h
//  SwiftLive
//
//  Created by Victor on 16/6/12.
//  Copyright © 2016年 DotC_United. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)
+ (UIViewController *)currentVC;
+ (UIViewController *)backToRealRootController:(UIViewController *)viewController;
@end
