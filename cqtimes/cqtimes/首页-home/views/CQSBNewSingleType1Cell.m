//
//  CQSBNewSingleType1Cell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  文本类型新闻

#import "CQSBNewSingleType1Cell.h"

@implementation CQSBNewSingleType1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(CQSBNewsListModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;

    //强制布局
    [self layoutIfNeeded];
    //计算cell高度
    model.cellHeight = CGRectGetMaxY(self.delBtn.frame) + 10;
}
@end
