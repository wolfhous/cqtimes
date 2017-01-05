//
//  UILabel+HSLabel.m
//  duobao
//
//  Created by 壹号商圈 on 16/10/8.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UILabel+HSLabel.h"

@implementation UILabel (HSLabel)
-(void)hs_setRoundRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}
-(void)hs_setRoundRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor bgColor:(nullable UIColor *)bgColor textColor:(nullable UIColor *)textColor fontSize:(CGFloat)fontSize{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
    }
    if (bgColor) {
        self.backgroundColor = bgColor;
    }
    if (textColor) {
        self.textColor = textColor;
    }
    if (fontSize > 0) {
        self.font = [UIFont systemFontOfSize:fontSize];
    }
}
@end
