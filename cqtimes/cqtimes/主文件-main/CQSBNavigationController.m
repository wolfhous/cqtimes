//
//  CQSBNavigationController.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNavigationController.h"
#import "UINavigationBar+HSNavigationBar.h"
#import "JZNavigationExtension.h"//三方库 导航栏渐变效果 全屏侧滑返回功能
@interface CQSBNavigationController ()

@end

@implementation CQSBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //添加导航栏切换转场动画
//    self.jz_navigationBarTransitionStyle = JZNavigationBarTransitionStyleDoppelganger;
    //添加侧滑返回功能
    self.jz_fullScreenInteractivePopGestureEnabled = YES;
    //另外一种侧滑返回效果 如设置了jz_fullScreenInteractivePopGestureEnabled ，下面这行则无需设置。
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled=YES;
}

/**
 *  重写push方法的目的 : 拦截所有push进来的子控制器
 *
 *  @param viewController 刚刚push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果viewController不是最早push进来的子控制器
        // 左上角
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"IQButtonBarArrowLeft"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES; 
    }
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
