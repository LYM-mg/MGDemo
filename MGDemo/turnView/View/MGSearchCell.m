//
//  MGSearchCell.m
//  MGDemo
//
//  Created by ming on 16/6/21.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGSearchCell.h"

@implementation MGSearchCell

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                // 可以修改TableView多选状态下选中状态的图片
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"12.png"];
                    }
                }
            }
        }
    }
}

@end
