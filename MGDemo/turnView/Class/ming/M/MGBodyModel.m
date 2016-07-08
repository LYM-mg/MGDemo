//
//  MGBodyModel.m
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGBodyModel.h"

@implementation MGBodyModel

+ (instancetype)bodyWithDict:(NSDictionary *)dict
{
    MGBodyModel *body = [[MGBodyModel alloc] init];
//    body.poi_name = dict[@"poi_name"];
//    body.imageURL = dict[@"imageURL"];
//    body.section_title = dict[@"section_title"];
//    body.fav_count = dict[@"fav_count"];
    [body setKeyValues:dict];
    
    return body;
}

@end
