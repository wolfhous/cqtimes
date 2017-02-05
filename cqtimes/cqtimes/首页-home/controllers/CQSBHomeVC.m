//
//  CQSBHomeVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBHomeVC.h"
#import "CQSBHomeTitleBtn.h"
#import "CQSBBasicVC.h"
#import "CQSBNewsTypeVC.h"
#import "UIBarButtonItem+HSExtension.h"


#import "CQSBNewsTypeModel.h"
@interface CQSBHomeVC ()<UIScrollViewDelegate>
//标题滚动视图
@property (nonatomic,strong)UIScrollView *titleScrollView;
//标题按钮
@property (nonatomic,strong)CQSBHomeTitleBtn *selectBtn;
//标题下滑块指示器
@property (nonatomic,strong)UIView *indicateView;
//主滚动视图
@property (nonatomic,strong)UIScrollView *scrollView;

/**
 主类型数组（标题数组）
 */
@property (nonatomic,strong)NSMutableArray<CQSBNewsTypeModel *> *arrayNewstype;
@end

@implementation CQSBHomeVC
#pragma mark - 懒加载
-(NSMutableArray<CQSBNewsTypeModel *> *)arrayNewstype{
    if (!_arrayNewstype) {
        _arrayNewstype = [NSMutableArray array];
    }
    return _arrayNewstype;
}

-(UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.bounces = NO;
        
        self.navigationItem.titleView = _titleScrollView;
//        [self.view addSubview:_titleScrollView];
    }
    return _titleScrollView;
}








- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //加载数据
    [self loadHomeAPI_newstype];
    
    
}

-(void)setupNavBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"discover_unlogin_40x40_" highImage:@"discover_unlogin_40x40_" target:self action:@selector(clickLeftItem)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"extraBtnBackgroundImage_21x21_" highImage:@"extraBtnBackgroundImage_21x21_" target:self action:@selector(clickRightItem)];
}

//点击左侧按钮
-(void)clickLeftItem{
    DLogFunc
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = CQSBRandomColor;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//点击右侧按钮
-(void)clickRightItem{
    DLogFunc
    CQSBNewsTypeVC *vc= [CQSBNewsTypeVC new];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}
-(void)setupCQTimesCatogary{
    //指示器高度
    CGFloat indicateViewHeight = 2;
    
    //标题按钮
    CGFloat h = self.titleScrollView.xmg_height - indicateViewHeight;
    CQSBHomeTitleBtn *lastBtn;
    for (NSInteger i = 0; i < self.arrayNewstype.count; i++) {
        CQSBHomeTitleBtn *btn = [CQSBHomeTitleBtn buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:self.arrayNewstype[i].title forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.xmg_x = lastBtn.xmg_right + 5;
        btn.xmg_y = 0;
        btn.xmg_height = h;
        [btn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:btn];
        lastBtn = btn;
    }
    self.titleScrollView.contentSize = CGSizeMake(lastBtn.xmg_right, 40);
    //首个选中按钮
    self.selectBtn = self.titleScrollView.subviews.firstObject;
    self.selectBtn.selected = YES;
    [self.selectBtn.titleLabel sizeToFit];
    
    //模拟指示线条
    UIView *indicateView = [[UIView alloc]init];
    self.indicateView = indicateView;
    indicateView.backgroundColor = CQSBMainColor;
    indicateView.xmg_y = h;
    indicateView.xmg_height = indicateViewHeight;
    indicateView.xmg_width = self.selectBtn.titleLabel.xmg_width;
    indicateView.xmg_centerX = self.selectBtn.center.x;
    [self.titleScrollView addSubview:indicateView];
}

//添加子控制器
-(void)setupChildVC{
    //设置滚动视图
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.arrayNewstype.count, SCREEN_HEIGHT);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //添加子控制器
    for (NSInteger i = 0; i < self.arrayNewstype.count; i ++) {
        CQSBBasicVC *vc = [CQSBBasicVC new];
        //event_id 和 type 似乎 是一个值
        vc.type = self.arrayNewstype[i].newstype_id;
        vc.event_id = self.arrayNewstype[i].newstype_id;
        vc.event_value = self.arrayNewstype[i].title;
        [self addChildViewController:vc];
    }
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


//加载数据
-(void)loadHomeAPI_newstype{
    HSParameters;
    [HS_Http hs_postAPIName:API_newstype parameters:parameters succes:^(id responseObject) {
        //解析模型
        self.arrayNewstype = [CQSBNewsTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"postlist"]];
        //设置导航栏
        [self setupNavBar];
        //设置新闻分类栏目
        [self setupCQTimesCatogary];
        //设置子控制器
        [self setupChildVC];
        //添加子控制器
        [self addChildVcView];
        
//        DLog(@"====%lf",self.titleScrollView.frame.size.width);
//        
//        DLog(@"====%lf",self.navigationItem.titleView.frame.size.width);
//        
//        DLog(@"====%lf",SCREEN_WIDTH);
        
    } error:^(id error) {
        
    }];
}


@end
