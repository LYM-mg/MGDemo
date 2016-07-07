//
//  MGSectionModel.h
//  turnView
//
//  Created by ming on 16/6/13.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSectionModel : NSObject
/** 头部标题 */
@property (nonatomic, copy) NSString *sectionTitle;
/**  是否是展开的 */
@property (nonatomic, assign) BOOL isExpanded;
/** 分区下面可以有很多个cell对应的模型 */
@property (nonatomic, strong) NSMutableArray *cellModels;
@end
