//
//  CQSBDiscoverCell.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/24.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQSBDiscoverModel.h"





@interface CQSBDiscoverCell : UITableViewCell


@property (nonatomic,strong) CQSBDiscoverModel *model;

/** 用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
/** 用户名*/
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/** 用户发布时间*/
@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/** 内容*/
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;




/** 中间背景视图*/
@property (weak, nonatomic) IBOutlet UIView *centerBgView;
/** 中间背景视图高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerBgViewH;


/** 点赞按钮*/
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
/** 分享按钮*/
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/** 评论按钮*/
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@end
