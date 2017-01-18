//
//  CQSB_AppSingleton.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSB_AppSingleton.h"

@implementation CQSB_AppSingleton
singleton_implementation(CQSB_AppSingleton)


-(NSString *)current_version{
    if (!_current_version) {
        NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
        _current_version = infoDic[@"CFBundleShortVersionString"];
    }
    return _current_version;
}
-(NSString *)deviceid{
    if (!_deviceid) {
        _deviceid = @"11134D98-4777-4E56-90BE-DFDBB51D6D46";
    }
    return _deviceid;
}

@end
