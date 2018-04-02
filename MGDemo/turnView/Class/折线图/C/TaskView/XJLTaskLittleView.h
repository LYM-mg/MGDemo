//
//  XJLTaskLittleView.h
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJLTaskButten.h"


@interface XJLTaskLittleView : UIView

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *ruleLabel;
@property (nonatomic, strong) XJLTaskButten *receiveBtn;

- (instancetype)initWithType:(XJLTaskCompleteType)type;

@end
