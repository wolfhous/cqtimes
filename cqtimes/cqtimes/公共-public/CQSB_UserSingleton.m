//
//  CQSB_UserSingleton.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSB_UserSingleton.h"

@implementation CQSB_UserSingleton
singleton_implementation(CQSB_UserSingleton)

-(NSString *)uid{
    if (!_uid) {
        _uid = @"MDAwMDAwMDAwMICIcqmDuKaS";
    }
    return _uid;
}

@end
