//
//  MGWaterflowLayout.h
//  MGPuBuLiuDemo
//
//  Created by ming on 16/6/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MGWaterflowLayout;

@protocol MGWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(MGWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MGWaterflowLayout *)waterflowLayout;



- (CGSize)layoutCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end




@interface MGWaterflowLayout : UICollectionViewFlowLayout

/** 代理 */
@property (nonatomic, weak) id<MGWaterflowLayoutDelegate> delegate;

@end
