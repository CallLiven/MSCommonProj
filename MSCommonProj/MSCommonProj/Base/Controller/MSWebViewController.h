//
//  MSWebViewController.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/15.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSViewController.h"
#import "MSWebViewModel.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSWebViewController : MSViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

/* webView **/
@property (nonatomic, strong, readonly) WKWebView *webView;
/* 内容缩进 默认（64,0,0,0） **/
@property (nonatomic, assign, readonly) UIEdgeInsets contentInset;

@end

NS_ASSUME_NONNULL_END
