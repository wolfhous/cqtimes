//
//  UIBarButtonItem+HSExtension.h
//  duobao
//
//  Created by hou on 16/9/24.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HSExtension)
+ (instancetype)hs_itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)hs_itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;

/**
 重庆时报 首页搜索item

 @param image <#image description#>
 @param highImage <#highImage description#>
 @param title <#title description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
+ (instancetype)hs_cqst_itemWithImage:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title target:(id)target action:(SEL)action;
@end
