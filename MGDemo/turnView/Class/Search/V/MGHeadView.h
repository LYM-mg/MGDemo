//
//  MGHeadView.h
//  turnView
//
//  Created by ming on 16/6/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 屏幕宽度 */
#define MGScreen_W [UIScreen mainScreen].bounds.size.width

@class MGSectionModel;

@interface MGHeadView : UITableViewHeaderFooterView
/** sertion模型 */
@property (nonatomic, strong) MGSectionModel *model;

/** 回调  */
@property (nonatomic, strong) void (^expandCallback)(BOOL isExpanded);
/** 回调  */
//@property (nonatomic, strong) void (^expandCallback)(MGSectionModel *model);
@end
