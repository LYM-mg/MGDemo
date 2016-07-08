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
    MGHomeModel *home = [[MGHomeModel alloc] init];
//    home.tag_name = dict[@"tag_name"];
//    home.section_count  = dict[@"section_count"];
//    home.color = dict[@"color"];
//    
//    //字典数组转模型
//    //保存模型的临时数组
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (NSDictionary *dict in dict[@"body"]) {
//        MGBodyModel *body = [MGBodyModel bodyWithDict:dict];
//        [tempArray addObject:body];
//    }
//    home.body = tempArray;
    [home setKeyValues:dict];
    
    return home;
}
@end
