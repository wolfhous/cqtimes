//
//  CQSBHomeVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBHomeVC.h"
#import "CQSBHomeTitleBtn.h"
@interface CQSBHomeVC ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *titleScrollView;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)CQSBHomeTitleBtn *selectBtn;
@property (nonatomic,strong)UIView *indicateView;

@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation CQSBHomeVC


-(UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH - 40, 40)];
        _titleScrollView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:_titleScrollView];
    }
    return _titleScrollView;
}


-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        [_titleArray addObjectsFromArray:@[@"0",@"1",@"2"]];
    }
    return _titleArray;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CQSBRandomColor;
    //设置导航栏
    [self setupNavBar];
    //设置新闻分类栏目
    [self setupCQTimesCatogary];
//    //设置子控制器
//    [self setupChildVC];
//    //添加子控制器
//    [self addChildVcView];
}

-(void)setupNavBar{
    
}
-(void)setupCQTimesCatogary{
    
    self.titleScrollView.contentSize = CGSizeMake(self.titleArray.count * 40, self.titleScrollView.xmg_height);
    //标题按钮
    CGFloat w = 40;
    CGFloat h = self.titleScrollView.xmg_height - 1;
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        CQSBHomeTitleBtn *btn = [CQSBHomeTitleBtn buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        CGFloat x = i * w;
        btn.frame = CGRectMake(x, 0, w, h);
        [btn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
    }
    //首个选中按钮
    self.selectBtn = self.titleScrollView.subviews.firstObject;
    self.selectBtn.selected = YES;
    [self.selectBtn.titleLabel sizeToFit];
    
    //模拟指示线条
    UIView *indicateView = [[UIView alloc]init];
    self.indicateView = indicateView;
    indicateView.backgroundColor = CQSBMainColor;
    indicateView.xmg_y = h;
    indicateView.xmg_height = 1;
    indicateView.xmg_width = self.selectBtn.titleLabel.xmg_width;
    indicateView.xmg_centerX = self.selectBtn.center.x;
    [self.titleScrollView addSubview:indicateView];
    
}

//添加子控制器
-(void)setupChildVC{
    // 不允许自动调整scrollView的内边距
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置滚动视图
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.titleArray.count, SCREEN_HEIGHT);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //添加子控制器
    UIViewController *homeVC = [[UIViewController alloc]init];
    [self addChildViewController:homeVC];
    UIViewController *discoverVC = [[UIViewController alloc]init];
    [self addChildViewController:discoverVC];
    UIViewController *meVC = [[UIViewController alloc]init];
    [self addChildViewController:meVC];

}
#pragma mark - <UIScrollViewDelegate>
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    CQSBHomeTitleBtn *titleButton = self.titleScrollView.subviews[index];
    [self clickTitleBtn:titleButton];
    
    // 添加子控制器的view
    [self addChildVcView];
    
}
#pragma mark - 添加子控制器的view
- (void)addChildVcView{
    NSUInteger index = self.scrollView.contentOffset.x/self.scrollView.xmg_width;
    UIViewController *childVC = self.childViewControllers[index];
    if ([childVC isViewLoaded]) return;
    childVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVC.view];
}



#pragma mark - 事件
//点击导航标题
-(void)clickTitleBtn:(CQSBHomeTitleBtn *)btn{
    DLogFunc
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    //指示器动画
    [UIView animateWithDuration:0.2 animations:^{
        self.indicateView.xmg_width = btn.titleLabel.xmg_width;
        self.indicateView.xmg_centerX = btn.center.x;
    }];
    // 让UIScrollView滚动到对应位置
    CGPoint point = self.scrollView.contentOffset;
    point.x = btn.tag * self.scrollView.xmg_width;
    [self.scrollView setContentOffset:point animated:YES];
    
}





@end
