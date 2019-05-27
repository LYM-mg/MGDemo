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
    /// 快速创建Label
+ (instancetype)speedCreatLabelWith:(void(^)(id lb))attributeBlock;
    /// 初始化
+ (instancetype)label;

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
@property (nonatomic,strong,readonly) UILabel *(^mg_TextColor)(UIColor *value);
    /// 阴影文字颜色
@property (nonatomic,strong,readonly) UILabel *(^mg_ShadowColor)(UIColor *value);
    /// 背景色
@property (nonatomic,strong,readonly) UILabel *(^mg_BackgroundColor)(UIColor *value);
    /// 文本
@property (nonatomic,copy,readonly) UILabel *(^mg_Text)(NSString *value);
    /// 自适应宽高
@property (nonatomic,copy,readonly) UILabel *(^mg_SizeToFit)(void);
    /// 行
@property (nonatomic,assign,readonly) UILabel *(^mg_NumberOfLines)(NSInteger value);
    /// 对齐方式
@property (nonatomic,strong,readonly) UILabel *(^mg_TextAlignment)(NSTextAlignment value);
    /// 断句方式
@property (nonatomic,assign,readonly) UILabel *(^mg_LineBreakMode)(NSLineBreakMode value);

    /// 圆角 CGFloat
@property (nonatomic,assign,readonly) UILabel *(^mg_CornerRadius)(CGFloat value);
    /// 加到父控件
@property (nonatomic,strong,readonly) UILabel *(^mg_AddTo)(UIView *value);
    /// 完成block
@property (nonatomic,copy,readonly) UILabel *(^mg_Completed)(void(^value)(UILabel *));

@end


#pragma mark - UIButton
@interface UIButton (SpeedCreat)
    /// 快速创建Button
+ (instancetype)speedCreatButtonWith:(void(^)(id btn))attributeBlock;
    /// 初始化custom按钮
+ (instancetype)customButton;
    /// 初始化system按钮
+ (instancetype)systemButton;

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
    /// 背景色
@property (nonatomic,strong,readonly) UIButton *(^mg_BackgroundColor)(UIColor *value);
    /// frame
@property (nonatomic,assign,readonly) UIButton *(^mg_Frame)(CGRect value);
    /// 字体
@property (nonatomic,copy,readonly) UIButton *(^mg_Font)(UIFont *value);
    /// 字号
@property (nonatomic,assign,readonly) UIButton *(^mg_FontSize)(CGFloat value);
    /// 普通状态文字颜色
@property (nonatomic,strong,readonly) UIButton *(^mg_NormalTextColor)(UIColor *value);
    /// 选中状态文字颜色
@property (nonatomic,strong,readonly) UIButton *(^mg_SelectedTextColor)(UIColor *value);
    /// 选中状态文字颜色
@property (nonatomic,strong,readonly) UIButton *(^mg_HighlightedTextColor)(UIColor *value);
    /// Disabled 文字颜色
@property (nonatomic,strong,readonly) UIButton *(^mg_DisabledTextColor)(UIColor *value);
    /// 自适应宽高
@property (nonatomic,copy,readonly) UIButton *(^mg_SizeToFit)(void);
    /// 普通状态image
@property (nonatomic,strong,readonly) UIButton *(^mg_NormalImage)(UIImage *value);
    /// 选中状态image
@property (nonatomic,strong,readonly) UIButton *(^mg_SelectedImage)(UIImage *value);
    /// 高亮状态image
@property (nonatomic,strong,readonly) UIButton *(^mg_HighlightedImage)(UIImage *value);
    /// Disabled状态image
@property (nonatomic,strong,readonly) UIButton *(^mg_DisabledImage)(UIImage *value);
    /// 普通状态背景image
@property (nonatomic,strong,readonly) UIButton *(^mg_NormalBackgroundImage)(UIImage *value);
    /// 选中状态背景Image
@property (nonatomic,strong,readonly) UIButton *(^mg_SelectedBackgroundImage)(UIImage *value);
    /// Highlighted状态背景Image
@property (nonatomic,strong,readonly) UIButton *(^mg_HighlightedBackgroundImage)(UIImage *value);
    /// Disabled状态背景Image
@property (nonatomic,strong,readonly) UIButton *(^mg_DisabledBackgroundImage)(UIImage *value);
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
    /// 快速创建TextField
+ (instancetype)speedCreatTextfieldWith:(void(^)(id tf))attributeBlock;

    /// 初始化
+ (instancetype)textField;
    /// 默认设置
@property (nonatomic,copy,readonly) UITextField *(^mg_Config)(void);
    /// 设置代理
@property (nonatomic,copy,readonly) UITextField *(^mg_Delegate)(id <UITextFieldDelegate>);

    /// 是否可用
@property (nonatomic,assign,readonly) UITextField *(^mg_Enabled)(BOOL value);
    /// 是否允许交互
@property (nonatomic,assign,readonly) UITextField *(^mg_UserInteractionEnabled)(BOOL value);
    /// 是否透明
@property (nonatomic,assign,readonly) UITextField *(^mg_Alpha)(CGFloat value);
    /// 背景色
@property (nonatomic,strong,readonly) UITextField *(^mg_BackgroundColor)(UIColor *value);
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
@property (nonatomic,strong,readonly) UITextField *(^mg_TextColor)(UIColor *value);
    /// 占位文字
@property (nonatomic,copy,readonly) UITextField *(^mg_PlaceHolder)(NSString *value);
    /// 占位文字颜色
@property (nonatomic,strong,readonly) UITextField *(^mg_PlaceHolderColor)(UIColor *value);
    /// 占位文字字体
@property (nonatomic,strong,readonly) UITextField *(^mg_PlaceHolderCFont)(UIFont *value);

    /// return键类型
@property (nonatomic,assign,readonly) UITextField *(^mg_ReturnKeyType)(UIReturnKeyType value);
    /// 边框样式
@property (nonatomic,assign,readonly) UITextField *(^mg_BorderStyle)(UITextBorderStyle value);
    /// 左边视图样式
@property (nonatomic,assign,readonly) UITextField *(^mg_LeftViewMode)(UITextFieldViewMode value);
    /// 删除view显示样式
@property (nonatomic,assign,readonly) UITextField *(^mg_ClearButtonMode)(UITextFieldViewMode value);

    /// selector
@property (nonatomic,copy,readonly) UITextField *(^mg_Selector)(id target, SEL sel, UIControlEvents controevents);
    /// 圆角 CGFloat
@property (nonatomic,assign,readonly) UITextField *(^mg_CornerRadius)(CGFloat value);
    /// 加到父控件
@property (nonatomic,strong,readonly) UITextField *(^mg_AddTo)(UIView *value);
    /// 完成block
@property (nonatomic,copy,readonly) UITextField *(^mg_Completed)(void(^value)(UITextField *));

@end

#pragma mark - UIView
@interface UIView (SpeedCreat)



@end

