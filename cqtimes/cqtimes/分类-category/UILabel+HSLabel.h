//
//  UILabel+HSLabel.h
//  duobao
//
//  Created by 壹号商圈 on 16/10/8.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HSLabel)

-(void)hs_setRoundRadius:(CGFloat)radius;


-(void)hs_setRoundRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor bgColor:(nullable UIColor *)bgColor textColor:(nullable UIColor *)textColor fontSize:(CGFloat)fontSize;

@end
