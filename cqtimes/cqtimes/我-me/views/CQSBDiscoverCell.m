//
//  CQSBDiscoverCell.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/24.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBDiscoverCell.h"
#import "MWPhotoBrowser.h"//照片浏览器
@interface CQSBDiscoverCell()<MWPhotoBrowserDelegate>
@end

@implementation CQSBDiscoverCell

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
    //性能有待调优....没有达到完全重用思想...
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
        //设置点击事件
        imageView.tag = 0;
        imageView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];
        [imageView addGestureRecognizer:tap];

        
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
            
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];
            [imageView addGestureRecognizer:tap];
            
            //设置高度
            self.centerBgViewH.constant = self.centerBgView.subviews.lastObject.xmg_bottom;
        }
    }else{
        DLog(@"没有图片");
        self.centerBgViewH.constant = 0;
    }
}

//点击图片浏览
-(void)clickImageView:(UIGestureRecognizer *)tap{
    //新建照片浏览器
    MWPhotoBrowser *bro = [[MWPhotoBrowser alloc]initWithDelegate:self];
    //初始位置
    [bro setCurrentPhotoIndex: tap.view.tag];
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *) tabBarVC.selectedViewController;
    //退出照片浏览器
    [nav pushViewController:bro animated:YES];
}


#pragma mark - MWPhotoBrowserDelegate

//返回一共有几张图片
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return self.model.images.count;
}
//对应的index对应的图片url
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    MWPhoto *p = [[MWPhoto alloc]initWithURL:[NSURL URLWithString:self.model.images[index][@"path"]]];
    return p;
}
//对应index对应的nav标题
- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
    return [NSString stringWithFormat:@"%ld/%ld",index + 1,self.model.images.count];
}



@end
