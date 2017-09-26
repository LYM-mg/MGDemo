//
//  MGHFlowLayout.h
//  MGDemo
//
//  Created by i-Techsys.com on 2017/9/26.
//  Copyright © 2017年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGHFlowLayout;

@protocol MGHFlowLayoutDelegate <NSObject>
@optional
- (CGFloat)columnCountInWaterflowLayout:(MGHFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(MGHFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(MGHFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(MGHFlowLayout *)waterflowLayout;



- (CGSize)layoutCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)layout
        sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface MGHFlowLayout : UICollectionViewFlowLayout
/** 代理 */
@property (nonatomic, weak) id<MGHFlowLayoutDelegate> delegate;
@end
