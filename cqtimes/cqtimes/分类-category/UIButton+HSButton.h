//
//  UIButton+HSButton.h
//  demo
//
//  Created by hou on 16/6/28.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HSButton)
/** 右角标数*/
@property (nonatomic,strong) NSString *badgeNumber;
/** 隐藏角标BOOL*/
@property (nonatomic,assign)BOOL hideBadgeNumber;
/**
 *  【【【【【右角标数】】】】】
 *
 *  @param str     角标数
 *  @param color   角标颜色
 *  @param bgColor 角标背景色
 *  @param width   角标宽度
 */
-(void)hs_buttonWithBadgeStr:(NSString *)str withColor:(UIColor *)color withBgColor:(UIColor *)bgColor withWidth:(CGFloat)width;
/**
 *  【【【【【倒计时按钮】】】】】需提前设置按钮类型为UIButtonTypeCustom，才不会闪烁
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */

- (void)hs_startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;


/**
 *  设置圆角按钮
 *
 *  @param radius      圆角度数
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @param bgColor     背景颜色
 *  @param textColor   字体颜色
 *  @param fontSize    字体大小
 *  @param controlState    状态
 */
-(void)hs_setRoundRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize controlState:(UIControlState)controlState;
/**
 *  设置圆角按钮
 *
 *  @param radius 圆角度数
 */
-(void)hs_setRoundRadius:(CGFloat)radius;
@end
