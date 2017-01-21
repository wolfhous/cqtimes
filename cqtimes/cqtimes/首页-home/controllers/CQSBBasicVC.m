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
#import "CQSBNewSingleType4Cell.h"

#import "CQSBNewsDetailVC.h"
@interface CQSBBasicVC ()<UITableViewDelegate,UITableViewDataSource>

/** 主表视图*/
@property (nonatomic,strong)UITableView *tableView;

/** 主表数据*/
@property (nonatomic,strong)NSMutableArray<CQSBNewsListModel *> *arrayNews;

/** 当前页数*/
@property (nonatomic,assign)NSInteger pageIndex;

/** 网络圈圈*/
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;

@end

@implementation CQSBBasicVC


static NSString *type1cellID = @"newSingleType1Cell";
static NSString *type2cellID = @"newSingleType2Cell";
static NSString *type3cellID = @"newSingleType3Cell";
static NSString *type4cellID = @"newSingleType4Cell";

-(NSMutableArray<CQSBNewsListModel *> *)arrayNews{
    if (!_arrayNews) {
        _arrayNews = [NSMutableArray array];
    }
    return _arrayNews;
}

-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        CGFloat w = 70;
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2, (SCREEN_HEIGHT-w)/2, w, w)];
        _activityIndicatorView.color = CQSBMainColor;
        [self.view addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //重写contentInset 就会附带穿透效果
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBNewSingleType1Cell" bundle:nil] forCellReuseIdentifier:type1cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBNewSingleType2Cell" bundle:nil] forCellReuseIdentifier:type2cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBNewSingleType3Cell" bundle:nil] forCellReuseIdentifier:type3cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"CQSBNewSingleType4Cell" bundle:nil] forCellReuseIdentifier:type4cellID];
        _tableView.mj_header  = [CQSBRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstData)];
        _tableView.mj_footer = [CQSBRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //开始转圈
    [self.activityIndicatorView startAnimating];
    //开始加载数据
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
    parameters[@"p"] = @(self.pageIndex);//页码
    [HS_Http hs_postAPIName:API_newsList parameters:parameters succes:^(id responseObject) {
        //解析模型
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
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        //刷新表格
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } error:^(id error) {
        //结束转圈
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;

        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrayNews[indexPath.row].modelstatusType == cellTypeRightImage) {//正常右侧图片
        CQSBNewSingleType2Cell *cell = [tableView dequeueReusableCellWithIdentifier:type2cellID];
        cell.model = self.arrayNews[indexPath.row];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        [cell.delBtn addTarget:self action:@selector(clickCellDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (self.arrayNews[indexPath.row].modelstatusType == cellTypeThreeImage){//一排三个图片
        CQSBNewSingleType3Cell *cell = [tableView dequeueReusableCellWithIdentifier:type3cellID];
        cell.model = self.arrayNews[indexPath.row];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        [cell.delBtn addTarget:self action:@selector(clickCellDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else if (self.arrayNews[indexPath.row].modelstatusType == cellTypeWord){//文字类型新闻
        CQSBNewSingleType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID];
        cell.model = self.arrayNews[indexPath.row];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        [cell.delBtn addTarget:self action:@selector(clickCellDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else if (self.arrayNews[indexPath.row].modelstatusType == cellTypeAD){//广告类型新闻
        CQSBNewSingleType4Cell *cell = [tableView dequeueReusableCellWithIdentifier:type4cellID];
        cell.model = self.arrayNews[indexPath.row];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        [cell.delBtn addTarget:self action:@selector(clickCellDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else if (self.arrayNews[indexPath.row].modelstatusType == cellTypeBigImage){//大图类型新闻
        CQSBNewSingleType4Cell *cell = [tableView dequeueReusableCellWithIdentifier:type4cellID];
        cell.model = self.arrayNews[indexPath.row];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        [cell.delBtn addTarget:self action:@selector(clickCellDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        DLog(@"其他新闻类型状态待确认 ====  【%ld】====",(long)self.arrayNews[indexPath.row].modelstatusType);
        DLog(@"标题===%@",self.arrayNews[indexPath.row].title);
        CQSBNewSingleType1Cell *cell = [tableView dequeueReusableCellWithIdentifier:type1cellID];
        cell.model = self.arrayNews[indexPath.row];
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        [cell.delBtn addTarget:self action:@selector(clickCellDelBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
#pragma mark - 点击删除某行新闻
-(void)clickCellDelBtn:(UIButton *)btn{
    //知识点：btn.superview 是 cell.contentView  再往上的superView才是cell
    NSIndexPath *indexPath =[self.tableView indexPathForCell:((UITableViewCell *)[[btn superview] superview])];
    DLog(@"删除==%ld",indexPath.row);
    [self.arrayNews removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}

#pragma mark 预估高度
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
#pragma mark 实际高度 （实际高度实现重点 1赋值模型数据就开始强制布局 2在awakeFromNib实现cell里面label的preferredMaxLayoutWidth最大宽度）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.arrayNews[indexPath.row].cellHeight;
}
#pragma mark 点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CQSBNewsDetailVC *vc = [CQSBNewsDetailVC new];
    vc.urlStr = self.arrayNews[indexPath.row].url;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
