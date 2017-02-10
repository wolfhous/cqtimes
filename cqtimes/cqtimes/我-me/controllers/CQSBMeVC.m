//
//  CQSBMeVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBMeVC.h"
#import "CQSBMeCenterVC.h"//个人中心
#import "CQSBSearchVC.h"//搜索
#import "UIBarButtonItem+HSExtension.h"
#import "CQSBDiscoverCell.h"
#import "CQSBDiscoverModel.h"
@interface CQSBMeVC ()<UITableViewDelegate,UITableViewDataSource>



/**
 分类选择segment
 */
@property (nonatomic,strong)UISegmentedControl *segment;
/**
 主表视图
 */
@property (nonatomic,strong)UITableView *tableView;
//=====最新数据=======
/**
 最新数据
 */
@property (nonatomic,strong)NSMutableArray<CQSBDiscoverModel *> *arrayLatest;

/**
 最新数据当前页码
 */
@property (nonatomic, assign)NSInteger pageLatest;

//=====最热数据=======
/**
 最热数据
 */
@property (nonatomic,strong)NSMutableArray<CQSBDiscoverModel *> *arrayHot;
/**
 最新数据当前页码
 */
@property (nonatomic, assign)NSInteger pageHot;
//=====我的数据=======
/**
 我的数据
 */
@property (nonatomic,strong)NSMutableArray<CQSBDiscoverModel *> *arraySelf;
/**
 最新数据当前页码
 */
@property (nonatomic, assign)NSInteger pageSelf;





@end

@implementation CQSBMeVC


static NSString *discoverCellID = @"discoverCell";
#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBDiscoverCell" bundle:nil] forCellReuseIdentifier:discoverCellID];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [CQSBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstDate)];
        _tableView.mj_footer = [CQSBRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSMutableArray<CQSBDiscoverModel *> *)arraySelf{
    if (!_arraySelf) {
        _arraySelf = [NSMutableArray array];
    }
    return _arraySelf;
}
-(NSMutableArray<CQSBDiscoverModel *> *)arrayHot{
    if (!_arrayHot) {
        _arrayHot = [NSMutableArray array];
    }
    return _arrayHot;
}
-(NSMutableArray<CQSBDiscoverModel *> *)arrayLatest{
    if (!_arrayLatest) {
        _arrayLatest = [NSMutableArray array];
    }
    return _arrayLatest;
}
-(NSInteger)pageLatest{
    if (!_pageLatest) {
        _pageLatest = 1;
    }
    return _pageLatest;
}
-(NSInteger)pageHot{
    if (!_pageHot) {
        _pageHot = 1;
    }
    return _pageHot;
}
-(NSInteger)pageSelf{
    if (!_pageSelf) {
        _pageSelf = 1;
    }
    return _pageSelf;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CQSBRandomColor;
    self.jz_navigationBarBackgroundAlpha = 1.f;//重要！！必须设置当前控制器的透明度为1，否则从一个其他颜色的navbar控制器返回到当前控制器时候，当前控制器navbar颜色不会改变！
    self.tableView.hidden = NO;
    //设置导航栏
    [self setupNavBar];
    //默认点击Segment
    [self clickNavCenterSegment:self.segment];
    
    

}
//下拉刷新 重新加载首页
-(void)loadFirstDate{
    if (self.segment.selectedSegmentIndex == 0) {
        self.pageLatest = 1;
    }else if (self.segment.selectedSegmentIndex == 1){
        self.pageHot = 1;
    }else{
        self.pageSelf = 1;
    }
    [self loadDataAPI_discover_Latest_Hot_Self];
}
//上拉刷新 加载更多
-(void)loadMoreDate{
    if (self.segment.selectedSegmentIndex == 0) {
        self.pageLatest ++;
    }else if (self.segment.selectedSegmentIndex == 1){
        self.pageHot ++;
    }else{
        self.pageSelf ++;
    }
    [self loadDataAPI_discover_Latest_Hot_Self];
}


