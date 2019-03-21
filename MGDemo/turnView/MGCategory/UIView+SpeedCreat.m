    //
    //  UIView+SpeedCreat.m
    //  Firestonelamp
    //
    //  Created by newunion on 2019/3/20.
    //  Copyright © 2019年 firestonetmt. All rights reserved.
    //

#import "UIView+SpeedCreat.h"

@implementation UILabel (SpeedCreat)

+ (UILabel *)label {
    return [[UILabel alloc] init];
}

- (UILabel*(^)(void))mg_Config {
    return ^ () {
        self.text = @"label";
        [self sizeToFit];
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentLeft;
        self.numberOfLines = 1;
        self.backgroundColor = [UIColor clearColor];
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.shadowColor = [UIColor clearColor];
        self.shadowOffset = CGSizeMake(0, 0);
        return self;
    };
}

- (UILabel * _Nonnull (^)(BOOL))mg_Enabled {
    return ^(BOOL value) {
        self.enabled = value;
        return self;
    };
}

- (UILabel * _Nonnull (^)(BOOL))mg_UserInteractionEnabled {
    return ^(BOOL value) {
        self.userInteractionEnabled = value;
        return self;
    };
}

- (UILabel * _Nonnull (^)(CGFloat))mg_Alpha {
    return ^(CGFloat value) {
        self.userInteractionEnabled = value;
        return self;
    };
}

- (UILabel * _Nonnull (^)(BOOL))mg_Hidden {
    return ^(BOOL value) {
        self.hidden = value;
        return self;
    };
}

    /// frame
- (UILabel*(^)(CGRect value))mg_Frame {
    return ^ (CGRect value) {
        self.frame = value;
        return self;
    };
}

    /// 文字
- (UILabel*(^)(NSString *value))mg_Text {
    return ^ (NSString *value) {
        self.text = value;
        return self;
    };
}

    /// 字体
- (UILabel*(^)(UIFont *value))mg_Font {
    return ^ (UIFont *value) {
        self.font = value;
        return self;
    };
}

    /// 字号
- (UILabel *(^)(CGFloat value))mg_FontSize {
    return ^ (CGFloat value) {
        self.font = [UIFont systemFontOfSize:value];
        return self;
    };
}

    /// 文本颜色
- (UILabel*(^)(UIColor *value))mg_TextColor {
    return ^ (UIColor *value) {
        self.textColor = value;
        return self;
    };
}

    /// 对齐方式
- (UILabel*(^)(NSTextAlignment value))mg_TextAlignment {
    return ^ (NSTextAlignment value) {
        self.textAlignment = value;
        return self;
    };
}

    /// 行数
- (UILabel*(^)(NSInteger value))mg_NumberOfLines {
    return ^ (NSInteger value) {
        self.numberOfLines = value;
        return self;
    };
}

    /// 背景色
- (UILabel*(^)(UIColor *value))mg_BackgroundColor {
    return ^ (UIColor *value) {
        self.backgroundColor = value;
        return self;
    };
}

    ///  换行方式
- (UILabel*(^)(NSLineBreakMode value))mg_LineBreakMode {
    return ^ (NSInteger value) {
        self.lineBreakMode = value;
        return self;
    };
}

    /// 阴影颜色
- (UILabel*(^)(UIColor *value))mg_ShadowColor {
    return ^ (UIColor *value) {
        self.shadowColor = value;
        return self;
    };
}

    /// 偏移尺寸
- (UILabel*(^)(CGSize value))mg_ShadowOffset {
    return ^ (CGSize value) {
        self.shadowOffset = value;
        return self;
    };
}

- (UILabel *(^)(CGFloat value))mg_CornerRadius {
    return ^ (CGFloat value) {
        self.layer.cornerRadius = value;
        self.clipsToBounds = true;
        return self;
    };
}

- (UILabel *(^)(UIView *value))mg_AddTo {
    return ^ (UIView *value) {
        [value addSubview:self];
        return self;
    };
}

- (UILabel *(^)(void (^)(UILabel *))) mg_Completed {
    return ^(void (^value)(UILabel *)) {
        value(self);
        return self;
    };
}

