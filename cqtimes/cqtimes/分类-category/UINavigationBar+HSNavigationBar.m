//
//  UINavigationBar+HSNavigationBar.m
//  duobao
//
//  Created by hou on 16/9/26.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UINavigationBar+HSNavigationBar.h"
#import "UIImage+Image.h"
@implementation UINavigationBar (HSNavigationBar)
-(void)hs_setupAlphaZero{
    //设置导航栏透明
    [self setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    // 清空导航条的阴影的线
    [self setShadowImage:[[UIImage alloc]init]];
}
-(void)hs_setupBackgroundWithAlpha:(CGFloat)alpha{
    // 根据当前alpha值生成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(void)hs_hideShadowImage{
    // 清空导航条的阴影的线
    [self setShadowImage:[[UIImage alloc]init]];
}
@end
