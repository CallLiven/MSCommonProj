//
//  MSWebViewModel.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSWebViewModel : MSViewModel


/* web URl Request **/
@property (nonatomic, copy, readwrite) NSURLRequest *request;
/* 是否下拉刷新，默认是NO **/
@property (nonatomic, assign, readwrite) BOOL shouldPullDownToRefresh;
/* 是否取消导航栏的title等于WebView的title，默认是不取消 **/
@property (nonatomic, assign, readwrite) BOOL shouldDisableWebViewTitle;
/* 是否取消关闭按钮，默认是不取消 **/
@property (nonatomic, assign, readwrite) BOOL shouldDisableWebViewClose;


@end

NS_ASSUME_NONNULL_END
