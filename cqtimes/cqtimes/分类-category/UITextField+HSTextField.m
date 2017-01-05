//
//  UITextField+HSTextField.m
//  duobao
//
//  Created by hou on 16/9/24.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UITextField+HSTextField.h"
static NSString * const XMGPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation UITextField (HSTextField)
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    // 恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:XMGPlaceholderColorKey];
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor
//{
//    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
//    if (self.placeholder.length == 0) {
//        self.placeholder = @" ";
//    }
//
//    [self setValue:placeholderColor forKeyPath:XMGPlaceholderColorKey];
//}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:XMGPlaceholderColorKey];
}
@end
