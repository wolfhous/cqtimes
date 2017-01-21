//
//  CQSBNewsDetailVC.m
//  cqtimes
//
//  Created by 侯帅 on 2017/1/22.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "CQSBNewsDetailVC.h"

@interface CQSBNewsDetailVC()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;

/** 网络圈圈*/
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;
@end

@implementation CQSBNewsDetailVC

#pragma mark - 懒加载
-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        CGFloat w = 70;
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-w)/2, (SCREEN_HEIGHT-w)/2, w, w)];
        _activityIndicatorView.color = CQSBMainColor;
        [self.view addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        [self.view addSubview:self.webView];
    }
    return _webView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //开始转圈
    [self.activityIndicatorView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //结束转圈
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //结束转圈
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
}
@end
