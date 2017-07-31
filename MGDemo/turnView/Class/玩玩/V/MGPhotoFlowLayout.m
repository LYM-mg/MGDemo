//
//  MGPhotoFlowLayout.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGPhotoFlowLayout.h"

#define LayoutHorizontal self.LayoutDirection == Horizontal
#define LayoutVertical   self.LayoutDirection == Vertical

/** 每一列之间的间距 */
static const CGFloat MGDefaultColumnMargin = 1;
/** 每一行之间的间距 */
static const CGFloat MGDefaultRowMargin = 1;

@interface MGPhotoFlowLayout()

@property (nonatomic,assign)NSUInteger columnsCount;
@property (nonatomic,strong)NSMutableArray *COLUMNSHEIGHTS;//保存所有列高度的数组
@property (nonatomic,strong)NSMutableArray *itemsAttributes;//保存所有列高度的数组

/** 每一行之间的间距 */
- (CGFloat)getRowMargin;
/** 每一列之间的间距 */
- (CGFloat)getColumnMargin;

@end

@implementation MGPhotoFlowLayout

#pragma mark - 常见数据处理
- (CGFloat)getRowMargin{
    if ([self.delegate respondsToSelector:@selector(rowMarginInPhotoFlowLayout:)]) {
        return [self.delegate rowMarginInPhotoFlowLayout:self];
    } else {
        return MGDefaultRowMargin;
    }
}

- (CGFloat)getColumnMargin{
    if ([self.delegate respondsToSelector:@selector(columnMarginInPhotoFlowLayout:)]) {
        return [self.delegate columnMarginInPhotoFlowLayout:self];
    } else {
        return MGDefaultColumnMargin;
    }
}

#pragma mark --  UICollectionViewLayout

-(void)prepareLayout{
    self.collectionView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //根据屏幕方向确定总共需要的列数
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft | orientation ==  UIDeviceOrientationLandscapeRight){
        self.columnsCount = self.ColOfLandscape;
    }else{
        self.columnsCount = self.ColOfPortrait;
    }
    
    //确定所有item的个数
    NSUInteger itemCounts = [[self collectionView]numberOfItemsInSection:0];
    //初始化保存所有item attributes的数组
    self.itemsAttributes = [NSMutableArray arrayWithCapacity:itemCounts];
    
    //根据列数确定存储列高度的数组容量，全部置0
    self.COLUMNSHEIGHTS = [NSMutableArray arrayWithCapacity:self.columnsCount];
    for (NSInteger i = 0; i<self.columnsCount; i++) {
        [self.COLUMNSHEIGHTS addObject:@(0)];
    }
    
    for (NSUInteger i = 0; i < itemCounts; i++) {
        //找到最短列
        NSUInteger shtIndex = [self findShortestColumn];
        
        //x -- 尽可能用整数
        NSUInteger origin_x = LayoutVertical ? (shtIndex * ([self columnWidth] + self.getColumnMargin)) + self.getColumnMargin : [self.COLUMNSHEIGHTS[shtIndex] integerValue] + self.getRowMargin;
        //y
        NSUInteger origin_y = LayoutVertical ? [self.COLUMNSHEIGHTS[shtIndex] integerValue] : shtIndex * [self columnWidth] + self.getColumnMargin;
        
        //width
        NSUInteger size_width = 0.0;
        NSUInteger randomOfWhetherDouble = arc4random() % 100;//随机数标记是否要双行
        
        //如果当前列不是最后一列 && 当前列高度和后一列高度相等 && 达到跨行阈值
        if (shtIndex < self.columnsCount - 1 && [self.COLUMNSHEIGHTS[shtIndex] floatValue] == [self.COLUMNSHEIGHTS[shtIndex+1] floatValue] && randomOfWhetherDouble < self.DoubleColumnThreshold) {
            
            size_width = 2*[self columnWidth];
        }else{
            size_width = [self columnWidth];
        }
        
        //height
        NSUInteger size_height = 0.0;
        CGFloat retVal;
        if (size_width == 2*[self columnWidth]) {
            float extraRandomHeight = arc4random() % 35;
            retVal = 0.75 + (extraRandomHeight / 100);
            
            size_height = size_width * retVal; // 高度为宽度的0.75~1.0倍
            size_height = size_height - (size_height % 40) + self.getRowMargin;
        }else{
            float extraRandomHeight = arc4random() % 50;
            retVal = 0.75 + (extraRandomHeight / 100);
            size_height = size_width * retVal; // 高度为宽度的0.75~1.25倍
            size_height = size_height - (size_height % 40) + self.getRowMargin;
        }
        
        
        //如果是Horizontal,宽高互换。最后别忘了刷新高度栈
        if (LayoutHorizontal) {
            NSUInteger temp = size_width;
            size_width = size_height;
            size_height = temp;
            
            if (size_height == 2*[self columnWidth]) {
                self.COLUMNSHEIGHTS[shtIndex] = @(origin_x + size_width + self.getRowMargin);
                self.COLUMNSHEIGHTS[shtIndex+1] = @(origin_x + size_width + self.getRowMargin);
            }else{
                self.COLUMNSHEIGHTS[shtIndex] = @(origin_x + size_width + self.getRowMargin);
            }
        }else{
            if (size_width == 2*[self columnWidth]) {
                self.COLUMNSHEIGHTS[shtIndex] = @(origin_y + size_height + self.getRowMargin);
                self.COLUMNSHEIGHTS[shtIndex+1] = @(origin_y + size_height + self.getRowMargin);
            }else{
                self.COLUMNSHEIGHTS[shtIndex] = @(origin_y + size_height + self.getRowMargin);
            }
        }
        
        //给attributes.frame 赋值，并存入 self.itemsAttributes
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(origin_x, origin_y, size_width, size_height);
        [self.itemsAttributes addObject:attributes];
    }
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.itemsAttributes;
}


-(CGSize)collectionViewContentSize{
    
    CGSize size = self.collectionView.bounds.size;
    NSUInteger longstIndex = [self findLongestColumn];
    float columnMax = [self.COLUMNSHEIGHTS[longstIndex] floatValue];
    if (LayoutVertical) {
        size.height = columnMax;
    }else{
        size.width  = columnMax;
    }
    
    return size;
}



#pragma mark -- private Method
//均分的宽度,注意：四舍五入成整数
- (float)columnWidth{
    return LayoutVertical ? roundf((self.collectionView.bounds.size.width - (self.columnsCount + 1)*self.getColumnMargin) / self.columnsCount) : roundf((self.collectionView.bounds.size.height - (self.columnsCount + 1)*self.getRowMargin) / self.columnsCount);
}

//寻找此时高度最短的列.第一列为0
-(NSUInteger)findShortestColumn{
    NSUInteger shortestIndex = 0;
    CGFloat shortestValue = MAXFLOAT;

    NSUInteger index=0;//游标
    for (NSNumber *columnHeight in self.COLUMNSHEIGHTS) {
        if ([columnHeight floatValue] < shortestValue) {
            shortestValue = [columnHeight floatValue];
            shortestIndex = index;
        }
        index++;
    }
    return shortestIndex;
}


//寻找此时高度最长的列.第一列为0
-(NSUInteger)findLongestColumn{
    NSUInteger longestIndex = 0;
    CGFloat longestValue = 0;
    
    NSUInteger index=0;//游标
    for (NSNumber *columnHeight in self.COLUMNSHEIGHTS) {
        if ([columnHeight floatValue] > longestValue) {
            longestValue = [columnHeight floatValue];
            longestIndex = index;
        }
        index++;
    }
    return longestIndex;
}

@end
