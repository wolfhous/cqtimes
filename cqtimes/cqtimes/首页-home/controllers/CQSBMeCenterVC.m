//
//  CQSBMeCenterVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/8.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBMeCenterVC.h"
#import "CQSBLoginVC.h"
#define headerViewH 100

@interface CQSBMeCenterVC ()<UITableViewDelegate,UITableViewDataSource>
/**
 主表视图
 */
@property (nonatomic, strong) UITableView *tableView;

/**  
 头部视图 
 */
@property (nonatomic, strong) UIImageView *headerImageView;
/**
 标题数组
 */
@property (nonatomic, strong) NSArray *arrayTitles;

/**
 标题对应的图片数组
 */
@property (nonatomic, strong) NSArray *arrayImages;

@end

@implementation CQSBMeCenterVC

#pragma mark - 懒加载

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(headerViewH, 0, 0, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 60;
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


-(NSArray *)arrayTitles{
    if (!_arrayTitles) {
        _arrayTitles = @[@"我的评论",@"浏览历史",@"我的收藏",@"意见反馈",@"设置"];
    }
    return _arrayTitles;
}


-(NSArray *)arrayImages{
    if (!_arrayImages) {
        _arrayImages = @[@"icon2_33x33_",@"icon1_33x33_",@"icon3_33x33_",@"icon10_33x33_",@"icon9_33x33_"];
    }
    return _arrayImages;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加表视图
    [self.view addSubview:self.tableView];
    //设置用户头像 以及 登录按钮
    [self setupUserPhotoAndName];
}


-(void)setupUserPhotoAndName{
    //新建头像图层
    CGFloat w = 80;
    UIImageView *userPhoto = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - w)/2, -w-35, w, w)];
    [userPhoto sd_setImageWithURL:[NSURL URLWithString:[CQSB_UserSingleton sharedCQSB_UserSingleton].img] placeholderImage:[UIImage imageNamed:@"discover_unlogin_40x40_"]];
    [self.tableView addSubview:userPhoto];
    //判断有无登录，新建登录按钮
    if ([CQSB_UserSingleton sharedCQSB_UserSingleton].img == nil) {
        UIButton *btnLogin = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - w)/2, userPhoto.xmg_bottom, w, w/2)];
        btnLogin.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [btnLogin setTitle:@"点击登录" forState:UIControlStateNormal];
        [btnLogin setTitleColor:CQSBMainColor forState:UIControlStateNormal];
        [btnLogin addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:btnLogin];
    }
}

-(void)clickLoginBtn{
    CQSBLoginVC *loginVC = [CQSBLoginVC new];
    [self presentViewController:loginVC animated:YES completion:nil];
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCenterCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"meCenterCellID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    cell.textLabel.text = self.arrayTitles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.arrayImages[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = CQSBRandomColor;
    vc.jz_navigationBarBackgroundHidden = NO;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -headerViewH) {
        self.headerImageView.xmg_y = point.y;
        self.headerImageView.xmg_height = -point.y;
    }
}


@end
