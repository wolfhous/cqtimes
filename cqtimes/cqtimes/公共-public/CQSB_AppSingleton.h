//
//  CQSB_AppSingleton.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  APP信息单例

#import <Foundation/Foundation.h>

@interface CQSB_AppSingleton : NSObject
singleton_interface(CQSB_AppSingleton)

/**
 当前版本
 */
@property (nonatomic,copy)NSString *current_version;
/**
 设备id
 */
@property (nonatomic,copy)NSString *deviceid;

@end
