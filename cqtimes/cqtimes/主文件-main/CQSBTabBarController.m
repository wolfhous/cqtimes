//
//  CQSBTabBarController.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBTabBarController.h"
#import "CQSBTabBar.h"
#import "CQSBNavigationController.h"
#import "CQSBHomeVC.h"
#import "CQSBMeVC.h"
@interface CQSBTabBarController ()

@end

@implementation CQSBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
    /**** 更换tabbar ****/
    [self setValue:[CQSBTabBar new] forKey:@"tabBar"];
}
/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    
    [self setupOneChildViewController:[[CQSBNavigationController alloc]initWithRootViewController:[CQSBMeVC new]] title:@"发现" image:@"MyIconNormal_30x30_" selectedImage:@"MyIconHigh_30x30_"];
    [self setupOneChildViewController:[[CQSBNavigationController alloc]initWithRootViewController:[CQSBHomeVC new]] title:@"首页" image:@"HomeIconNormal_30x30_" selectedImage:@"HomeIconHigh_30x30_"];
}
/**
 *  初始化一个子控制器
 *
 *  @param vc            子控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    if (image.length) { // 图片名有具体值
        //渲染颜色
        vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self addChildViewController:vc];
}


@end

