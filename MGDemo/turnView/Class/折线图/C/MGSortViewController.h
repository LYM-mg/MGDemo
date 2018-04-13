//
//  MGSortViewController.h
//  MGDemo
//
//  Created by newunion on 2018/4/13.
//  Copyright © 2018年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGSortViewController : UITableViewController

@end


@interface Person: NSObject
@property (copy,nonatomic) NSString *name;
@property (assign,nonatomic) float score;
@property (assign,nonatomic) int age;
@property (assign,nonatomic) double height;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age score:(float)score;
@end
