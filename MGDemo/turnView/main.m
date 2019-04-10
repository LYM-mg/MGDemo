//
//  main.m
//  turnView
//
//  Created by ming on 16/5/28.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        int a[5] = {1,2,3,4,5};
        int *b = (int *)(&a+1);
        printf("%d,%d ,%d,%d ,%d ",*(a+1),*(a+2),*b,*(b-1),*(b-2));
        

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
