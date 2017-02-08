//
//  CQSBDelCellView.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBDelCellView.h"

@interface popView:UIView

//箭头点参考位置
@property (nonatomic,assign)CGPoint pointArrow;
//箭头是否朝下 默认朝上
@property (nonatomic,assign)BOOL isArrowDown;
@end
@implementation popView

-(void)drawRect:(CGRect)rect{
    // 1.创建bezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    //半径
    CGFloat radius = 10;
    //上边距
    CGFloat topM = 20;
    // 2.设计圆弧
    if (self.isArrowDown == NO) {
        //默认箭头朝上
        [path addArcWithCenter:CGPointMake(radius, radius + topM) radius:radius startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        //箭头
        [path addLineToPoint:CGPointMake(self.pointArrow.x - 10, topM)];
        [path addLineToPoint:CGPointMake(self.pointArrow.x , topM - 10)];
        [path addLineToPoint:CGPointMake(self.pointArrow.x +1 , topM)];
        
        [path addArcWithCenter:CGPointMake(rect.size.width - radius, radius + topM) radius:radius startAngle:M_PI_2*3 endAngle:0 clockwise:YES];
        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - radius)];
        
        [path addArcWithCenter:CGPointMake(rect.size.width - radius, rect.size.height - radius) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [path addLineToPoint:CGPointMake(radius, rect.size.height)];
        
        [path addArcWithCenter:CGPointMake(radius, rect.size.height - radius) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [path addLineToPoint:CGPointMake(0, radius + topM)];
    }else{
        //箭头朝下
        [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
        [path addArcWithCenter:CGPointMake(rect.size.width - radius, radius) radius:radius startAngle:M_PI_2*3 endAngle:0 clockwise:YES];
        [path addArcWithCenter:CGPointMake(rect.size.width - radius, rect.size.height - radius - topM) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        //箭头
        [path addLineToPoint:CGPointMake(self.pointArrow.x - 1, rect.size.height - topM)];
        [path addLineToPoint:CGPointMake(self.pointArrow.x , rect.size.height - topM + 10)];
        [path addLineToPoint:CGPointMake(self.pointArrow.x - 10, rect.size.height - topM)];

        [path addArcWithCenter:CGPointMake(radius, rect.size.height - radius - topM) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    // 3.填充颜色
    [[UIColor whiteColor] setFill];
    //4.绘制颜色
    [[UIColor clearColor] setStroke];
    //5.线条宽度
    path.lineWidth = 1;
    //6.绘制
    [path stroke];
    //7.开始填充颜色
    [path fill];
}
@end

@interface CQSBDelCellView()
//系统window
@property (nonatomic,strong)UIWindow *window;
//箭头点参考位置
@property (nonatomic,assign)CGPoint pointArrow;
//弹出视图
@property (nonatomic,strong)popView *my_popView;

@end

@implementation CQSBDelCellView
-(UIWindow *)window{
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
    }
    return _window;
}

-(instancetype)initWithFrame:(CGRect)frame withPoint:(CGPoint)point withTites:(NSArray *)titles withIndexPath:(NSIndexPath*)indexpath withDelegate:(id)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        self.indexPath = indexpath;
        //半透明背景
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        //点击背景隐藏
        self.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        //设置弹出视图
        self.pointArrow = point;
        self.my_popView = [[popView alloc]initWithFrame:CGRectMake(self.pointArrow.x, self.pointArrow.y, CGFLOAT_MIN, CGFLOAT_MIN)];
        //根据高度计算箭头朝向
        CGFloat popViewH = ((titles.count + 1) / 2  * 35) + 70;
        if (self.pointArrow.y + 5 + popViewH > SCREEN_HEIGHT - 20) {
            //赋值箭头朝向 默认为朝上 如果不足以显示，就朝下
            self.my_popView.isArrowDown = YES;
        }
        self.my_popView.pointArrow = self.pointArrow;
        self.my_popView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.my_popView];
        //弹出动画
        [UIView animateWithDuration:0.2 animations:^{
            //设置弹出视图
            if (self.my_popView.isArrowDown == YES) {
                self.my_popView.frame = CGRectMake(5, self.pointArrow.y - 5 - popViewH + 20, SCREEN_WIDTH - 10, popViewH);
            }else{
                self.my_popView.frame = CGRectMake(5, self.pointArrow.y + 5, SCREEN_WIDTH - 10, popViewH);
            }
        } completion:^(BOOL finished) {
            //屏蔽label
            UILabel *label = [[UILabel alloc]init];
            label.text = @"可选理由，精准屏蔽";
            label.xmg_x = 10;
            label.xmg_y = 33;
            [label sizeToFit];
            label.font = [UIFont systemFontOfSize:14];
            [self.my_popView addSubview:label];
            
            //不感兴趣大按钮
            UIButton *rightbtn = [UIButton buttonWithType:0];
            [self.my_popView addSubview:rightbtn];
            rightbtn.layer.masksToBounds = YES;
            rightbtn.layer.cornerRadius = 14;
            [rightbtn setBackgroundColor:CQSBMainColor];
            [rightbtn setTitle:@"不感兴趣" forState:UIControlStateNormal];
            rightbtn.frame = CGRectMake(self.my_popView.xmg_width - 110 , 30, 90, 28);
            [rightbtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            //循环添加屏蔽理由按钮
            for (NSInteger i = 0; i < titles.count; i ++) {
                UIButton *btn = [UIButton buttonWithType:0];
//                [btn setBackgroundColor:CQSBRandomColor];
                [btn setTitle:titles[i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = 5;
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = [UIColor grayColor].CGColor;
                [self.my_popView addSubview:btn];
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                //间距
                CGFloat margin = 10;
                //每一行个数
                NSInteger lineNum = 2;
                CGFloat w = (self.my_popView.xmg_width - (margin * (lineNum + 1)))/lineNum;
                CGFloat h = 30;
                CGFloat x = (i % lineNum * (w + margin)) + margin;
                CGFloat y = (i / lineNum * (h + 5)) + 64;
                btn.frame = CGRectMake(x, y, w, h);
            }
            //假如是箭头向下，则子控件整体上移20
            if (self.my_popView.isArrowDown == YES) {
                for (UIView *view in self.my_popView.subviews) {
                    view.xmg_y -= 20;
                }
            }
            
        }];
    }
    return self;
}


-(void)show{
    [self.window addSubview: self];
}


-(void)dismiss{
    [self.my_popView removeFromSuperview];
    [self removeFromSuperview];
}



-(void)clickBtn:(UIButton *)btn{
    DLog(@"当前屏蔽理由：%@",btn.currentTitle);
    [self dismiss];
    if ([btn.currentTitle isEqualToString:@"不感兴趣"]) {
        [self.delegate CQSBDelCellViewDelegate_ClickBtnIndex:btn.tag withIndexPath:self.indexPath];
    }else{
        [self.delegate CQSBDelCellViewDelegate_ClickBtnIndex:btn.tag withIndexPath:self.indexPath];
    }
    
}


@end
