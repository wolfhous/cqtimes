//
//  CQSBNewsTypeCell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNewsTypeCell.h"

@implementation CQSBNewsTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.cornerRadius = 2.5;
    self.delCategoryImageView.hidden = YES;
    
}




-(void)setModel:(CQSBNewsTypeModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
}

@end
