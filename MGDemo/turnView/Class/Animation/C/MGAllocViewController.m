//
//  MGAllocViewController.m
//  MGDemo
//
//  Created by newunion on 2019/4/9.
//  Copyright © 2019 ming. All rights reserved.
//

#import "MGAllocViewController.h"
#import <malloc/malloc.h>

@interface MGPeople: NSObject
{
    int _age;
}
/**   */
/** <#注释#>  */
@property (assign,nonatomic) int weight;
@end

@implementation MGPeople

@end


@interface MGCat: MGPeople
@property (assign,nonatomic) int height;
@end

@implementation MGCat

@end


@interface MGAllocViewController ()

@end

@implementation MGAllocViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    MGPeople *people = [MGPeople new];
    class_getInstanceSize([MGPeople class]);

    MGCat *cat = [MGCat new];
    class_getInstanceSize([MGCat class]);

    NSLog(@"MGPeople=%zd",class_getInstanceSize([MGPeople class]));
    NSLog(@"MGPeople=%zd",malloc_size((__bridge const void *)people));
    NSLog(@"MGCat=%zd",class_getInstanceSize([MGCat class]));
    NSLog(@"MGCat=%zd",malloc_size((__bridge const void *)cat));
}
@end



