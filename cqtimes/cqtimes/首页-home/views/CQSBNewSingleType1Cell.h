//
//  CQSBNewSingleType1Cell.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQSBNewsListModel.h"
@interface CQSBNewSingleType1Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (nonatomic,strong)CQSBNewsListModel *model;


@end
