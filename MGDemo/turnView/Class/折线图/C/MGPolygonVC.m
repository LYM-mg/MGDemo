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

@end

@implementation MGPolygonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MGPolygonView *drawView = [[MGPolygonView alloc] initWithFrame:CGRectMake(10, 200, self.view.width - 20, 250)];
    [self.view addSubview:drawView];
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
