//
//  MGPolygonView.m
//  MGDemo
//
//  Created by ming on 16/7/7.
//  Copyright © 2016年 ming. All rights reserved.
//

#import "MGPolygonView.h"

@interface MGPolygonView ()
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;
@property (nonatomic, strong)UIBezierPath * path1;
/** 渐变背景视图 */
@property (nonatomic, strong) UIView *gradientBackgroundView;
/** 渐变图层 */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
/** 颜色数组 */
@property (nonatomic, strong) NSMutableArray *gradientLayerColors;

@end

@implementation MGPolygonView
static CGFloat bounceX = 20;
static CGFloat bounceY = 20;
static NSInteger countq = 0;

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        // 1.创建XY轴的数据
        [self createLabelXY];
        
        // 2.添加背景渐变层
        [self drawGradientBackgroundView];
        
        // 3.添加虚线
        [self createDashLine];
        
        // 4.画折线图
        [self drawLine];
    }
    return self;
}

/**
 *  画出坐标轴
 */
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetRGBFillColor(context, 1.0, 0, 0, 1.0);
    CGContextMoveToPoint(context, bounceX, bounceY);
    CGContextAddLineToPoint(context, bounceX, rect.size.height - bounceY);
    CGContextAddLineToPoint(context, rect.size.width -  bounceX, rect.size.height - bounceY);
    CGContextStrokePath(context);
}

#pragma mark 画折线图
- (void)drawLine{
    /// 1.根据横坐标上面的label 获取直线关键点的x 值
    UILabel * label = (UILabel*)[self viewWithTag:100];
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    
    /// 2.颜色
    UIColor * color = [UIColor greenColor];
    [color set];
    // 随机产生起点（真正开发时这些点的话外界网络数据请求会有数组传进来）
    [path moveToPoint:CGPointMake( label.centerX - bounceX, (600 - arc4random()%600)/600.0 * (self.frame.size.height - bounceY*2))];
    
    /// 3.创建折现点标记
    for (NSInteger i = 1; i< 12; i++) {
        UILabel * label1 = (UILabel*)[self viewWithTag:100 + i];
        CGFloat  arc = arc4random()%600;  //折线点目前给的是随机数
        [path addLineToPoint:CGPointMake(label1.centerX - bounceX,  (600 -arc) /600.0 * (self.frame.size.height - bounceY*2 ) )];
        UILabel * falglabel = [[UILabel alloc]initWithFrame:CGRectMake(label1.centerX , (600 -arc) /600.0 * (self.frame.size.height - bounceY*2 )+ bounceY  , 20, 15)];
        falglabel.tag = 300+ i;
        falglabel.text = [NSString stringWithFormat:@"%.1f",arc];
        falglabel.font = [UIFont systemFontOfSize:8.0];
        [self addSubview:falglabel];
    }
    
    /// 4.lineChartLayer
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = [UIColor brownColor].CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
//    self.lineChartLayer.lineWidth = 0;
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    // 直接添加导视图上
    [self.gradientBackgroundView.layer addSublayer:self.lineChartLayer];
    
    /// 5.添加动画效果
    self.lineChartLayer.lineWidth = 2;
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    // 设置动画代理，动画结束时添加一个标签，显示折线终点的信息
    pathAnimation.delegate = self;
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    //[self setNeedsDisplay];
}

#pragma mark - 添加虚线
- (void)createDashLine{
    // 1.添加横向虚线
    for (int i = 0; i < 12; i++) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor whiteColor].CGColor;
//        dashLayer.fillColor = [[UIColor clearColor] CGColor];
        dashLayer.lineWidth = 1.0; // 默认设置路径宽度为0，使其在起始状态下不显示
        
        // 获取Y轴的Label
        UILabel * yLabel = (UILabel*)[self viewWithTag:200 + i];
        
        // 贝瑟尔
        UIBezierPath * path = [[UIBezierPath alloc] init];
        path.lineWidth = 1.0;
