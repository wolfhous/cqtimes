//
//  CQSBMeCenterVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/8.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBMeCenterVC.h"
#define headerViewH 100

@interface CQSBMeCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImageView;
@end

@implementation CQSBMeCenterVC



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(headerViewH, 0, 0, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView addSubview:self.headerImageView];
    }
    return _tableView;
}


-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -headerViewH, SCREEN_WIDTH, headerViewH)];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.image = [UIImage imageNamed:@"tableHeaderView"];
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCenterCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"meCenterCellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -headerViewH) {
        self.headerImageView.xmg_y = point.y;
        self.headerImageView.xmg_height = -point.y;
    }
}


@end
