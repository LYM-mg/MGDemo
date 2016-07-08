//
//  MGHeaderReusableView.h
//  MGDemo
//
//  Created by ming on 16/7/9.
//  Copyright © 2016年 ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGHomeModel;
@interface MGHeaderReusableView : UICollectionReusableView

/** 头部模型属性  */
@property (nonatomic, strong) MGHomeModel *homeModel;

@end
