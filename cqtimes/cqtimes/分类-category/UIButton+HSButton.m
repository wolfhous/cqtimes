//
//  UIButton+HSButton.m
//  demo
//
//  Created by hou on 16/6/28.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "UIButton+HSButton.h"

@implementation UIButton (HSButton)
//======右角标=======
-(void)hs_buttonWithBadgeStr:(NSString *)str withColor:(UIColor *)color withBgColor:(UIColor *)bgColor withWidth:(CGFloat)width{
    UILabel *msgCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - width, 0, width, width)];
    msgCountLabel.text = str;
    msgCountLabel.textAlignment = NSTextAlignmentCenter;
    msgCountLabel.textColor = color;
    msgCountLabel.font = [UIFont systemFontOfSize:width-3];
    msgCountLabel.layer.cornerRadius = width/2;
    msgCountLabel.layer.masksToBounds = YES;
    msgCountLabel.backgroundColor = bgColor;
    [self addSubview:msgCountLabel];
}
-(void)setBadgeNumber:(NSString *)badgeNumber{
    UILabel *msgCountLabel = self.subviews[0];
    msgCountLabel.text = badgeNumber;
}
-(NSString *)badgeNumber{
    return self.badgeNumber;
}
-(void)setHideBadgeNumber:(BOOL)hideBadgeNumber{
    if (hideBadgeNumber) {
        [self.subviews[0] removeFromSuperview];
    }
}
-(BOOL)hideBadgeNumber{
    return self.hideBadgeNumber;
}

//======倒计时=======
- (void)hs_startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = mColor;
                [weakSelf setTitle:title forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.backgroundColor = color;
                [weakSelf setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                weakSelf.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

-(void)hs_setRoundRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize controlState:(UIControlState)controlState{
    
    
    if (controlState == 0 ) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
        if (textColor) {
            [self setTitleColor:textColor forState:controlState];
        }
        if (borderWidth && borderColor) {
            self.layer.borderColor = borderColor.CGColor;
            self.layer.borderWidth = borderWidth;
        }
        if (bgColor) {
            self.backgroundColor = bgColor;
        }
        if (fontSize) {
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
    }else if (UIControlStateSelected   == 1 << 2){
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
        if (textColor) {
            [self setTitleColor:textColor forState:controlState];
        }
        if (borderWidth && borderColor) {
            self.layer.borderColor = borderColor.CGColor;
            self.layer.borderWidth = borderWidth;
        }
        if (bgColor) {
            self.backgroundColor = bgColor;
        }
        if (fontSize) {
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
    }
}
-(void)hs_setRoundRadius:(CGFloat)radius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}
@end
