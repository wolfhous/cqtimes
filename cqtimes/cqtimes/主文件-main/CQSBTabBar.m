//
//  CQSBTabBar.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/17.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBTabBar.h"
#import "UIImage+Image.h"
#import "CQSBPushHomeVC.h"
//===============自定义中间按钮 begin==============
@interface tabBarCenterBtn : UIButton
@end
@implementation tabBarCenterBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"send_80x80_"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"send_80x80_"] forState:UIControlStateHighlighted];
        self.xmg_size = self.currentBackgroundImage.size;
        [self setTitle:@"发布" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.xmg_centerY += 15;
}
//设置按钮点击可用相应的点击区域
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL res = [super pointInside:point withEvent:event];
    if (res) {
        //绘制一个圆形path 以自己的边界大小绘制一个圆
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        if ([path containsPoint:point]) {
            //如果在path区域内，返回YES
            return YES;
        }
        return NO;
    }
    
    return res;
}
@end
//===============自定义中间按钮 begin==============



@interface CQSBTabBar ()
/**
 声明一个中间按钮属性
 */
@property (nonatomic,strong)tabBarCenterBtn *centerBtn;
@end


@implementation CQSBTabBar
//懒加载中间按钮
-(UIButton *)centerBtn{
    if (!_centerBtn) {
        _centerBtn = [tabBarCenterBtn buttonWithType:0];
        [_centerBtn addTarget:self action:@selector(clickCenterBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerBtn];
    }
    return _centerBtn;
}

//重写init方法  设置背景颜色
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景白色
//        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
//        [self setBackgroundImage:[UIImage imageNamed:@"compose_toolbar_background"]];
    }
    return self;
}


//重写布局子控件方法
-(void)layoutSubviews{
    [super layoutSubviews];
    /**** 按钮的尺寸 ****/
    CGFloat buttonW = self.xmg_width / 3;
    CGFloat buttonH = self.xmg_height;
    
    /**** 设置所有UITabBarButton的frame ****/
    CGFloat tabBarButtonY = 0;
    // 按钮索引
    int tabBarButtonIndex = 0;
    
    for (UIView *subView in self.subviews) {
        if (![subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        // 设置frame
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        if (tabBarButtonIndex >= 1) { // 右边的UITabBarButton
            tabBarButtonX += buttonW;
        }
        subView.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        // 增加索引
        tabBarButtonIndex++;
    }
    
    /**** 设置中间的发布按钮的frame ****/
    self.centerBtn.xmg_centerX = self.xmg_width * 0.5;
    self.centerBtn.xmg_centerY = self.xmg_height * 0.5 - 9;
    
}
//点击中间按钮事件
-(void)clickCenterBtn{
    DLogFunc
    
    
    UITabBarController *tabbarVC = (UITabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    
    CQSBPushHomeVC *vc = [[CQSBPushHomeVC alloc]init];
    
    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [tabbarVC presentViewController:vc animated:YES completion:^{
       
    }];
    
    
}


//重写hitTest方法，去监听中间按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //判断当前手指是否点击到中间按钮上，如果是，则响应按钮点击，其他则系统处理
    //首先判断当前View是否被隐藏了，隐藏了就不需要处理了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到中间按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.centerBtn];
        
        //判断如果这个新的点是在中间按钮身上，那么处理点击事件最合适的view就是中间按钮
        if ( [self.centerBtn pointInside:newP withEvent:event]) {
            return self.centerBtn;
        }
    }
    
    return [super hitTest:point withEvent:event];
}

@end
