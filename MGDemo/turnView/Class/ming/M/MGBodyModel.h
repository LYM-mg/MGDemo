//
//  MGBodyModel.h
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGBodyModel : NSObject
/** 每一行的标题 */
@property (nonatomic, copy) NSString *section_title;
/** 图片的URL */
@property (nonatomic, copy) NSString *imageURL;
/** 喜欢的个数 */
@property (nonatomic, copy) NSString *fav_count	;
/** 行内名称 */
@property (nonatomic, copy) NSString *poi_name;

/**
 *  快速字典转模型
 */
+ (instancetype)bodyWithDict:(NSDictionary *)dict;
@end
