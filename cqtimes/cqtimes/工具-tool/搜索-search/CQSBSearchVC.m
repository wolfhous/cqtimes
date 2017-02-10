//
//  CQSBSearchVC.m
//  cqtimes
//
//  Created by 壹号商圈 on 17/2/10.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//  搜索控制器

#import "CQSBSearchVC.h"

@interface CQSBSearchVC ()<UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;
@end

@implementation CQSBSearchVC

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"github/wolfhous/cqtimes";
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
}

#pragma mark - UISearchBarDelegate
//开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = YES;
}
//点击取消搜索按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