//        UIColor * color = [UIColor blueColor];
//        [color setStroke];
        
        [path moveToPoint:CGPointMake( 0, yLabel.centerY - bounceY)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - 2*bounceX,yLabel.centerY - bounceY)];
        
        CGFloat dash[] = {10,10};
        /**
         *  pattern: 模式（C风格的数组，包含浮点值的长度（测量点）图中线段和差距。数组中的值替换，从第一行段长度开始，其次是第一个间隙长度，其次是第二线段的长度，等等。）
         *  count: 计数（模式中的值的数量）
         *  phase: 阶段（在该偏移量开始绘制模式，测量点沿虚线模式。例如，一个模式5-2-3-2 6相值会导致图在第一间隙中开始。）
         */
        [path setLineDash:dash count:2 phase:10];
        [path stroke];
        dashLayer.path = path.CGPath;
        [self.gradientBackgroundView.layer addSublayer:dashLayer];
    }
    
    // 2.0添加纵向虚线
    for (int i = 0; i < 12; i++) {
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor whiteColor].CGColor;
        dashLayer.lineWidth = 1.0; // 默认设置路径宽度为0，使其在起始状态下不显示
        
        // 获取Y轴的Label
        UILabel * XLabel = (UILabel*)[self viewWithTag:100 + i];
        
        // 贝瑟尔
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
//        UIColor * color = [UIColor blueColor];
//        [color setStroke];
        
        [path moveToPoint:CGPointMake( XLabel.centerX - bounceX, 0)];
        [path addLineToPoint:CGPointMake(XLabel.centerX - bounceY,self.frame.size.height - 2*bounceY)];
        CGFloat dash[] = {10,10};
        [path setLineDash:dash count:2 phase:10];
        [path stroke];
        dashLayer.path = path.CGPath;
        [self.gradientBackgroundView.layer addSublayer:dashLayer];
    }
}

#pragma mark - 添加背景渐变层(渐变的颜色)
- (void)drawGradientBackgroundView{
    // 1.渐变背景视图
    self.gradientBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(bounceX, bounceY, self.bounds.size.width - bounceX*2, self.bounds.size.height - 2*bounceY)];
    [self addSubview:self.gradientBackgroundView];
    
    // 2.创建并设置渐变背景图层
    //初始化CAGradientlayer对象，使它的大小为渐变背景视图的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.gradientBackgroundView.bounds;
    
    // 3.设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
    self.gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    self.gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    
    // 4.设置颜色的渐变过程
    self.gradientLayerColors = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:252/255.0 green:168/255.0 blue:9/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:252/255.0 green:178/255.0 blue:17/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:252/255.0 green:185 / 255.0 blue:17/255.0 alpha:1.0].CGColor]];
    self.gradientLayer.colors = self.gradientLayerColors;
    
    // 5.将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.gradientBackgroundView.layer addSublayer:self.gradientLayer];
}

#pragma mark - 创建XY轴的数据
- (void)createLabelXY{
    /// 1.创建X轴的数据
    CGFloat  month = 12;
    for (NSInteger i = 0; i < month; i++) {
        UILabel * LabelMonth = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 2*bounceX)/month * i + bounceX, self.frame.size.height - bounceY + bounceY*0.3 + bounceX, (self.frame.size.width - 2*bounceX)/month - 5, bounceY/2)];
        LabelMonth.backgroundColor = [UIColor redColor];
        LabelMonth.tag = 100 + i;
        LabelMonth.text = [NSString stringWithFormat:@"%ld月",i+1];
        LabelMonth.font = [UIFont systemFontOfSize:10];
        LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
        [self addSubview:LabelMonth];
    }
    
    /// 2.创建Y轴的数据
    CGFloat Ydivision = 12;
    for (NSInteger i = 0; i < Ydivision; i++) {
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height - 2 * bounceY)/Ydivision *i + bounceX, bounceY, bounceY/1.5)];
//        [labelYdivision sizeToFit];
        labelYdivision.backgroundColor = [UIColor greenColor];
        labelYdivision.tag = 200 + i;
        labelYdivision.text = [NSString stringWithFormat:@"%.0f",(Ydivision - i)*100];
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
    }
}

#pragma mark 点击重新绘制折线和背景
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    countq++;
    if (countq%2 == 1) {
        [self.lineChartLayer removeFromSuperlayer];
        for (NSInteger i = 0; i < 12; i++) {
            UILabel * label = (UILabel*)[self viewWithTag:300 + i];
            [label removeFromSuperview];
        }
    }else{
        [self drawLine];
    }
}
- (void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始®");
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"停止~~~~~~~~");
}

@end
