//
//  MGGIFViewController.m
//  MGDemo
//
//  Created by newunion on 2018/1/12.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGGIFViewController.h"
#import "LLGifView.h"
#import "LLGifImageView.h"

@interface MGGIFViewController ()

@property (nonatomic, strong) LLGifView *gifView;
@property (nonatomic, strong) LLGifImageView *gifImageView;

@end

@implementation MGGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpSubView];
    [self navgation];
}

- (void)setUpSubView {
    UIButton *btn1 = [UIButton new];
    [btn1 setBackgroundColor:[UIColor randomColor]];
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents: UIControlEventTouchUpInside];
    [btn1 setTitle:@"本地gif" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setBackgroundColor:[UIColor randomColor]];
    [btn2 addTarget:self action:@selector(btn2:) forControlEvents: UIControlEventTouchUpInside];
    [btn2 setTitle:@"本地gif" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton new];
    [btn3 setBackgroundColor:[UIColor randomColor]];
    [btn3 addTarget:self action:@selector(btn3:) forControlEvents: UIControlEventTouchUpInside];
    [btn3 setTitle:@"网络gif" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view).offset(100);
        make.left.mas_equalTo(self.view).offset(64);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn1);
        make.top.mas_equalTo(btn1.mas_bottom).offset(50);
        make.height.width.mas_equalTo(btn1);
    }];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn2);
        make.top.mas_equalTo(btn2.mas_bottom).offset(50);
       make.height.width.mas_equalTo(btn1);
    }];
}

//方式一：显示本地Gif图片(将图片转为NSData数据)
- (void)btn1:(UIButton *)sender {
    [self removeGif];
    
    //方法1:适用于帧数少的gif动画
//    NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"example" ofType:@"gif"]];
//    _gifView = [[LLGifView alloc] initWithFrame:CGRectMake(10, 80, MGSCREEN_WIDTH, 400) data:localData];
//    [self.view addSubview:_gifView];
//    [_gifView startGif];
    
    //方法2:适用于帧数多的gif动画
    NSData *localData1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"plane" ofType:@"gif"]];
    // CGRectMake(100, 400, 100, 200)
    _gifImageView = [[LLGifImageView alloc] initWithFrame:CGRectMake(0, 200, MGSCREEN_WIDTH, 400) data:localData1];
    [self.view addSubview:_gifImageView];
    [_gifImageView startGifLoopCount:3];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _gifImageView.gifEndBlock = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.gifImageView removeFromSuperview];
                weakSelf.gifImageView = nil;
            });
        };
    });
    
}

//方式二：显示本地Gif图片(得到图片的路径)
- (void)btn2:(UIButton *)sender {
    [self removeGif];
    
    //方法1:适用于帧数少的gif动画
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plane" ofType:@"gif"];
    _gifView = [[LLGifView alloc] initWithFrame:CGRectMake(0, 200, MGSCREEN_WIDTH, 400) filePath:filePath];
    [self.view addSubview:_gifView];
    [_gifView startGif];
    
    //方法2:适用于帧数多的gif动画
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"gif"];
    //    _gifImageView = [[LLGifImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 80) filePath:filePath];
    //    [self.view addSubview:_gifImageView];
    //    [_gifImageView startGif];
}

//方式三：显示从网络获取的Gif图片
- (void)btn3:(UIButton *)sender {
    [self removeGif];
    //此处使用异步加载
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *urlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pic19.nipic.com/20120222/8072717_124734762000_2.gif"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (urlData) {
                _gifView = [[LLGifView alloc] initWithFrame:CGRectMake(100, 300, 200, 80) data:urlData];
                [self.view addSubview:_gifView];
                [_gifView startGif];
            }
            else {
                NSLog(@"请允许应用访问网络");
            }
        });
    });
}

- (void)removeGif {
    if (_gifView) {
        [_gifView removeFromSuperview];
        _gifView = nil;
    }
    if (_gifImageView) {
        [_gifImageView removeFromSuperview];
        _gifImageView = nil;
    }
}

- (void)navgation {
    [UIImage imageWithContentsOfFile:@"lol"];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"减小内存" style:UIBarButtonItemStylePlain target:self action:@selector(lessClick)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"系统加载1" style:UIBarButtonItemStylePlain target:self action:@selector(system1Click)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"系统加载2" style:UIBarButtonItemStylePlain target:self action:@selector(system2Click)];
    self.navigationItem.rightBarButtonItems = @[item1,item2,item3];
}

// 导航栏右边1的点击
- (void)lessClick{
    for (int i = 0; i< 100; i++) {
        UIImage *image = UIImageMainbundleMake(@"晴60x60");
        UIImageView *imageV = [[UIImageView alloc] initWithImage: image];
        imageV.center = self.view.center;
        [self.view addSubview:imageV];
    }
}

// 导航栏右边2的点击
- (void)system1Click{
    for (int i = 0; i< 100; i++) {
        UIImage *image = [UIImage imageNamed:@"lol"];
       
        UIImageView *imageV = [[UIImageView alloc] initWithImage: image];
        imageV.center = self.view.center;

        [self.view addSubview:imageV];
    }
}

// 导航栏右边3的点击
- (void)system2Click{
    for (int i = 0; i< 100; i++) {
        
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"晴60x60" ofType:@"png"]];
        UIImageView *imageV = [[UIImageView alloc] initWithImage: image];
        imageV.center = self.view.center;
        [self.view addSubview:imageV];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
}

@end
