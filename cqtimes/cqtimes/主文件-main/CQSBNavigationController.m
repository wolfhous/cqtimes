//
//  CQSBNavigationController.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNavigationController.h"

//侧滑
#import "UINavigationController+FDFullscreenPopGesture.h"

#import "UINavigationBar+HSNavigationBar.h"
@interface CQSBNavigationController ()

@end

@implementation CQSBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //一句话添加侧滑返回功能
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled=YES;
    [self.navigationBar hs_hideShadowImage];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
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
