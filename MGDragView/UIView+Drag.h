//
//  UIView+Drag.h
//  MGDemo
//
//  Created by i-Techsys.com on 2017/8/18.
//  Copyright © 2017年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Drag)

/**
 *  @author ming
 *
 *  是否允许拖拽，默认关闭（可以在XIB或SB中设置）
 */
@property (nonatomic,assign)IBInspectable BOOL mg_canDrag;
/**
 *  @author ming
 *
 *  是否需要边界弹簧效果，默认开启（可以在XIB或SB中设置）
 */
@property (nonatomic,assign)IBInspectable BOOL mg_bounces;
/**
 *  @author ming
 *
 *  是否需要吸附边界效果，默认开启（可以在XIB或SB中设置）
 */
@property (nonatomic,assign)IBInspectable BOOL mg_isAdsorb;

@end
