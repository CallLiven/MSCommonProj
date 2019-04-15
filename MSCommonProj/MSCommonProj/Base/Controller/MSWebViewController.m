//
//  MSWebViewController.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/15.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSWebViewController.h"
#import "UIScrollView+MSRefresh.h"

@interface MSWebViewController ()
/* webView **/
@property (nonatomic, strong, readwrite) WKWebView *webView;
/* 进度条 **/
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
/* 返回按钮 **/
@property (nonatomic, strong, readwrite) UIBarButtonItem *backItem;
/* 关闭按钮 **/
@property (nonatomic, strong, readwrite) UIBarButtonItem *closeItem;
/* ViewModel **/
@property (nonatomic, strong, readwrite) MSWebViewModel *viewModel;
@end


@implementation MSWebViewController
@dynamic viewModel;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
    
    [self.webView loadRequest:self.viewModel.request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.leftBarButtonItem = self.backItem;
    // 注册JS
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    // 这里可以注册JS的处理
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    // 自适应屏幕宽度 js
    NSString *jsString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *userScript = [[WKUserScript alloc]initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加自适应屏幕js调用的方法
    [userContentController addUserScript:userScript];
    // 赋值userContentController
    configuration.userContentController = userContentController;
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:SCREEN_B configuration:configuration];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    
    self.webView = webView;
    [self.view addSubview:webView];
    
    // 添加刷新控件
    if (self.viewModel.shouldPullDownToRefresh) {
        @weakify(self);
        [self.webView.scrollView ms_addHeaderRefresh:^(MJRefreshNormalHeader * _Nonnull header) {
            @strongify(self);
            [self.webView reload];
        }];
    }
    
    self.webView.scrollView.contentInset = self.contentInset;
}


- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    [RACObserve(self.webView, estimatedProgress) subscribeNext:^(NSNumber *value) {
        @strongify(self)
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }];
}


#pragma makr - wkwebView Delegate
/* webView 内容开始返回时调用 **/
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (!self.viewModel.shouldDisableWebViewTitle) {
        self.navigationItem.title = self.viewModel.title;
    }
    
    if (self.viewModel.shouldDisableWebViewClose) {
        return;
    }
    
    UIBarButtonItem *backItem = self.navigationItem.leftBarButtonItems.firstObject;
    if (backItem) {
        if ([self.webView canGoBack]) {
            self.navigationItem.leftBarButtonItems = @[backItem,self.closeItem];
        }else{
            self.navigationItem.leftBarButtonItems = @[backItem];
        }
    }
}

/* webView 加载完成 **/
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.viewModel.shouldPullDownToRefresh) {
        [webView.scrollView.mj_header endRefreshing];
    }
}


/* webView 加载失败 **/
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (self.viewModel.shouldPullDownToRefresh) {
        [webView.scrollView.mj_header endRefreshing];
    }
}

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    // 解决点击网页的链接 不跳转的BUG
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


#pragma makr - action
- (void)closeItemDidClicked {
    // 判断 是Push 还是 Present 进来的
    if (self.presentingViewController) {
        [self.viewModel.services dismissViewModelAnimated:YES completion:nil];
    }else{
        [self.viewModel.services popViewModelAnimated:YES];
    }
}


- (void)backItemDidClicked {
    // 可以返回上一个j网页，就返回到上一个网页
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        // 不能返回上一个网页，就返回到上一个界面
        // 判断 是Push还是Present进来的
        if (self.presentingViewController) {
            [self.viewModel.services dismissViewModelAnimated:YES completion:nil];
        }else{
            [self.viewModel.services popViewModelAnimated:YES];
        }
    }
}

#pragma mark - getter && setter
- (UIProgressView *)progressView {
    if (!_progressView) {
        CGFloat progressViewW = SCREEN_W;
        CGFloat progressViewH = 3;
        CGFloat progressViewX = 0;
        CGFloat progressViewY = CGRectGetHeight(self.navigationController.navigationBar.frame) - progressViewH + 1;
        UIProgressView *progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(progressViewX, progressViewY, progressViewW, progressViewH)];
        progressView.progressTintColor = MS_Main_TinkColor;
        progressView.trackTintColor = [UIColor clearColor];
        _progressView = progressView;
    }
    return _progressView;
}

- (UIBarButtonItem *)backItem {
    if (!_backItem) {
        _backItem = [UIBarButtonItem ms_systemItemWithTitle:@"返回" titleColor:nil imageName:nil target:self selector:@selector(backItemDidClicked) textType:YES];
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        _closeItem = [UIBarButtonItem ms_systemItemWithTitle:@"关闭" titleColor:nil imageName:nil target:self selector:@selector(closeItemDidClicked) textType:YES];
    }
    return _closeItem;
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0);
}


- (void)dealloc {
    [self.webView stopLoading];
}


@end
