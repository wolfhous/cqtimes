//
//  CQSBBasicVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/1/7.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBBasicVC.h"
#import "CQSBNewsListModel.h"
#import "CQSBNewSingleType1Cell.h"
#import "CQSBNewSingleType2Cell.h"
#import "CQSBNewSingleType3Cell.h"
@interface CQSBBasicVC ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tableView;


@property (nonatomic,strong)NSMutableArray<CQSBNewsListModel *> *arrayNews;


@property (nonatomic,assign)NSInteger pageIndex;

@end

@implementation CQSBBasicVC


static NSString *type1cellID = @"newSingleType1Cell";
static NSString *type2cellID = @"newSingleType2Cell";
static NSString *type3cellID = @"newSingleType3Cell";

-(NSMutableArray<CQSBNewsListModel *> *)arrayNews{
    if (!_arrayNews) {
        _arrayNews = [NSMutableArray array];
    }
    return _arrayNews;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBNewSingleType1Cell" bundle:nil] forCellReuseIdentifier:type1cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBNewSingleType2Cell" bundle:nil] forCellReuseIdentifier:type2cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBNewSingleType3Cell" bundle:nil] forCellReuseIdentifier:type3cellID];
        _tableView.mj_header  = [CQSBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
        _tableView.mj_footer = [CQSBRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CQSBRandomColor;
    [self.view addSubview:self.tableView];
    [self loadFirstData];
}

-(void)loadFirstData{
    self.pageIndex = 1;
    [self loadDataAPI_newsList];
}

-(void)loadMoreData{
    self.pageIndex ++;
    [self loadDataAPI_newsList];
    
}

-(void)loadDataAPI_newsList{
    HSParameters;
    
    parameters[@"event_id"] = self.event_id;//event_id 和 type 似乎 是一个值
    parameters[@"event_value"] = self.event_value;//新闻分类文字
    parameters[@"newstype_type"] = @"1";//似乎都是1
    parameters[@"type"] = self.type;//event_id 和 type 似乎 是一个值
    
    [HS_Http hs_postAPIName:API_newsList parameters:parameters succes:^(id responseObject) {
        DLog("%@",responseObject);      
//        NSDictionary *dic = (NSDictionary *)responseObject;
//        [dic writeToFile:@"/Users/yihaoshangquan/Desktop/plist文件/cqsb_newsList.plist" atomically:YES];
        NSArray *array = [CQSBNewsListModel mj_objectArrayWithKeyValuesArray:responseObject[@"post_first"]];
        
        if (self.pageIndex == 1 ) {
            if (array.count > 0) {
                [self.arrayNews removeAllObjects];
                [self.arrayNews addObjectsFromArray:array];
            }
        }else{
            if (array.count > 0) {
                [self.arrayNews addObjectsFromArray:array];
            }else{
                DLog(@"下拉刷新无更多数据");
                self.pageIndex --;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.arrayNews[indexPath.row].modelstatus isEqualToString:@"1"]) {//正常右侧图片
        CQSBNewSingleType2Cell *cell = [tableView dequeueReusableCellWithIdentifier:type2cellID forIndexPath:indexPath];
        cell.model = self.arrayNews[indexPath.row];
        return cell;

    }else if ([self.arrayNews[indexPath.row].modelstatus isEqualToString:@"3"]){//一排三个图片
        CQSBNewSingleType3Cell *cell = [tableView dequeueReusableCellWithIdentifier:type3cellID forIndexPath:indexPath];
        cell.model = self.arrayNews[indexPath.row];
        return cell;

    }else if ([self.arrayNews[indexPath.row].modelstatus isEqualToString:@"4"]){//文字类型新闻
        CQSBNewSingleType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID forIndexPath:indexPath];
        cell.model = self.arrayNews[indexPath.row];
        return cell;

    }else{
        DLog(@"其他新闻类型状态待确认 ====  【%@】====",self.arrayNews[indexPath.row].modelstatus);
        CQSBNewSingleType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID forIndexPath:indexPath];
        cell.model = self.arrayNews[indexPath.row];
        return cell;

    }
 
}








@end