@end

@implementation UIButton (SpeedCreat)

+ (UIButton *)systemButton {
    return [UIButton buttonWithType:UIButtonTypeSystem];
}

+ (UIButton *)customButton {
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (UIButton*(^)(void))mg_Config {
    return ^() {
        [self setTitle:@"button" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        return self;
    };
}

- (UIButton * _Nonnull (^)(BOOL))mg_Enabled {
    return ^(BOOL value) {
        self.enabled = value;
        return self;
    };
}

- (UIButton * _Nonnull (^)(BOOL))mg_UserInteractionEnabled {
    return ^(BOOL value) {
        self.userInteractionEnabled = value;
        return self;
    };
}

- (UIButton * _Nonnull (^)(CGFloat))mg_Alpha {
    return ^(CGFloat value) {
        self.userInteractionEnabled = value;
        return self;
    };
}

- (UIButton * _Nonnull (^)(BOOL))mg_Hidden {
    return ^(BOOL value) {
        self.hidden = value;
        return self;
    };
}

    /// frame
- (UIButton*(^)(CGRect value))mg_Frame {
    return ^ (CGRect value) {
        self.frame = value;
        return self;
    };
}

    /// 字体
- (UIButton*(^)(UIFont *value))mg_Font {
    return ^ (UIFont *value) {
        self.titleLabel.font = value;
        return self;
    };
}

    /// 字号
- (UIButton *(^)(CGFloat value))mg_FontSize {
    return ^ (CGFloat value) {
        self.titleLabel.font = [UIFont systemFontOfSize:value];
        return self;
    };
}

    /// normal 文字
- (UIButton*(^)(NSString *value))mg_NormalText {
    return ^ (NSString *value) {
        [self setTitle:value forState:UIControlStateNormal];
        return self;
    };
}

    /// selected 文字
- (UIButton*(^)(NSString *value))mg_SelectedText {
    return ^ (NSString *value) {
        [self setTitle:value forState:UIControlStateSelected];
        return self;
    };
}

    /// highlight 文字
- (UIButton*(^)(NSString *value))mg_HighlightedText {
    return ^ (NSString *value) {
        [self setTitle:value forState:UIControlStateHighlighted];
        return self;
    };
}

- (UIButton *(^)(NSString *))mg_DisabledText {
    return ^ (NSString *value) {
        [self setTitle:value forState:UIControlStateDisabled];
        return self;
    };
}

    /// normal 文字颜色
- (UIButton*(^)(UIColor *value))mg_NormalTextColor {
    return ^ (UIColor *value) {
        [self setTitleColor:value forState:UIControlStateNormal];
        return self;
    };
}

    /// selected 文字颜色
- (UIButton*(^)(UIColor *value))mg_SelectedTextColor {
    return ^ (UIColor *value) {
        [self setTitleColor:value forState:UIControlStateSelected];
        return self;
    };
}

    /// Highlighted 文字颜色
- (UIButton*(^)(UIColor *value))mg_HighlightedTextColor {
    return ^ (UIColor *value) {
        [self setTitleColor:value forState:UIControlStateHighlighted];
        return self;
    };
}

    /// Disabled 文字颜色
- (UIButton*(^)(UIColor *value))mg_DisabledTextColor {
    return ^ (UIColor *value) {
        [self setTitleColor:value forState:UIControlStateDisabled];
        return self;
    };
}

    /// normal 图片
- (UIButton*(^)(UIImage *value))mg_NormalImage {
    return ^ (UIImage *value) {
        [self setImage:value forState:UIControlStateNormal];
        return self;
    };
}

    /// selected 图片
- (UIButton*(^)(UIImage *value))mg_SelectedImage {
    return ^ (UIImage *value) {
        [self setImage:value forState:UIControlStateSelected];
        return self;
    };
}

    /// Highlighted 图片
- (UIButton *(^)(UIImage *))mg_HighlightedImage {
    return ^ (UIImage *value) {
        [self setImage:value forState:UIControlStateHighlighted];
        return self;
    };
}

    /// Disabled 图片
- (UIButton *(^)(UIImage *))mg_DisabledImage {
    return ^ (UIImage *value) {
        [self setImage:value forState:UIControlStateDisabled];
        return self;
    };
}


    /// normal 背景图片
- (UIButton*(^)(UIImage *value))mg_NormalBackgroundImage {
    return ^ (UIImage *value) {
        [self setBackgroundImage:value forState:UIControlStateNormal];
        return self;
    };
}

    /// selected 背景图片
- (UIButton*(^)(UIImage *value))mg_SelectedBackgroundImage {
    return ^ (UIImage *value) {
        [self setBackgroundImage:value forState:UIControlStateSelected];
        return self;
    };
}

    /// Highlighted 背景图片
- (UIButton*(^)(UIImage *value))mg_HighlightedBackgroundImage {
    return ^ (UIImage *value) {
        [self setBackgroundImage:value forState:UIControlStateHighlighted];
        return self;
    };
}

    /// Disabled 背景图片
- (UIButton*(^)(UIImage *value))mg_DisabledBackgroundImage {
    return ^ (UIImage *value) {
        [self setBackgroundImage:value forState:UIControlStateDisabled];
        return self;
    };
}

    /// 垂直布局
- (UIButton*(^)(UIControlContentHorizontalAlignment value))mg_ContentVerticalAlignment {
    return ^ (UIControlContentHorizontalAlignment value) {
        self.contentHorizontalAlignment = value;
        return self;
    };
}

    /// 水平布局
- (UIButton*(^)(UIControlContentVerticalAlignment value))mg_ContentHorizontalAlignment {
    return ^ (UIControlContentVerticalAlignment value) {
        self.contentVerticalAlignment = value;
        return self;
    };
}

    /// image 偏移量
- (UIButton*(^)(UIEdgeInsets value))mg_ImageEdgeInsets {
    return ^ (UIEdgeInsets value) {
        self.imageEdgeInsets = value;
        return self;
    };
}

    /// title 偏移量
- (UIButton*(^)(UIEdgeInsets value))mg_TitleEdgeInsets {
    return ^ (UIEdgeInsets value) {
        self.titleEdgeInsets = value;
        return self;
    };
}

    /// 内容 偏移量
- (UIButton*(^)(UIEdgeInsets value))mg_ContentEdgeInsets {
    return ^ (UIEdgeInsets value) {
        self.contentEdgeInsets = value;
        return self;
    };
}

    /// 点击事件
- (UIButton *(^)(id target, SEL sel, UIControlEvents controevents))mg_Selector {
    return ^ (id target, SEL sel, UIControlEvents controevents) {
        [self addTarget:target action:sel forControlEvents:controevents];
        return self;
    };
}

- (UIButton *(^)(CGFloat value))mg_CornerRadius {
    return ^ (CGFloat value) {
        self.layer.cornerRadius = value;
        self.clipsToBounds = true;
        return self;
    };
}

- (UIButton *(^)(UIView *value))mg_AddTo {
    return ^ (UIView *value) {
        [value addSubview:self];
        return self;
    };
}

- (UIButton *(^)(void (^)(UIButton *)))mg_Completed {
    return ^(void (^value)(UIButton *)) {
        value(self);
        return self;
    };
}

@end

@implementation UITextField (SpeedCreat)

+ (UITextField *)textField {
    return [[UITextField alloc] init];
}
- (UITextField *(^)(void))mg_Config {
    return ^ () {
        self.placeholder = @"placeholder";
        self.borderStyle = UITextBorderStyleNone;
        self.clearsOnBeginEditing = true;
        self.secureTextEntry = true;
        self.returnKeyType = UIReturnKeyDefault;
        self.leftView = [UIView new];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        return self;
    };
}

- (UITextField * _Nonnull (^)(BOOL))mg_Enabled {
    return ^(BOOL value) {
        self.enabled = value;
        return self;
    };
}

- (UITextField * _Nonnull (^)(BOOL))mg_UserInteractionEnabled {
    return ^(BOOL value) {
        self.userInteractionEnabled = value;
        return self;
    };
}

- (UITextField * _Nonnull (^)(CGFloat))mg_Alpha {
    return ^(CGFloat value) {
        self.userInteractionEnabled = value;
        return self;
    };
}

- (UITextField * _Nonnull (^)(BOOL))mg_Hidden {
    return ^(BOOL value) {
        self.hidden = value;
        return self;
    };
}

- (UITextField *(^)(CGRect value))mg_Frame {
    return ^ (CGRect value) {
        self.frame = value;
        return self;
    };
}
- (UITextField *(^)(UIFont *value))mg_Font {
    return ^ (UIFont *value) {
        self.font = value;
        return self;
    };
}

    /// 字号
- (UITextField *(^)(CGFloat value))mg_FontSize {
    return ^ (CGFloat value) {
        self.font = [UIFont systemFontOfSize:value];
        return self;
    };
}

    /// 文本颜色
- (UITextField*(^)(UIColor *value))mg_TextColor {
    return ^ (UIColor *value) {
        self.textColor = value;
        return self;
    };
}

- (UITextField *(^)(Boolean value))mg_SecureTextEntry {
    return ^(Boolean value) {
        self.secureTextEntry = value;
        return self;
    };
}

- (UITextField *(^)(Boolean value))mg_ClearsOnBeginEditing {
    return ^(Boolean value) {
        self.clearsOnBeginEditing = value;
        return self;
    };
}

- (UITextField *(^)(NSString *value))mg_Text {
    return ^ (NSString *value) {
        self.text = value;
        return self;
    };
}

- (UITextField *(^)(NSString *value))mg_PlaceHolder {
    return ^(NSString *value) {
        self.placeholder = value;
        return self;
    };
}

- (UITextField *(^)(UITextBorderStyle value))mg_BorderStyle {
    return ^(UITextBorderStyle value) {
        self.borderStyle = value;
        return self;
    };
}

- (UITextField *(^)(UIReturnKeyType value))mg_ReturnKeyType {
    return ^(UIReturnKeyType value) {
        self.returnKeyType = value;
        return self;
    };
}

- (UITextField *(^)(UITextFieldViewMode value))mg_LeftViewMode {
    return ^(UITextFieldViewMode value) {
        self.leftViewMode = value;
        return self;
    };
}

- (UITextField *(^)(UITextFieldViewMode value))mg_ClearButtonMode {
    return ^(UITextFieldViewMode value) {
        self.clearButtonMode = value;
        return self;
    };
}

- (UITextField *(^)(CGFloat value))mg_CornerRadius {
    return ^ (CGFloat value) {
        self.layer.cornerRadius = value;
        self.clipsToBounds = true;
        return self;
    };
}

- (UITextField *(^)(UIView *value))mg_AddTo {
    return ^ (UIView *value) {
        [value addSubview:self];
        return self;
    };
}

- (UITextField *(^)(void (^)(UITextField *)))mg_Completed {
    return ^(void (^value)(UITextField *)) {
        value(self);
        return self;
    };
}

@end

@implementation UIView (SpeedCreat)

    /// 快速创建一个Label 默认 text "label" font 14 numberofline 1
+ (UILabel *)speedCreatLabelWith:(void(^)(UILabel *label))attributeBlock
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"label";
    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.backgroundColor = [UIColor clearColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.shadowColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0, 0);
    if (attributeBlock) {
        attributeBlock(label);
    }
    return label;
}

    /// 快速创建一个button 默认 text "button" font 14
+ (UIButton *)speedCreatButtonWith:(void(^)(UIButton *button))attributeBlock
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"button" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (attributeBlock) {
        attributeBlock(button);
    }
    return button;
}

    /// 快速创建textField
+ (UITextField *)speedCreatTextfieldWith:(void(^)(UITextField *textField))attributeBlock {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"请输入...";
    textField.frame = CGRectMake(0, 0, 100, 25);
    textField.font = [UIFont systemFontOfSize:14];
    textField.clearsOnBeginEditing = true;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.leftView = [UIView new];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

@end
