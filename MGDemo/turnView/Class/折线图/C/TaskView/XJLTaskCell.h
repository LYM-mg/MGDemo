//
//  XJLTaskCell.h
//  SwiftLive
//
//  Created by Zhaimi on 2018/1/19.
//  Copyright © 2018年 DotC_United. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJLTaskButten.h"

@interface XJLTaskCell : UITableViewCell

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) XJLTaskButten *receiveBtn;
@property (nonatomic, assign) XJLTaskCompleteType type;

//- (instancetype)initWithType:(XJLTaskCompleteType)type;

@end
