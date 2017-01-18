//
//  HS_Http.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HS_Http : NSObject
/**
 *  post请求 有提示框
 *
 *  @param apiName    需要请求的API链接
 *  @param parameters 传入的请求参数（可变字典）
 *  @param success    block回调值
 */
+(void)hs_postAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id responseObject))success error:(void(^)(id error))iserror;
/**
 *  post请求 无提示框
 *
 *  @param apiName    需要请求的API链接
 *  @param parameters 传入的请求参数（可变字典）
 *  @param success    block回调值
 */
+(void)hs_postClearAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id responseObject))success error:(void(^)(id error))iserror;


/**
 *  post请求 自定义是否有无提示框
 *
 *  @param hideHUD    是否隐藏HUD
 *  @param apiName    需要请求的API链接
 *  @param parameters 传入的请求参数（可变字典）
 *  @param success    block回调值
 */
+(void)hs_postBoolClear:(BOOL)hideHUD withAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id responseObject))success error:(void(^)(id error))iserror;

/**
 *  GET有提示框
 *
 *  @param apiName    需要请求的API链接
 *  @param parameters 传入的请求参数（可变字典）
 *  @param success    block回调值
 */
+(void)hs_getAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id dic))success error:(void(^)(id error))iserror;

/**
 *  GET无提示框
 *
 *  @param apiName    需要请求的API链接
 *  @param parameters 传入的请求参数（可变字典）
 *  @param success    block回调值
 */
+(void)hs_getClearAPIName:(NSString *)apiName parameters:(NSMutableDictionary *)parameters succes:(void(^)(id dic))success error:(void(^)(id error))iserror;
@end
