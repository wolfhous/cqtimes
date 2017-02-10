//
//  CQSBDiscoverCell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/24.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBDiscoverCell.h"
#import "CQSBDiscoverRowContain2View.h"//每行2个图片


@interface CQSBDiscoverCell()

/**
 每行2个图片主图
 */
@property (nonatomic,weak)CQSBDiscoverRowContain2View *rowContain2View;

@end


@implementation CQSBDiscoverCell


-(CQSBDiscoverRowContain2View *)rowContain2View{
    if (!_rowContain2View) {
        _rowContain2View = [CQSBDiscoverRowContain2View xmg_viewFromXib];
        [self.contentView addSubview:_rowContain2View];
    }
    return _rowContain2View;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //头像设置圆角
    self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.xmg_height/2;
    self.userPhotoImageView.layer.masksToBounds = YES;
}

//重写frame  在tableView有背景色的情况下，看出“分行”效果
-(void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    frame.size.height -= 10;
    [super setFrame:frame];
}



-(void)setModel:(CQSBDiscoverModel *)model{
    _model = model;
    //用户头像
    [self.userPhotoImageView sd_setImageWithURL:[NSURL URLWithString:model.userimg] placeholderImage:[UIImage imageNamed:@"discover_unlogin_40x40_"]];
    //用户名字
    self.userNameLabel.text = model.username;
    //时间
    self.addTimeLabel.text = [HSManager hs_getTimeForDataStr:model.addtime];
    //内容
    if (model.content.length > 0) {
        self.contentLabel.text = [NSString stringWithFormat:@"    %@",model.content];
    }else{
        self.contentLabel.text = model.content;
    }
    //标题
    self.titleLabel.text = model.title;
    //点赞数量
    [self.praiseBtn setTitle:model.praises forState:UIControlStateNormal];
    //评论数量
    [self.commentBtn setTitle:model.mainComments forState:UIControlStateNormal];
    //设置中间图片
    [self setupCenterContentWithImageArray:model.images];
    
    //强制布局
    [self layoutIfNeeded];
    model.cellHeight = self.centerBgView.xmg_bottom + 40 + 15;
}








//设置中间
-(void)setupCenterContentWithImageArray:(NSArray *)array{
    
    for (UIView *v in self.centerBgView.subviews) {
        [v removeFromSuperview];
    }
    //self.centerBgVie左右边距和
    CGFloat margin  = 15 * 2;
    
    if (array.count == 1) {
        //设置图片位置
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - margin, (SCREEN_WIDTH - margin) / [array.firstObject[@"ratio"] floatValue])];
        if (imageView.xmg_height > imageView.xmg_width*2) {
            imageView.xmg_height = imageView.xmg_width*2;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        //设置图片链接
        [imageView sd_setImageWithURL:[NSURL URLWithString:array.firstObject[@"path"]] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
        //添加图片
        [self.centerBgView addSubview:imageView];
        self.centerBgViewH.constant = imageView.xmg_height;
    }else if (array.count > 1){
        for (NSInteger i = 0; i < array.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [self.centerBgView addSubview:imageView];
            
            NSInteger lineNum = array.count > 4 ? 3 : 2;//每行几个
            CGFloat itemMargin = 10;//每个之间的间距
            
            CGFloat w = (SCREEN_WIDTH - margin - (lineNum - 1)*(itemMargin/2))/lineNum;
            CGFloat x = i % lineNum * (w + itemMargin/2);
            CGFloat y = i/lineNum * (w + itemMargin/2);
            imageView.frame = CGRectMake(x, y, w, w);
            //设置图片链接
            [imageView sd_setImageWithURL:[NSURL URLWithString:array[i][@"path"]] placeholderImage:[UIImage imageNamed:@"bigPlaceholder_414x193_"]];
            //设置高度
            self.centerBgViewH.constant = self.centerBgView.subviews.lastObject.xmg_bottom;
        }
    }else{
        DLog(@"没有图片");
        self.centerBgViewH.constant = 0;
    }
    
    
}










@end
