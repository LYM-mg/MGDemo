//
//  MGShopCell.m
//  MGPuBuLiuDemo
//
//  Created by ming on 16/6/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGShopCell.h"
#import "MGShopModel.h"
#import "UIImageView+WebCache.h"

@interface MGShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation MGShopCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setShop:(MGShopModel *)shop
{
    _shop = shop;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = shop.price;
}

@end
