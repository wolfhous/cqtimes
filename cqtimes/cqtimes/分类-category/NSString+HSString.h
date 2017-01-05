//
//  NSString+HSString.h
//  lkzb
//
//  Created by hou on 16/7/11.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HSString)

/** 判断是否为手机号码*/
+ (BOOL)isPhone:(NSString *)phone;
/** 计算某个路径文件大小 清除缓存用*/
- (unsigned long long)fileSize;
@end
