//
//  MGHeaderReusableView.m
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGHeaderReusableView.h"
#import "MGHomeModel.h"
@interface MGHeaderReusableView ()
/** 名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 数量 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation MGHeaderReusableView

+ (instancetype)headViewWith:(MGHomeModel *)headModel
{
    MGHeaderReusableView *headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
    headView.homeModel = headModel;
    
    return headView;
}

- (void)awakeFromNib {


}

/** 赋值 */
- (void)setHomeModel:(MGHomeModel *)homeModel
{
    _homeModel = homeModel;

    self.nameLabel.text = homeModel.tag_name;
    self.countLabel.text = homeModel.section_count;
    
    self.backgroundColor = [UIColor colorWithHexString:homeModel.color];
//    self.backgroundColor = MGRandomColor;
}

/** 点击头部视图的跳转 */
- (IBAction)clickHeader:(UIButton *)sender {
    
    MGLogFunc;
}

@end
