//
//  MGRunTimeVC.m
//  MGDemo
//
//  Created by i-Techsys.com on 2017/7/29.
//  Copyright © 2017年 ming. All rights reserved.
//

#import "MGRunTimeVC.h"
#import "MGPhotoCollectionViewController.h"
#import "MGHeTableViewController.h"
#import "UIView+Drag.h"
#import "MGScrollViewLabel.h"
#import "MGScrollLabelView.h"
#import "MGHViewController.h"

@interface MGRunTimeVC ()<MGScrollLabelViewDelegate>
{
    MGScrollLabelView *scrollLabelView;
    MGScrollViewLabel *sl;
}

@property (nonatomic,weak)UIView *firstView;
@end

@implementation MGRunTimeVC

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"可移动的View";
    
    [self.view setBGImage:@"lol"];
    
    [self.view addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithActionBlock:^(id gesture) {
        if (sl)
            [sl pauseScolling];
    }]];
//    self.navigationController.navigationBar.mg_hideStatusBarBackgroungView = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"photo布局" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    
    __weakSelf;
    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,100, 100, 30)];
    tapLabel.text = @"点我啊";
    tapLabel.userInteractionEnabled = YES;
    [tapLabel addGestureRecognizer:[UITapGestureRecognizer mg_gestureRecognizerWithActionBlock:^(id gesture) {
        [weakSelf showHint:@"响应tap手势点击"];
        [weakSelf.navigationController pushViewController:[MGHeTableViewController new] animated:true ];
//        [weakSelf showDetailViewController:[MGHeTableViewController new] sender:nil];
    }]];
    [self.view addSubview:tapLabel];
    
    // 按钮测试
    UIButton *btn = [UIButton ButtonWithTitle:@"嘿嘿" actionBlock:^(id btn) {
        [weakSelf showHint:@"响应按钮事件的点击"];
         weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:[MGHViewController new] animated:true ];
    }];
    btn.origin = CGPointMake(220, 100);
    [self.view addSubview:btn];
    
    [self DragView];
    [self set];
}

- (void)DragView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    view.backgroundColor = [UIColor grayColor];
    view.mg_isAdsorb = NO;
    view.mg_bounces = YES;
    view.mg_canDrag = YES;
    self.firstView = view;
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [view addSubview:slider];
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    view1.center = self.view.center;
    NSLog(@"vc = %.2lf",view1.frame.origin.x);
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 70)];
    view2.backgroundColor = [UIColor redColor];
    
    view2.mg_canDrag = YES;
    view2.mg_bounces = NO;
    view2.mg_isAdsorb = YES;
    [view1 addSubview:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(250, 0, 40, 50)];
    view3.backgroundColor = [UIColor greenColor];
    view3.mg_canDrag = YES;
    view3.mg_bounces = YES;
    view3.mg_isAdsorb = YES;
    [view1 addSubview:view3];
}

- (void)tapClick {
     [self showHint:@"响应tap -- init 手势点击"];
}


- (void)rightClick {
    [self showViewController:[MGPhotoCollectionViewController new] sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
+ (void)load {
//    [self mg_SwitchMethod:self originalSelector:@selector(viewWillAppear:) swizzledSelector:@selector(mg_viewWillAppear)];
//    [self mg_SwitchMethod:self originalSelector:@selector(viewDidAppear:) swizzledSelector:@selector(__viewDidAppear)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (sl)
        [sl resumeScolling];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (sl)
        [sl pauseScolling];
//    self.navigationController.navigationBar.mg_hideStatusBarBackgroungView = YES;
}


- (void)mg_viewWillAppear {
    if (sl)
        [sl resumeScolling];
    NSLog(@"我是来替换viewWillAppear的");
}

- (void)__viewDidAppear {
     NSLog(@"我是来替换viewDidAppear的");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSString *num = @"1234";
//    NSLog(@"%014ld",(long)num.integerValue);
//    
//    NSString *num1 = @"1234512345123";
//    NSLog(@"%@", [NSString stringWithFormat:@"%014lld",num1.longLongValue]);
    NSArray *titles = @[@"哈哈",@"她好美好美😍",@"喜欢她",@"真的喜欢"];
    scrollLabelView.titleArray = titles;
    
    
    if (sl)
        [sl resumeScolling];
}

- (void)set {
    sl = [[MGScrollViewLabel alloc] initWithFrame:CGRectMake(20, 550, MGSCREEN_WIDTH-40, 40)];
    sl.scrollStr = @"  喜欢这首情思幽幽的曲子，仿佛多么遥远，在感叹着前世的情缘，又是那么柔软，在祈愿着来世的缠绵。《莲的心事》，你似琉璃一样的晶莹，柔柔地拨动我多情的心弦。我，莲的心事，有谁知？我，莲的矜持，又有谁懂？  ";
    sl.direction = Vertical;
    [self.view addSubview:sl];
    [sl beginScolling];
    
    NSArray *titles = @[@"有一个隔壁公司的人",@"她好美好美😍",@"从见到她的第一眼",@"便注定难以忘记"];
    
    scrollLabelView = [[MGScrollLabelView alloc] initWithFrame:CGRectMake(50,170, 250, 20)];
    scrollLabelView.backgroundColor = [UIColor whiteColor];
    scrollLabelView.delegate = self;
    scrollLabelView.titleArray = titles;
    //设置label的字体
    scrollLabelView.titleFont = [UIFont systemFontOfSize:15];
    //设置文字颜色
    scrollLabelView.titleColor = [UIColor redColor];
    //设置停留时间
    scrollLabelView.stayInterval = 3.f;
    //设置滚动动画时间
    scrollLabelView.animationDuration = 1.f;
    [self.view addSubview:scrollLabelView];
    //开始滚动
    [scrollLabelView beginScrolling];
}

- (void)scrollLabelView:(MGScrollLabelView *)scrollLabelView didClickAtIndex:(NSInteger)index
{
    NSLog(@"点击%zd",index);
}


@end
