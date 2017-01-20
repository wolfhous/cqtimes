//
//  CQSBNewSingleType2Cell.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CQSBNewsListModel.h"
@interface CQSBNewSingleType2Cell : UITableViewCell


/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



/**
 右侧图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;


@property (nonatomic,strong)CQSBNewsListModel *model;
@end
