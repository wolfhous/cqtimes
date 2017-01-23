//
//  HSLunchTool.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/23.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HSLunchVC.h"

@interface HSLunchTool : NSObject
@property (nonatomic, copy, readwrite) void(^handler)(HSLunchTool *action); ///< 选择回调
//配置信息 先确定info允许http请求
/**
 *  展示启动广告图片/也叫展示推广页 为了在无网状态下也能显示广告，默认缓存有网下载的广告,basicImage传nil即可。 如不需要使用缓存图片，请设置basicImage。
 *
 *  @param imageUrlString 广告图片
 *  @param type  图片展示位置
 *  @param time  展示时间多少秒
 *  @param show  是否显示倒计时
 *  @param basicImage  无网状态下：一旦设置，无网状态默认加载。不设置，默认加载上一次广告图片
 *  @param handler 回调
 */


+(void)hs_showLaunchADWithImageUrlString:(NSString *)imageUrlString
                     withSuperScreenType:(ADScreenType)type
                       withHideAfterTime:(NSTimeInterval)time
                       withShowCountDown:(BOOL)show
                          withBasicImage:(UIImage*)basicImage withHandler:(void(^)(HSLunchTool *action))handler;






@end
