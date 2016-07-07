//
//  MGPolygonView.h
//  MGDemo
//
//  Created by ming on 16/7/7.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPolygonView : UIView
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;
/** 数据数组 */
@property (nonatomic,strong)NSArray * dataArray;
/** 画折线图 */
- (void)drawLine;
@end
