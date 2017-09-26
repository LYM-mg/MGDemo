//  MGHFlowLayout.m
//  MGDemo
//  Created by i-Techsys.com on 2017/9/26.
//  Copyright © 2017年 ming. All rights reserved.
// https://github.com/LYM-mg
// http://www.jianshu.com/u/57b58a39b70e

#import "MGHFlowLayout.h"

/** 默认的列数 */
static const NSInteger MGDefaultColumnCount = 4;
/** 默认每一列之间的间距 */
static const CGFloat MGDefaultColumnMargin = 0;
/** 每一行之间的间距 */
static const CGFloat MGDefaultRowMargin = 0;
/** 默认边缘间距 */
static const UIEdgeInsets MGDefaultEdgeInsets = {0, 0, 0, 0};

@interface MGHFlowLayout ()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;

/** 每一行之间的间距 */
- (CGFloat)rowMargin;
/** 每一列之间的间距 */
- (CGFloat)columnMargin;
/** 列数 */
- (NSInteger)columnCount;
/** 边缘间距 */
- (UIEdgeInsets)edgeInsets;

@end

@implementation MGHFlowLayout

#pragma mark - 常见数据处理
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return MGDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return MGDefaultColumnMargin;
    }
}

- (NSInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)]) {
        return [self.delegate columnCountInWaterflowLayout:self];
    } else {
        return MGDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return MGDefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)columnHeights{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

#pragma mark --  UICollectionViewLayout
-(void)prepareLayout{
    self.collectionView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    // 1.获取cell的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    
    // 2.遍历cell，把每一个布局添加到数组
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }    
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat x,y,w,h;
    
    w = (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    h = (indexPath.item % 7  == 0) ? w*2 : w;

    
    // 取得所有列中高度最短的列
    NSInteger minHeightColumn = [self minHeightColumn];
    
    x = self.edgeInsets.left + minHeightColumn * (w + self.rowMargin);
    
    y = MGDefaultEdgeInsets.top + [self.columnHeights[minHeightColumn] floatValue] + self.columnMargin;

#warning 更改最短的一列
    [self.columnHeights replaceObjectAtIndex:minHeightColumn withObject:@(y+h)];
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    return attrs;
}


/**
 * 决定cell的排布
 * 第一次显示时会调用一次
 * 用力拖拽时也会调一次
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}


-(CGSize)collectionViewContentSize{
    CGSize size = self.collectionView.bounds.size;
    
    return size;
}

/// 取得所有列中高度最短的列
- (NSInteger)minHeightColumn{
    // 找出columnHeights的最小值
    NSInteger minHeightColum = 0;
    if (self.columnHeights ==  nil || self.columnHeights.count == 0) { return 0; }
    CGFloat minColumHeight = [self.columnHeights[0] floatValue];
    
    for (NSInteger i = 1; i < self.columnHeights.count; i++) {
        CGFloat tempHeight = [self.columnHeights[i] floatValue];
        
        if (tempHeight < minColumHeight) {
            minHeightColum = i;
            minColumHeight = tempHeight;
        }
    }
    return minHeightColum;
}

@end
