//
//  MSViewModel.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSViewModelServicesProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/* 传递webView request的key **/
FOUNDATION_EXTERN NSString *const MSViewModelWebRequestKey;


@interface MSViewModel : NSObject

/* 整个应用的服务层 **/
@property (nonatomic, strong, readonly) id<MSViewModelServicesProtocol> services;
/* 传参 **/
@property (nonatomic, strong, readonly) NSDictionary *params;
/* 标题 **/
@property (nonatomic, copy, readwrite) NSString *title;
/* 返回按钮标题 **/
@property (nonatomic, copy, readwrite) NSString *backTitle;
/* 当Push/Present时，通过block反向传值 **/
@property (nonatomic, copy  ,readwrite) VoidBlock_id callBlack;
/* view will Disappear **/
@property (nonatomic, strong, readonly) RACSubject *willDisappearSubject;
/* dealloc **/
@property (nonatomic, strong, readonly) RACSubject *deallocSubject;
/* viewModel初始化是，是否加载本地数据，默认是YES **/
@property (nonatomic, assign, readwrite) BOOL shouldFetchLocalDatOnViewModelInitialze;
/* viewDidLoad 是否要加载网络数据，默认是YES **/
@property (nonatomic, assign, readwrite) BOOL shouldRequestRemoteDataOnViewDidLoad;
/* 是否取消掉左滑pop到上一层的功能，默认是NO，不取消 **/
@property (nonatomic, assign, readwrite) BOOL interactivePopDisable;
/* 是否隐藏该控制器的导航栏，默认是不隐藏(NO) **/
@property (nonatomic, assign, readwrite) BOOL prefersNavigationBarHidden;
/* 是否隐藏该控制器导航栏底部的分割线，默认是不隐藏(NO) **/
@property (nonatomic, assign, readwrite) BOOL prefersNaviagtionBarBottomLineHidden;
/* 是否让IQKeyboardMananger管理键盘的事件，默认是YES **/
@property (nonatomic, assign, readwrite) BOOL keyboardEnable;
/* 是否键盘弹起的时候，点击其他区域隐藏，默认是YES **/
@property (nonatomic, assign, readwrite) BOOL shouldResignOnTouchOutSide;
/* 设置键盘与输入框的距离，默认是10 **/
@property (nonatomic, assign, readwrite) CGFloat keyboardDistanceFromTextField;


- (instancetype)initWithServices:(id<MSViewModelServicesProtocol>)services params:(NSDictionary *)params;

- (void)initialize;

@end

NS_ASSUME_NONNULL_END
