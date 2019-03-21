//
//  UIView+SpeedCreat.h
//  Firestonelamp
//
//  Created by newunion on 2019/3/20.
//  Copyright © 2019年 firestonetmt. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - UILabel
@interface UILabel (SpeedCreat)
/// 初始化
+ (UILabel *)label;

/// 初始化设置
@property (nonatomic,copy,readonly) UILabel *(^mg_Config)(void);
/// 是否可用
@property (nonatomic,assign,readonly) UILabel *(^mg_Enabled)(BOOL value);
/// 是否允许交互
@property (nonatomic,assign,readonly) UILabel *(^mg_UserInteractionEnabled)(BOOL value);
/// 是否透明
@property (nonatomic,assign,readonly) UILabel *(^mg_Alpha)(CGFloat value);
/// 是否隐藏
@property (nonatomic,assign,readonly) UILabel *(^mg_Hidden)(BOOL value);
/// frame
@property (nonatomic,assign,readonly) UILabel *(^mg_Frame)(CGRect value);
/// 阴影偏移量
@property (nonatomic,assign,readonly) UILabel *(^mg_ShadowOffset)(CGSize value);
/// 字体
@property (nonatomic,strong,readonly) UILabel *(^mg_Font)(UIFont *value);
/// 字号
@property (nonatomic,assign,readonly) UILabel *(^mg_FontSize)(CGFloat value);
/// 文字颜色
@property (nonatomic,copy,readonly) UILabel *(^mg_TextColor)(UIColor *value);
/// 阴影文字颜色
@property (nonatomic,strong,readonly) UILabel *(^mg_ShadowColor)(UIColor *value);
/// 背景色
@property (nonatomic,strong,readonly) UILabel *(^mg_BackgroundColor)(UIColor *value);
/// 文本
@property (nonatomic,copy,readonly) UILabel *(^mg_Text)(NSString *value);
/// 行
@property (nonatomic,assign,readonly) UILabel *(^mg_NumberOfLines)(NSInteger value);
/// 对齐方式
@property (nonatomic,strong,readonly) UILabel *(^mg_TextAlignment)(NSTextAlignment value);
/// 断句方式
@property (nonatomic,assign,readonly) UILabel *(^mg_LineBreakMode)(NSLineBreakMode value);

/// 圆角 CGFloat
@property (nonatomic,assign,readonly) UILabel *(^mg_CornerRadius)(CGFloat value);
/// 加到父控件
@property (nonatomic,copy,readonly) UILabel *(^mg_AddTo)(UIView *value);
/// 完成block
@property (nonatomic,copy,readonly) UILabel *(^mg_Completed)(void(^value)(UILabel *));

@end


#pragma mark - UIButton
@interface UIButton (SpeedCreat)
/// 初始化custom按钮
+ (UIButton *)customButton;
/// 初始化system按钮
+ (UIButton *)systemButton;

/// 初始化设置
@property (nonatomic,copy,readonly) UIButton *(^mg_Config)(void);
/// 是否可用
@property (nonatomic,assign,readonly) UIButton *(^mg_Enabled)(BOOL value);
/// 是否允许交互
@property (nonatomic,assign,readonly) UIButton *(^mg_UserInteractionEnabled)(BOOL value);
/// 是否透明
@property (nonatomic,assign,readonly) UIButton *(^mg_Alpha)(CGFloat value);
/// 是否隐藏
@property (nonatomic,assign,readonly) UIButton *(^mg_Hidden)(BOOL value);
/// frame
@property (nonatomic,assign,readonly) UIButton *(^mg_Frame)(CGRect value);
/// 字体
@property (nonatomic,copy,readonly) UIButton *(^mg_Font)(UIFont *value);
/// 字号
@property (nonatomic,assign,readonly) UIButton *(^mg_FontSize)(CGFloat value);
/// 普通状态文字颜色
@property (nonatomic,copy,readonly) UIButton *(^mg_TextNormalColor)(UIColor *value);
/// 选中状态文字颜色
@property (nonatomic,copy,readonly) UIButton *(^mg_TextSelectedColor)(UIColor *value);
/// 普通状态image
@property (nonatomic,copy,readonly) UIButton *(^mg_NormalImage)(UIImage *value);
/// 选中状态image
@property (nonatomic,copy,readonly) UIButton *(^mg_SelectedImage)(UIImage *value);
/// 高亮状态image
@property (nonatomic,copy,readonly) UIButton *(^mg_HighlightedImage)(UIImage *value);
/// 不可点击状态image
@property (nonatomic,copy,readonly) UIButton *(^mg_DisabledImage)(UIImage *value);
/// 普通状态背景image
@property (nonatomic,copy,readonly) UIButton *(^mg_NormalBackgroundImage)(UIImage *value);
/// 选中状态背景Image
@property (nonatomic,copy,readonly) UIButton *(^mg_SelectedBackgroundImage)(UIImage *value);
/// Highlighted状态背景Image
@property (nonatomic,copy,readonly) UIButton *(^mg_HighlightedBackgroundImage)(UIImage *value);
/// Disabled状态背景Image
@property (nonatomic,copy,readonly) UIButton *(^mg_DisabledBackgroundImage)(UIImage *value);
/// 普通状态文字
@property (nonatomic,copy,readonly) UIButton *(^mg_NormalText)(NSString *value);
/// 选中状态文字
@property (nonatomic,copy,readonly) UIButton *(^mg_SelectedText)(NSString *value);
/// 高亮状态文字
@property (nonatomic,copy,readonly) UIButton *(^mg_HighlightedText)(NSString *value);
/// 不可点击状态文字
@property (nonatomic,copy,readonly) UIButton *(^mg_DisabledText)(NSString *value);
/// image偏移量
@property (nonatomic,assign,readonly) UIButton *(^mg_ImageEdgeInsets)(UIEdgeInsets value);
/// title偏移量
@property (nonatomic,assign,readonly) UIButton *(^mg_TitleEdgeInsets)(UIEdgeInsets value);
/// content偏移量
@property (nonatomic,assign,readonly) UIButton *(^mg_ContentEdgeInsets)(UIEdgeInsets value);
/// 垂直方向布局方式
@property (nonatomic,assign,readonly) UIButton *(^mg_ContentVerticalAlignment)(UIControlContentHorizontalAlignment value);
/// 水平方向布局方向
@property (nonatomic,assign,readonly) UIButton *(^mg_ContentHorizontalAlignment)(UIControlContentVerticalAlignment value);
/// selector
@property (nonatomic,copy,readonly) UIButton *(^mg_Selector)(id target, SEL sel, UIControlEvents controevents);

