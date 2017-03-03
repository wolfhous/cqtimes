//
//  HSManager.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HSManager : NSObject
/** 检测网络*/
+(void)hs_getExistenceNetwork;
/** 检测网络，返回一个布尔值 有网YES，无网NO*/
+(BOOL)hs_isExistenceNetwork;

/** 判断是否为手机号码*/
+ (BOOL)hs_isPhone:(NSString *)phoneStr;


/**
 *  浏览头像效果
 *
 *  @param selectedImageView 头像所在的imageView
 */
+ (void)hs_showBigImage:(UIImageView *)selectedImageView;

/**
 *  时间戳转时间字符串
 *
 *  @param str 传入的时间戳
 *
 *  @return 返回的时间字符串
 */
+(NSString *)hs_getTimeForDataStr:(NSString *)str;

/**
 *  MD5加密
 *
 *  @param str 需要加密的字符串
 *
 *  @return 返回一个加密完的字符串
 */
+(NSString *)hs_getMd5Str:(NSString *)str;

@end
