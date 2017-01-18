//
//  HSManager.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/18.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "HSManager.h"
#import "Reachability.h"//1引入头文件，先设置info.plist里面的http请求为YES
static CGRect oldframe;
static CGRect originalFrame;
@implementation HSManager
/** 检测网络*/
+(void)hs_getExistenceNetwork{
    BOOL isExistenceNetwork = YES;//2定义一个布尔值判断有无网络
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];//3检测是否连接到某个网站
    switch ([reach currentReachabilityStatus]) {//4判断返回某个网络
        case NotReachable:
            isExistenceNetwork = NO;
            //            NSLog(@"NotReachable无网");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //            NSLog(@"WIFI网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //            NSLog(@"ReachableViaWWAN蜂窝数据");
            break;
        default:
            break;
    }
    if (isExistenceNetwork) {
        //        NSLog(@"有网");
    }else{
        NSLog(@"无网");
    }
}

/**检测网络，返回一个布尔值*/
+(BOOL)hs_isExistenceNetwork{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {//4判断返回某个网络
        case NotReachable:
            isExistenceNetwork = NO;
            //            NSLog(@"NotReachable无网");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //            NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //            NSLog(@"ReachableViaWWAN蜂窝数据");
            break;
        default:
            break;
    }
    if (isExistenceNetwork) {
        //        NSLog(@"有网");
        return YES;
    }else{
        //        NSLog(@"无网");
        return NO;
    }
}
+ (BOOL)hs_isPhone:(NSString *)phoneStr
{
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneStr];
}
+ (void)hs_showBigImage:(UIImageView *)selectedImageView
{
    UIImage *image=selectedImageView.image;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.tag = 100;
    //存储旧的frame
    oldframe = [selectedImageView convertRect:selectedImageView.bounds toView:window];
    
    originalFrame = oldframe;
    
    //创建灰色背景
    backgroundView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7];
    
    //[UIColor colorWithRed:0.3green:0.3blue:0.3alpha:0.7];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    
    //设置圆角
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 3.0f;
    
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    //添加拖拽和缩放手势
    imageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [imageView addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [imageView addGestureRecognizer:pan];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha = 1;
        originalFrame = oldframe = imageView.frame;
    }];
}

+ (void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = originalFrame;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
//缩放效果
+ (void)pinchAction:(UIPinchGestureRecognizer *)pinch
{
    UIImageView *imageView = (UIImageView *)pinch.view;
    //[imageView setTransform:CGAffineTransformMakeScale(pinch.scale, pinch.scale)];
    CGFloat width = oldframe.size.width*pinch.scale;
    CGFloat height = oldframe.size.height*pinch.scale;
    imageView.frame = CGRectMake(CGRectGetMidX(oldframe)-width/2, CGRectGetMidY(oldframe)-height/2, width, height);
    if (pinch.state == UIGestureRecognizerStateEnded) {
        oldframe = imageView.frame;
    }
}
//拖拽效果
+ (void)panAction:(UIPanGestureRecognizer *)pan
{
    UIImageView *imageView = (UIImageView *)pan.view;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [window viewWithTag:100];
    
    CGPoint oldPoint = imageView.center;
    CGPoint newPoint = [pan translationInView:backgroundView];
    imageView.center = CGPointMake(oldPoint.x+newPoint.x, oldPoint.y+newPoint.y);
    [pan setTranslation:CGPointZero inView:backgroundView];
    oldframe = imageView.frame;
}
+(NSString *)hs_getTimeForDataStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSLog(@"date:%@",[detaildate description]);
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

@end
