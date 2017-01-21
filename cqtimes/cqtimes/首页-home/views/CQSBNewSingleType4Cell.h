//
//  CQSBNewSingleType4Cell.h
//  cqtimes
//
//  Created by 侯帅 on 2017/1/21.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CQSBNewsListModel.h"
@interface CQSBNewSingleType4Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBig;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBigHeight;

@property (nonatomic,strong)CQSBNewsListModel *model;
@end
