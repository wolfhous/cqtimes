//
//  UIBarButtonItem+HSExtension.m
//  duobao
//
//  Created by hou on 16/9/24.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UIBarButtonItem+HSExtension.h"

@implementation UIBarButtonItem (HSExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}
@end
