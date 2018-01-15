//
//  MGMapViewController.m
//  MGDemo
//
//  Created by newunion on 2018/1/15.
//  Copyright © 2018年 ming. All rights reserved.
//

#import "MGMapViewController.h"
#import <MapKit/MapKit.h>

@interface MGMapViewController ()
@property (strong,nonatomic) NSMutableArray *mapArr;
@end

@implementation MGMapViewController

- (NSMutableArray *)mapArr  {
    if (!_mapArr) {
        _mapArr = [NSMutableArray array];
        [_mapArr addObject:@{}];
    }
    return _mapArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CLLocationCoordinate2D coordination = CLLocationCoordinate2DMake(31, 122);
    self.mapArr = [self getInstalledMapAppWithEndLocation:coordination];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
#pragma mark - 导航方法
- (NSMutableArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation
{
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=北京&mode=driving&coord_type=gcj02",endLocation.latitude,endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",endLocation.latitude,endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航测试",@"nav123456",endLocation.latitude, endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",endLocation.latitude, endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    return maps;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"可用地图导航" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0;i < self.mapArr.count;i++) {
        NSString *title = self.mapArr[i][@"title"];
        UIAlertAction *a1;
        if (i == 0)  {
            a1 = [UIAlertAction actionWithTitle:title style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MKPlacemark *endPlaceMark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(31, 122)];
                MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPlaceMark];
                endItem.name = @"苹果地图";
                
                NSNumber *number = [NSNumber numberWithBool:YES];
//                 MKLaunchOptionsShowsTrafficKey: number
                NSDictionary *dict = @{
                                       MKLaunchOptionsDirectionsModeKey:  MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey:number
                                     };
                [endItem openInMapsWithLaunchOptions:dict];
            }];
        }else {
            a1 = [UIAlertAction actionWithTitle:title style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:self.mapArr[i][@"url"]];
            }];
            
        }
       
    }
    [alertVc addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    NSString *str = @"10000000000";
    MGLog(@"修改前%@", str);
    str = [self getFormatNum:@"10000000000"];
    MGLog(@"修改后%@", str);
   
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (NSString *)getFormatNum:(NSString *)numbers {
    
    NSString *str = [numbers substringWithRange:NSMakeRange(numbers.length%3, numbers.length-numbers.length%3)];
    NSString *strs = [numbers substringWithRange:NSMakeRange(0, numbers.length%3)];
    for (int  i =0; i < str.length; i =i+3) {
        NSString *sss = [str substringWithRange:NSMakeRange(i, 3)];
        strs = [strs stringByAppendingString:[NSString stringWithFormat:@",%@",sss]];
    }
    if ([[strs substringWithRange:NSMakeRange(0, 1)] isEqualToString:@","]) {
        strs = [strs substringWithRange:NSMakeRange(1, strs.length-1)];
    }
    
    return strs;
}

@end
