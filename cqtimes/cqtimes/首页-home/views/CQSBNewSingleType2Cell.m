//
//  CQSBNewSingleType2Cell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNewSingleType2Cell.h"

@implementation CQSBNewSingleType2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(CQSBNewsListModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
}
@end
