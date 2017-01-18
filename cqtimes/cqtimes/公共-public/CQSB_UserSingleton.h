//
//  CQSB_UserSingleton.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  用户单例

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface CQSB_UserSingleton : NSObject
singleton_interface(CQSB_UserSingleton)


/**
 网络接口状态码  1111 代表正常
 */
@property (nonatomic,copy)NSString *code;

/**
 描述 登录成功
 */
@property (nonatomic,copy)NSString *desc;
/**
 用户id
 */
@property (nonatomic,copy)NSString *uid;
/**
 昵称
 */
@property (nonatomic,copy)NSString *nickname;
/**
 手机号
 */
@property (nonatomic,copy)NSString *phone;
/**
 分组id
 */
@property (nonatomic,copy)NSString *groupid;
/**
 uuid
 */
@property (nonatomic,copy)NSString *uuid;
/**
 生日
 */
@property (nonatomic,copy)NSString *birthday;
/**
 头像
 */
@property (nonatomic,copy)NSString *img;
/**
 性别
 */
@property (nonatomic,copy)NSString *sex;
/**
 状态
 */
@property (nonatomic,copy)NSString *status;
/**
 分组名字 普通用户
 */
@property (nonatomic,copy)NSString *groupname;
/**
 flag
 */
@property (nonatomic,copy)NSString *flag;
/**
 module
 */
@property (nonatomic,copy)NSString *module;
/**
 首次登录
 */
@property (nonatomic,copy)NSString *first_login;

/*
 
 {
	"code": 1111,
	"desc": "登录成功",
	"uid": "MDAwMDAwMDAwMICIcqmDuKaV",
	"nickname": "猴哥",
	"phone": "15248114341",
	"groupid": "1",
	"uuid": "54a77bda-bdb3-2835-1ae7-57fa24cfb799",
	"birthday": null,
	"img": "",
	"sex": "0",
	"status": 0,
	"groupname": "普通用户",
	"flag": 0,
	"module": null,
	"first_login": 1
 }
 
 */



@end
