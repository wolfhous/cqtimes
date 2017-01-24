//
//  CQSBDiscoverCell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/24.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBDiscoverCell.h"

@implementation CQSBDiscoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.xmg_height/2;
    self.userPhotoImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)setModel:(CQSBDiscoverModel *)model{
    _model = model;
    //用户头像
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:model.userimg] placeholderImage:[UIImage imageNamed:@"discover_unlogin_40x40_"]];
    //用户名字
    self.userNameLabel.text = model.username;
    //内容
    self.addTimeLabel.text = [HSManager hs_getTimeForDataStr:model.addtime];
    //内容
    self.contentLabel.text = model.content;
    //点赞数量
    [self.praiseBtn setTitle:model.praises forState:UIControlStateNormal];
    //评论数量
    [self.commentBtn setTitle:model.mainComments forState:UIControlStateNormal];
    //设置中间图片
//    [self setupCenterContentWithImageArray:model.images];
    
    //强制布局
    [self layoutIfNeeded];
    model.cellHeight = 400;
}








//设置中间
-(void)setupCenterContentWithImageArray:(NSArray *)array{
    
    for (UIView *v in self.centerBgView.subviews) {
        [v removeFromSuperview];
    }
    
    if (array.count == 1) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, SCREEN_WIDTH *9/16)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array.firstObject[@"path"]] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
        [self.centerBgView addSubview:imageView];
        
    }else if (array.count == 2){
        
        
        
        
      
        
        
    }else if (array.count == 3){
        for (NSInteger i = 0; i < array.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH /2 - 2.5, SCREEN_WIDTH /2 - 2.5)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:array[i][@"path"]] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
            [self.centerBgView addSubview:imageView];
        }
    }else if (array.count == 4){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *4/4)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array.firstObject[@"path"]] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
        [self.centerBgView addSubview:imageView];
    }else if (array.count == 5){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *4/4)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array.firstObject[@"path"]] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
        [self.centerBgView addSubview:imageView];
    }else if (array.count == 6){
        
    }else if (array.count == 7){
        
    }else if (array.count == 8){
        
    }else if (array.count == 9){
        
    }
    
    
}










@end
