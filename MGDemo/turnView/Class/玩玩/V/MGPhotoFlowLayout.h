//
//  MGPhotoFlowLayout.h
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Vertical, // 0
    Horizontal, // 1
} MGPhotoLayoutDirection;


@class MGPhotoFlowLayout;

@protocol MGPhotoFlowLayoutDelegate <NSObject>

@optional
- (CGFloat)columnMarginInPhotoFlowLayout:(MGPhotoFlowLayout *)photoFlowLayout;
- (CGFloat)rowMarginInPhotoFlowLayout:(MGPhotoFlowLayout *)photoFlowLayout;

@end

IB_DESIGNABLE
@interface MGPhotoFlowLayout : UICollectionViewLayout

//** The number of column when device orientation is portrait
//** 设备竖直时候的列数
@property(nonatomic,assign)IBInspectable NSUInteger ColOfPortrait;

//** The number of column when device orientation is landscape
//** 设备水平时候的列数
@property(nonatomic,assign)IBInspectable NSUInteger ColOfLandscape;

//** The threshold of double-colume.It's between 0~100.eg,you set DoubleColumnThreshold to 40,it means you will have 40 percent possibility have a double-column-width/height column.
//** 横跨双列出现概率的阈值。比如你指定 DoubleColumnThreshold 为40，那么将会有40%的可能性出现双列宽度或高度的列。
@property(nonatomic,assign)IBInspectable NSUInteger DoubleColumnThreshold;

//** The scroll direction of layout
//** 布局的滚动方向
@property(nonatomic,assign)IBInspectable MGPhotoLayoutDirection LayoutDirection;

/** 代理 */
@property (nonatomic, weak) id<MGPhotoFlowLayoutDelegate> delegate;

@end