-(void)setupNavBar{
    //左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"discover_unlogin_40x40_" highImage:@"discover_unlogin_40x40_" target:self action:@selector(clickLeftItem)];
    //中间按钮
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@" 最 新 ",@" 最 热 ",@"我"]];
    self.segment.tintColor = CQSBMainColor;
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(clickNavCenterSegment:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
    //右侧侧按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem hs_itemWithImage:@"网页搜索_29x29_" highImage:@"网页搜索_29x29_" target:self action:@selector(clickRightItem)];
    
}

-(void)clickLeftItem{
    DLogFunc
    CQSBMeCenterVC *vc = [CQSBMeCenterVC new];
    vc.jz_navigationBarBackgroundHidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)clickRightItem{
    DLogFunc
    CQSBSearchVC *vc = [CQSBSearchVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)clickNavCenterSegment:(UISegmentedControl *)segment{
    DLog(@"点击UISegmentedControl索引 = %ld",(long)segment.selectedSegmentIndex);
    //解决切换时候重复加载问题  如果数组有数据，就不再加载😝
    if (self.segment.selectedSegmentIndex == 0) {
        if (self.arrayLatest.count > 0) {
            [self.tableView reloadData];
            return;
        }
    }else if (self.segment.selectedSegmentIndex == 1){
        if (self.arrayHot.count > 0) {
            [self.tableView reloadData];
            return;
        }
    }else{
        if (self.arraySelf.count > 0) {
            [self.tableView reloadData];
            return;
        }
    }
    [self loadDataAPI_discover_Latest_Hot_Self];
}





-(void)loadDataAPI_discover_Latest_Hot_Self{
    HSParameters;
    NSString *api_url;
    if (self.segment.selectedSegmentIndex == 0) {
        api_url = API_discoverLatest;
        parameters[@"page"] = @(self.pageLatest);
    }else if (self.segment.selectedSegmentIndex == 1){
        api_url = API_discoverHot;
        parameters[@"page"] = @(self.pageHot);
    }else{
        api_url = API_discoverSelf;
        parameters[@"page"] = @(self.pageSelf);
    }
    //我曹，这么坑的接口，害得我调试半小时！！！！！   post还不给面子，必须get 我晕了~~
    [HS_Http hs_getAPIName:api_url parameters:parameters succes:^(id responseObject) {
        DLog(@"%@",responseObject);
        
        if (self.segment.selectedSegmentIndex == 0) {
            if (self.pageLatest == 1) {
                self.arrayLatest = [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }else{
                [self.arrayLatest addObjectsFromArray:[CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            }
            
        }else if (self.segment.selectedSegmentIndex == 1){
            if (self.pageHot == 1) {
                self.arrayHot = [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }else{
                [self.arrayHot addObjectsFromArray: [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            }
        }else{
            if (self.pageSelf == 1) {
                self.arraySelf = [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }else{
                [self.arraySelf addObjectsFromArray: [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            }
        }
        
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
    } error:^(id error) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}







#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.segment.selectedSegmentIndex == 0) {
        return self.arrayLatest.count;
    }else if (self.segment.selectedSegmentIndex == 1){
        return self.arrayHot.count;
    }else{
        return self.arraySelf.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CQSBDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:discoverCellID];
    if (self.segment.selectedSegmentIndex == 0) {
        cell.model = self.arrayLatest[indexPath.row];
    }else if (self.segment.selectedSegmentIndex == 1){
        cell.model = self.arrayHot[indexPath.row];
    }else{
        cell.model = self.arraySelf[indexPath.row];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segment.selectedSegmentIndex == 0) {
        return self.arrayLatest[indexPath.row].cellHeight;
    }else if (self.segment.selectedSegmentIndex == 1){
        return self.arrayHot[indexPath.row].cellHeight;
    }else{
        return self.arraySelf[indexPath.row].cellHeight;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 5201314-5201014;//我爱你一生一世😍 程序员也需要有自娱自乐的精神是不
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
