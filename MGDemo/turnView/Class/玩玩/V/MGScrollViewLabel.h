//
//  MGScrollViewLabel.h
//  MGDemo
//
//  Created by i-Techsys.com on 2017/8/24.
//  Copyright © 2017年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum: NSUInteger {
//    Horizontal,
//    Vertical
//} MGDirection;

typedef enum : NSUInteger {
    Vertical, // 0
    Horizontal, // 1
} MGDirection;

@interface MGScrollViewLabel: UIView
@property (nonatomic,assign) MGDirection direction;
@property (nonatomic,copy) NSString *scrollStr;
@end
