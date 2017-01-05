//
//  UIImageView+HSRound.h
//  lkzb
//
//  Created by hou on 16/7/21.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HSRound)
/** 设置圆形图片*/
-(void)hs_setRound;
/**
 *  设置圆角图
 *
 *  @param cornerRadius 圆角度数
 */
-(void)hs_setRoundRadius:(CGFloat )cornerRadius;
@end
