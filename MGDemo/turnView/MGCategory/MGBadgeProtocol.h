//
//  MGBadgeProtocol.h
//  MGDemo
//
//  Created by newunion on 2019/4/10.
//  Copyright © 2019 ming. All rights reserved.
//

#ifndef MGBadgeProtocol_h
#define MGBadgeProtocol_h

/**
 priority: number > custom view > red dot
 */

@protocol MGBadgeProtocol <NSObject>

@required

@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIFont  *badgeFont;      // default bold size 9
@property (nonatomic, strong) UIColor *badgeTextColor; // default white color
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, assign) CGFloat  badgeRadius;    // for red dot mode
@property (nonatomic, assign) CGPoint  badgeOffset;    // offset from right-top

- (void)showBadge; // badge with red dot
- (void)hideBadge;

// badge with number, pass zero to hide badge
- (void)showBadgeWithValue:(NSUInteger)value;

@optional

@property (nonatomic, strong) UIView  *badgeCustomView;
/**
 convenient interface:
 create 'cusomView' (UIImageView) using badgeImage
 view's size would simply be set as half of image.
 */
@property (nonatomic, strong) UIImage *badgeImage;

@end


#endif /* MGBadgeProtocol_h */
