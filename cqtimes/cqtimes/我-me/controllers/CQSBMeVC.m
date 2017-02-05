//
//  CQSBMeVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/5.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBMeVC.h"
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
/**
 最新数据
 */
@property (nonatomic,strong)NSMutableArray<CQSBDiscoverModel *> *arrayLatest;

/**
 最热数据
 */
@property (nonatomic,strong)NSMutableArray<CQSBDiscoverModel *> *arrayHot;

/**
 我的数据
 */
@property (nonatomic,strong)NSMutableArray<CQSBDiscoverModel *> *arraySelf;


@end

@implementation CQSBMeVC


static NSString *discoverCellID = @"discoverCell";
#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBDiscoverCell" bundle:nil] forCellReuseIdentifier:discoverCellID];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CQSBRandomColor;
    self.tableView.hidden = NO;
    //设置导航栏
    [self setupNavBar];
    //默认点击Segment
    [self clickNavCenterSegment:self.segment];
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
}


-(void)clickRightItem{
    DLogFunc
}
-(void)clickNavCenterSegment:(UISegmentedControl *)segment{
    DLog(@"点击UISegmentedControl索引 = %ld",(long)segment.selectedSegmentIndex);
    [self loadDataAPI_discover_Latest_Hot_Self];
}





-(void)loadDataAPI_discover_Latest_Hot_Self{
    
    HSParameters;
    
    NSString *api_url;
    if (self.segment.selectedSegmentIndex == 0) {
        api_url = API_discoverLatest;
    }else if (self.segment.selectedSegmentIndex == 1){
        api_url = API_discoverHot;
    }else{
        api_url = API_discoverSelf;
    }
    
    [HS_Http hs_postAPIName:api_url parameters:parameters succes:^(id responseObject) {
        DLog(@"%@",responseObject);
        
        if (self.segment.selectedSegmentIndex == 0) {
            
            self.arrayLatest = [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
        }else if (self.segment.selectedSegmentIndex == 1){
            self.arrayHot = [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        }else{
            self.arraySelf = [CQSBDiscoverModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

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
    cell.backgroundColor = CQSBRandomColor;
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
    return 200;
}


@end
