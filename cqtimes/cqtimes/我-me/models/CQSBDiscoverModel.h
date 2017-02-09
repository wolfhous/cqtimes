//
//  CQSBDiscoverModel.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/24.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQSBDiscoverModel : NSObject
/** 时间戳*/
@property (nonatomic,copy)NSString *addtime;
/** 回复内容*/
@property (nonatomic,copy)NSArray *briefComment;//content 内容 username用户名
/** 核对时间*/
@property (nonatomic,copy)NSString *checktime;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *comments;
/** 内容*/
@property (nonatomic,copy)NSString *content;
/** 内容url链接*/
@property (nonatomic,copy)NSString *contentUrl;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *distance;
/** 图片数组*/
@property (nonatomic,copy)NSArray *images;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *isDel;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *isPraise;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *isautocheck;
/** 评论数量*/
@property (nonatomic,copy)NSString *mainComments;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *nid;
/** 点赞数量*/
@property (nonatomic,copy)NSString *praises;
/** 分享链接url*/
@property (nonatomic,copy)NSString *shareUrl;
/** 状态*/
@property (nonatomic,copy)NSString *status;
/** 标题*/
@property (nonatomic,copy)NSString *title;
/** 类型 3*/
@property (nonatomic,copy)NSString *type;
/** 用户id*/
@property (nonatomic,copy)NSString *uid;
/** 用户头像*/
@property (nonatomic,copy)NSString *userimg;
/** 用户名*/
@property (nonatomic,copy)NSString *username;
/** 视频数组*/
@property (nonatomic,copy)NSArray *videos;
/** <#注释语#>*/
@property (nonatomic,copy)NSString *views;


/*
 images : [
	{
	path : https://my.cqtimes.cn/Uploads/Picture/2017-02-07/5899d8581059b.jpg,
	thumb : https://my.cqtimes.cn/Uploads/Picture/2017-02-07/2_1_5899d8581059b.jpg,
	ratio : 1.33,//猜测应该是图片比例
	remark :
 }
 ]
 */


//===========自定义添加数据==============

/** cell 的高度*/
@property (nonatomic,assign)CGFloat cellHeight;

@end
