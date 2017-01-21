//
//  CQSBNewSingleType2Cell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/20.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  右侧图片类型

#import "CQSBNewSingleType2Cell.h"

@implementation CQSBNewSingleType2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - ((SCREEN_WIDTH - 40)/3 + 40);
    self.rightImageViewWidth.constant = (SCREEN_WIDTH - 40)/3;
    self.rightImageViewHeight.constant = (SCREEN_WIDTH - 40)/3 * 3/4;
}




-(void)setModel:(CQSBNewsListModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
    
    
    CGRect rectLabel = [model.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - ((SCREEN_WIDTH - 40)/3 + 40), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
    
    CGFloat leftHeight = rectLabel.size.height + 15 + 10 + 20 + 10;
    
    
    //强制布局
    [self layoutIfNeeded];
    //计算cell高度
    model.cellHeight = leftHeight > CGRectGetMaxY(self.rightImageView.frame) + 15 ? leftHeight:CGRectGetMaxY(self.rightImageView.frame) + 15;
  
}
@end
