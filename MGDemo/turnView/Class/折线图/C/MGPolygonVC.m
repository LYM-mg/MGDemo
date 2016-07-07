//
//  MGPolygonVC.m
//  MGDemo
//
//  Created by ming on 16/7/7.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGPolygonVC.h"
#import "MGPolygonView.h"

@interface MGPolygonVC ()
/** 绘制折线图的View */
@property (nonatomic,strong) MGPolygonView *drawView;
@end

@implementation MGPolygonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MGPolygonView *drawView = [[MGPolygonView alloc] initWithFrame:CGRectMake(10, 200, self.view.width - 20, 250)];
    [self.view addSubview:drawView];
    self.drawView = drawView;
    
    [self setCorrectBtn];
}

- (void)setCorrectBtn{
    /*
     * 指定了需要成为圆角的角。该参数是UIRectCorner类型的，可选的值有：
     * UIRectCornerTopLeft
     * UIRectCornerTopRight
     * UIRectCornerBottomLeft
     * UIRectCornerBottomRight
     * UIRectCornerAllCorners
     */
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.drawView.frame) + 30, self.view.width - 20, 50)];
    [btn setTitle:@"开始绘制折线图" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = btn.bounds;
    maskLayer.path = maskPath.CGPath;
    btn.layer.mask = maskLayer;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(startDrawLine) forControlEvents:UIControlEventTouchUpInside];
}
// 监听按钮点击操作
- (void)startDrawLine{
    [self.drawView.lineChartLayer removeFromSuperlayer];
    for (NSInteger i = 0; i < 12; i++) {
        UILabel * label = (UILabel*)[self.drawView viewWithTag:300 + i];
        [label removeFromSuperview];
    }

    [self.drawView drawLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
