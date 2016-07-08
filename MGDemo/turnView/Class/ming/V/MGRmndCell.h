//
//  MGRmndCell.h
//  MGHuntForCity
//
//  Created by MacBook on 15/7/2.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGBodyModel;

@interface MGRmndCell : UITableViewCell

/** cell的模型 */
@property (nonatomic, strong) MGBodyModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(MGBodyModel *)model;

@end
