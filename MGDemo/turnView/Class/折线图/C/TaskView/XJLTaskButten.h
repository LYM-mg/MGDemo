//
//  XJLTaskButten.h
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/22.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XJLTaskCompleteType) {
    XJLTaskUnComplete = 0,
    XJLTaskUnReceive = 1,
    XJLTaskReceived = 2
};

@interface XJLTaskButten : UIButton

@property (nonatomic, assign) XJLTaskCompleteType type;

- (instancetype)initWithType:(XJLTaskCompleteType)type;

@end
