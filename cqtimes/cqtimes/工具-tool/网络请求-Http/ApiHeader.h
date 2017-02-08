//
//  ApiHeader.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#ifndef ApiHeader_h
#define ApiHeader_h

#pragma mark - ==========登录注册密码相关========begin==============
//==========登录注册密码相关========begin==============

//注册  密码好像是MD5加密
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&nickname=猴哥&password=e10adc3949ba59abbe56e057f20f883e&phone=15248114341&version=1.8
#define API_register @"https://my.cqtimes.cn/?m=mobile&a=index&c=register"

//登录  密码好像是MD5加密
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&password=e10adc3949ba59abbe56e057f20f883e&phone=15248114341&type=1&version=1.8
#define API_login @"https://my.cqtimes.cn/?m=mobile&c=login&a=index"
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



//获取图片验证码 得到一张图片（忘记密码）
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46
#define API_get_verify @"https://my.cqtimes.cn/?m=mobile&c=lookpassword&a=verify"
/*
 
 {
	返回一张验证码图片
 }
 
 */

//图片验证码验证（忘记密码）
//code=44a8&deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&phone=15248114341&type=2&uid=&version=1.8
#define API_check_verify @"https://my.cqtimes.cn/?m=mobile&c=lookpassword&a=check_verify"
/*
 
 {
	"code": 1111,
	"desc": "请求成功"
 }
 
 */

//获取短信验证码（忘记密码）
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&phone=15248114341&type=2&uid=&version=1.8
#define API_pswDuanxin @"https://my.cqtimes.cn/?m=mobile&c=lookpassword&a=duanxin"
/*
 
 {
	"code": 1111,
	"desc": "请求成功"
 }
 {
	"code": -1,
	"desc": "发射间隔时间不低于一分钟"
 }
 */

//==========登录注册密码相关======= end ==============


#pragma mark - ==========基础信息  相关======= begin ==============
//==========基础信息  相关======= begin ==============
//启动广告
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&uid=&version=1.8
#define API_ad @"https://my.cqtimes.cn/?m=mobile&c=ads&a=index"

//大数据信息收集
//MAC=&app_version=1.8&area=渝北区&city=重庆市&country=中国&deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&equip_id=11134D98-4777-4E56-90BE-DFDBB51D6D46&equip_name=iPhone%206&ip=&lat_lng=29.63720224777046,106.5677346414327&network=中国移动%A8&operate_type=200&remarks=&system=ios&system_version=10.1.1&user_id=&version=1.8
#define API_Comm @"https://my.cqtimes.cn/?m=mobile&c=Common&a=index"


//版本信息
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&type=iphone&version=1.8
#define API_version @"https://my.cqtimes.cn/?m=mobile&c=version&a=index"

//==========基础信息 相关======= end ==============


#pragma mark - ==========新闻信息  相关======= begin ==============


//新闻信息
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&event_id=15&event_value=推荐&newstype_type=1&p=1&type=15&uid=&version=1.8
#define API_newsList @"https://my.cqtimes.cn/?m=mobile&c=index&a=type_news_list"

#pragma mark 频道信息
//频道信息
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&type=2&version=1.8
#define API_newstype @"https://my.cqtimes.cn/?m=mobile&c=newstype&a=index"



#pragma mark - =========== 发现 ===========
//=========== 发现 ===========
//发现 - 最新
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&page=1&pageNum=10&uid=MDAwMDAwMDAwMICIcqmDuKaS&version=1.8.4
#define API_discoverLatest @"https://my.cqtimes.cn/index.php?m=mobile&c=postapi&a=getPostForLatest"


//发现 - 热门
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&page=1&pageNum=10&uid=MDAwMDAwMDAwMICIcqmDuKaS&version=1.8.4
#define API_discoverHot @"https://my.cqtimes.cn/index.php?m=mobile&c=postapi&a=getPostForHot"


//发现 - 我的
//deviceid=11134D98-4777-4E56-90BE-DFDBB51D6D46&page=1&pageNum=10&uid=MDAwMDAwMDAwMICIcqmDuKaS&version=1.8.4
#define API_discoverSelf @"https://my.cqtimes.cn/index.php?m=mobile&c=postapi&a=getPostForSelf"



































#endif /* ApiHeader_h */
