//
//  UIBarButtonItem+HSExtension.h
//  duobao
//
//  Created by hou on 16/9/24.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HSExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
