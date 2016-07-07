//
//  MGCar.h
//  MGDemo
//
//  Created by ming on 16/7/7.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGCar : NSObject

/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 名称 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)carWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
