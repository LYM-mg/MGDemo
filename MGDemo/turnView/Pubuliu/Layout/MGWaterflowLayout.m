//
//  MGWaterflowLayout.m
//  MGPuBuLiuDemo
//
//  Created by ming on 16/6/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGWaterflowLayout.h"

/** 默认的列数 */
static const NSInteger MGDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat MGDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat MGDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets MGDefaultEdgeInsets = {10, 10, 10, 10};

@interface MGWaterflowLayout ()

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

@implementation MGWaterflowLayout

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
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}


- (void)prepareLayout{
    [super prepareLayout];
    
#warning 删除以前保存的高度
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



- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat x,y,w,h;
    
//    w = (self.collectionView.frame.size.width - [self edgeInsets].left - [self edgeInsets].right - ([self columnCount] - 1) * MGDefaultColumnMargin)/[self columnCount];
     w = (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    
    // 通过代理可以设置高度
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:heightForItemAtIndex:itemWidth:)]) {
        h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath itemWidth:w];
    }else{
        h = 70 + arc4random_uniform(100);
    }

    // 取得所有列中高度最短的列
    NSInteger minHeightColumn = [self minHeightColumn];

//    x = MGDefaultEdgeInsets.left + minHeightColumn * (w + MGDefaultColumnMargin);
    x = self.edgeInsets.left + minHeightColumn * (w + self.columnMargin);

    y = MGDefaultEdgeInsets.top + [self.columnHeights[minHeightColumn] floatValue];

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

/// 返回collectionView的滚动范围
- (CGSize)collectionViewContentSize{
    if (self.columnHeights.count == 0) {
        return CGSizeMake(0, 0);
    }
    
    // 获得最高的列
    NSInteger maxColum = [self maxHeightColumn];
    
    CGFloat height = [self.columnHeights[maxColum] floatValue] + MGDefaultEdgeInsets.bottom;
    CGFloat width = self.collectionView.frame.size.width;
    
    return CGSizeMake(width, height);
}

/// 取得所有列中高度最短的列
- (NSInteger)minHeightColumn{
    // 找出columnHeights的最小值
    NSInteger minHeightColum = 0;
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

/// 取得所有列中高度最高的列
- (NSInteger)maxHeightColumn{
    // 找出columnHeights的最小值
    NSInteger maxHeightColumn = 0;
    CGFloat maxColumnHeight = [self.columnHeights[0] floatValue];
    
    for (NSInteger i = 1; i < self.columnHeights.count; i++) {
        CGFloat tempHeight = [self.columnHeights[i] floatValue];
        
        if (tempHeight > maxColumnHeight) {
            maxHeightColumn = i;
            maxColumnHeight = tempHeight;
        }
    }
    return maxHeightColumn;
}




///** 
// *  在元素的Interactive Movement期间被调用
// *  它带有target（目标元素）和先前的cell的indexPaths（索引地址）
// */
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForInteractivelyMovingItems:(NSArray<NSIndexPath *> *)targetIndexPaths withTargetPosition:(CGPoint)targetPosition previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths previousPosition:(CGPoint)previousPosition{
//    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForInteractivelyMovingItems:targetIndexPaths withTargetPosition:targetPosition previousIndexPaths:previousIndexPaths previousPosition:previousPosition];
//    [self.collectionView moveItemAtIndexPath:previousIndexPaths[0] toIndexPath:targetIndexPaths[0]];
//    
//    [self.collectionView reloadData];
//    return context;
//}
//
///**
// *  这个与上一个函数类似，但它只在Interactive Movement结束后才调用
// *  它带有target（目标元素）和先前的cell的indexPaths（索引地址）
// */
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:(NSArray<NSIndexPath *> *)indexPaths previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths movementCancelled:(BOOL)movementCancelled{
//    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:indexPaths previousIndexPaths:previousIndexPaths movementCancelled:movementCancelled];
//    [self.collectionView moveItemAtIndexPath:previousIndexPaths[0] toIndexPath:indexPaths[0]];
//    return context;
//}

@end
