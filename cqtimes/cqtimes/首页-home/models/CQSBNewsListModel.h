//
//  CQSBNewsListModel.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,cellType) {
    /** 文字类型新闻*/
    cellTypeWord = 4,
    /** 右侧图片类型新闻*/
    cellTypeRightImage = 1,
    /** 三张图片类型新闻*/
    cellTypeThreeImage = 3,
    /** 广告类型新闻*/
    cellTypeAD = 30,
    /** 大图类型新闻*/
    cellTypeBigImage = 2,
    
};




@interface CQSBNewsListModel : NSObject
/** 模型状态 枚举 */
@property (nonatomic,assign)cellType modelstatusType;

/** 标题*/
@property (nonatomic,copy)NSString *title;
/** 打开后的新闻链接 */
@property (nonatomic,copy)NSString *url;
/** 视频链接 */
@property (nonatomic,copy)NSString *videourl;
/** 第一张图片地址 */
@property (nonatomic,copy)NSString *img;
/** 评论数量 */
@property (nonatomic,copy)NSString *pl_counts;
/** 置顶？？ 2 */
@property (nonatomic,copy)NSString *zhiding;
/** 图片  以逗号连接的字符串 947424,947425,947426 */
@property (nonatomic,copy)NSString *imgs;
/** 新闻id */
@property (nonatomic,copy)NSString *newslist_id;
/** 什么什么状态 1 */
@property (nonatomic,copy)NSString *caststate;
/** 图片数组 */
@property (nonatomic,copy)NSArray *imglist;//
/** 时间戳 */
@property (nonatomic,copy)NSString *addtime;
/** ？？是否重要？ 特殊 0 */
@property (nonatomic,copy)NSString *isspecial;
/** ？？  22 */
@property (nonatomic,copy)NSString *des;
/** ？？  这是什么什么id把 1 */
@property (nonatomic,copy)NSString *ugcid;
/** 是否评论 ？  1 */
@property (nonatomic,copy)NSString *iscomment;
/** ?? 是否次要？ 0 */
@property (nonatomic,copy)NSString *inside;
/** 视频时间 */
@property (nonatomic,copy)NSString *videotime;
/** ？？ 是否投票 1 */
@property (nonatomic,copy)NSString *isvote;
/** ？ 2 */
@property (nonatomic,copy)NSString *collect_is;

//===========自定义添加数据==============

/** cell 的高度*/
@property (nonatomic,assign)CGFloat cellHeight;

@end
