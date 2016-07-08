//
//  MGBodyCell.m
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGBodyCell.h"
#import "MGBodyModel.h"

@interface MGBodyCell ()
/** 背景imageView */
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

/** 名字按钮 */
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;

/** 总数按钮 */
@property (weak, nonatomic) IBOutlet UIButton *countBtn;

/** 标题Label */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation MGBodyCell

- (void)awakeFromNib {
    self.backgroundColor = MGrandomColor;
}

- (void)setBodyModel:(MGBodyModel *)bodyModel
{
    _bodyModel = bodyModel;
    self.titleLabel.text = bodyModel.section_title;
    [self.nameBtn setTitle:bodyModel.poi_name forState:UIControlStateNormal];
    [self.countBtn setTitle:bodyModel.fav_count forState:UIControlStateNormal];
    
    NSURL *url = [NSURL URLWithString:bodyModel.imageURL];
    [self.imageV sd_setImageWithURL:url];
}


@end
