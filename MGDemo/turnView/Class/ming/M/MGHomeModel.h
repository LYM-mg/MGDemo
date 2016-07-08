//
//  MGHomeModel.h
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGHomeModel : NSObject
/** 颜色 */
@property (nonatomic, copy) NSString *color;

/** 名字 */
@property (nonatomic, copy) NSString *tag_name;

/** 精选个数 */
@property (nonatomic, copy) NSString *section_count;

/** 数组  */
@property (nonatomic, strong) NSArray *body;

/**
 *  快速字典转模型
 */
+ (instancetype)homeWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
