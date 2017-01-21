//
//  CQSBNewSingleType3Cell.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CQSBNewsListModel.h"
@interface CQSBNewSingleType3Cell : UITableViewCell

@property (nonatomic,strong)CQSBNewsListModel *model;



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;


@property (weak, nonatomic) IBOutlet UIImageView *imageViewCenter;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewRight;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLeftHeight;



@end
