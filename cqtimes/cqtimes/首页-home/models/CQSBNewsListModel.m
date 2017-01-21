//
//  CQSBNewsListModel.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNewsListModel.h"

@implementation CQSBNewsListModel

/**
 模型映射

 @return 返回映射字典
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"newslist_id": @"id",
             @"modelstatusType":@"modelstatus"
             };
}
@end
