//
//  CQSBNewSingleType3Cell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  三张图片类型

#import "CQSBNewSingleType3Cell.h"

@implementation CQSBNewSingleType3Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
    self.imageViewLeftHeight.constant = (SCREEN_WIDTH - 40)/3 * 3/4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(CQSBNewsListModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    
    if (model.imglist.count >= 3) {
        [self.imageViewLeft sd_setImageWithURL:[NSURL URLWithString:model.imglist.firstObject] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
        [self.imageViewCenter sd_setImageWithURL:[NSURL URLWithString:model.imglist[1]] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
        [self.imageViewRight sd_setImageWithURL:[NSURL URLWithString:model.imglist.lastObject] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
    }
    
    //强制布局
    [self layoutIfNeeded];
    //计算cell高度
    model.cellHeight = CGRectGetMaxY(self.delBtn.frame) + 10;
    
}


@end
