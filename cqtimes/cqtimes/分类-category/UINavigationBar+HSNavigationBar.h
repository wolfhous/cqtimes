//
//  UINavigationBar+HSNavigationBar.h
//  duobao
//
//  Created by hou on 16/9/26.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (HSNavigationBar)
/**  
 *设置导航栏透明
 */
-(void)hs_setupAlphaZero;

/**  设置导航栏背景透明度*/
-(void)hs_setupBackgroundWithAlpha:(CGFloat)alpha;
/**  隐藏导航栏 一条虚拟横线*/
-(void)hs_hideShadowImage;
@end
