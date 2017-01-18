//
//  CQSBNewsTypeCell.h
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CQSBNewsTypeModel.h"
@interface CQSBNewsTypeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *delCategoryImageView;

@property (nonatomic,strong)CQSBNewsTypeModel *model;
@end
