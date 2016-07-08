//
//  MGHomeModel.m
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGHomeModel.h"
#import "MGBodyModel.h"

@implementation MGHomeModel
+ (instancetype)homeWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
//        self.tag_name = dict[@"tag_name"];
//        self.section_count  = dict[@"section_count"];
//        self.color = dict[@"color"];
        [self setValuesForKeysWithDictionary:dict];
        
        //字典数组转模型
        //保存模型的临时数组
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *dictArr = dict[@"body"];
        for (NSDictionary *dict in dictArr) {
            MGBodyModel *body = [MGBodyModel bodyWithDict:dict];
            [tempArray addObject:body];
        }
        self.body = tempArray;
    }
    return self;
}

@end
