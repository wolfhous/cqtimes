//
//  CQSBNewSingleType4Cell.m
//  cqtimes
//
//  Created by 侯帅 on 2017/1/21.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  大图类型

#import "CQSBNewSingleType4Cell.h"

@implementation CQSBNewSingleType4Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
}


-(void)setModel:(CQSBNewsListModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    
    
    [self.imageViewBig sd_setImageWithURL:[NSURL URLWithString:model.imglist.firstObject] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
    self.imageViewBigHeight.constant = (SCREEN_WIDTH - 30) *9/16;

    //强制布局
    [self layoutIfNeeded];
    //计算cell高度
    model.cellHeight = CGRectGetMaxY(self.delBtn.frame) + 10;
    
}
@end
