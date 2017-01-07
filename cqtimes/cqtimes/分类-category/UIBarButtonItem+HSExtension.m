//
//  UIBarButtonItem+HSExtension.m
//  duobao
//
//  Created by hou on 16/9/24.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UIBarButtonItem+HSExtension.h"

@implementation UIBarButtonItem (HSExtension)
+ (instancetype)hs_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)hs_itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}

+ (instancetype)hs_cqst_itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Search_21x21_"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Search_21x21_"] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [button sizeToFit];
    CGRect rect = button.frame;
    rect.size.width += 35;
    rect.size.height +=10;
    button.frame = rect;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = button.frame.size.height /2;
    return [[self alloc] initWithCustomView:button];
}
@end