/// 圆角 CGFloat
@property (nonatomic,assign,readonly) UIButton *(^mg_CornerRadius)(CGFloat value);
/// 加到父控件
@property (nonatomic,copy,readonly) UIButton *(^mg_AddTo)(UIView *value);
/// 完成block
@property (nonatomic,copy,readonly) UIButton *(^mg_Completed)(void(^value)(UIButton *));

@end


#pragma mark - UITextField
@interface UITextField (SpeedCreat)
/// 初始化
+ (UITextField *)textField;
/// 默认设置
@property (nonatomic,copy,readonly) UITextField *(^mg_Config)(void) ;

/// 是否可用
@property (nonatomic,assign,readonly) UITextField *(^mg_Enabled)(BOOL value);
/// 是否允许交互
@property (nonatomic,assign,readonly) UITextField *(^mg_UserInteractionEnabled)(BOOL value);
/// 是否透明
@property (nonatomic,assign,readonly) UITextField *(^mg_Alpha)(CGFloat value);
/// 是否隐藏
@property (nonatomic,assign,readonly) UITextField *(^mg_Hidden)(BOOL value);
/// frame
@property (nonatomic,assign,readonly) UITextField *(^mg_Frame)(CGRect value);
/// 字体
@property (nonatomic,copy,readonly) UITextField *(^mg_Font)(UIFont *value);
/// 字号
@property (nonatomic,copy,readonly) UITextField *(^mg_FontSize)(CGFloat value);
/// 是否以加密形式显示
@property (nonatomic,assign,readonly) UITextField *(^mg_SecureTextEntry)(Boolean value);
/// 是否在开始输入时清空文字
@property (nonatomic,assign,readonly) UITextField *(^mg_ClearsOnBeginEditing)(Boolean value);
/// 文本
@property (nonatomic,copy,readonly) UITextField *(^mg_Text)(NSString *value);
/// 文本颜色
@property (nonatomic,copy,readonly) UITextField *(^mg_TextColor)(UIColor *value);
/// 占位图
@property (nonatomic,copy,readonly) UITextField *(^mg_PlaceHolder)(NSString *value);
/// return键类型
@property (nonatomic,copy,readonly) UITextField *(^mg_ReturnKeyType)(UIReturnKeyType value);
/// 边框样式
@property (nonatomic,assign,readonly) UITextField *(^mg_BorderStyle)(UITextBorderStyle value);
/// 左边视图样式
@property (nonatomic,assign,readonly) UITextField *(^mg_LeftViewMode)(UITextFieldViewMode value);
/// 删除view显示样式
@property (nonatomic,assign,readonly) UITextField *(^mg_ClearButtonMode)(UITextFieldViewMode value);

/// 圆角 CGFloat
@property (nonatomic,assign,readonly) UITextField *(^mg_CornerRadius)(CGFloat value);
/// 加到父控件
@property (nonatomic,copy,readonly) UITextField *(^mg_AddTo)(UIView *value);
/// 完成block
@property (nonatomic,copy,readonly) UITextField *(^mg_Completed)(void(^value)(UITextField *));

@end

#pragma mark - UIView
@interface UIView (SpeedCreat)
/// 快速创建Label
+ (UILabel *)speedCreatLabelWith:(void(^)(UILabel *label))attributeBlock;
/// 快速创建Button
+ (UIButton *)speedCreatButtonWith:(void(^)(UIButton *button))attributeBlock;
/// 快速创建TextField
+ (UITextField *)speedCreatTextfieldWith:(void(^)(UITextField *textField))attributeBlock;
@end

