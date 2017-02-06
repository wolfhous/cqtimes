//
//  CQSBDelCellView.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/6.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBDelCellView.h"

@interface popView:UIView


@end
@implementation popView

-(void)drawRect:(CGRect)rect{
    
}

@end




@interface CQSBDelCellView()

@property (nonatomic,strong)UIWindow *window;

@property (nonatomic,strong)UIView *bgView;
@end

@implementation CQSBDelCellView
-(UIWindow *)window{
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
        
    }
    return _window;
}

-(instancetype)initWithFrame:(CGRect)frame withPoint:(CGPoint)point withTites:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        //半透明背景
        [self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
        //点击背景隐藏
        self.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        //计算弹出视图 靠上还是靠下
        
        //绘制弹出视图
    }
    return self;
}


-(void)show{
    [self.window addSubview: self];
}


-(void)dismiss{
    [self removeFromSuperview];
}



@end
