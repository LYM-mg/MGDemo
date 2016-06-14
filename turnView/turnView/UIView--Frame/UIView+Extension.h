//
//  UIView+Extension.h
//  farmlink
//
//  Created by 赵小嘎 on 15/11/9.
//  Copyright © 2015年 farmlink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property(nonatomic,assign) CGPoint orgin;
@property (nonatomic, assign) CGSize size;

- (NSString *)getNametag ;
- (void)setNametag:(NSString *)theNametag;

-(UIView *)viewNamed:(NSString *)aName;
@end
