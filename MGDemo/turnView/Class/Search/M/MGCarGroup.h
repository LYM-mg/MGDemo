//
//  MGCarGroup.h
//  MGDemo
//
//  Created by ming on 16/7/7.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGCarGroup : NSObject

/** 这组的标题 */
@property (nonatomic, copy) NSString *title;
/**  存放的所有的汽车品牌(里面装的都是MJCar模型) */
@property (nonatomic, strong) NSArray *cars;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
