//
//  MGRmndCell.m
//  MGHuntForCity
//  github:    
//  项目讲解博客:
//  Created by MacBook on 15/7/2.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  推荐cell

#import "MGRmndCell.h"
#import "MGBodyModel.h"
#import "UIImageView+WebCache.h"

@interface MGRmndCell()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;

@end

@implementation MGRmndCell

- (void)awakeFromNib {
    self.backgroundColor = MGColor(51, 52, 53);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView model:(MGBodyModel *)model
{
    static NSString *ID = @"MGRmndCell";
    MGRmndCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MGRmndCell class]) owner:nil options:nil] lastObject];
    }
    
    [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"ming1"]];
    
    cell.nameLabel.text = model.section_title;
    cell.adressLabel.text = model.poi_name;
    cell.praiseLabel.text = model.fav_count;
    
    return cell;
}

@end
