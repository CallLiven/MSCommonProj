//
//  MSTableViewModel.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSTableViewModel : MSViewModel

/* dataSource **/
@property (nonatomic, strong, readwrite) NSArray *dataSource;
/* 默认是UITableViewStylePlain **/
@property (nonatomic, assign, readwrite) UITableViewStyle style;
/* 是否需要支持下拉刷新 默认是NO **/
@property (nonatomic, assign, readwrite) BOOL shouldPullDownToRefresh;
/* 是否需要支持上拉加载 默认是NO **/
@property (nonatomic, assign, readwrite) BOOL shouldPullUpToLoadMore;
/* 是否多组显示，默认是NO **/
@property (nonatomic, assign, readwrite) BOOL shouldMultiSections;
/* 是否在上拉加载后的数据提示没有已加载完 默认是NO **/
@property (nonatomic, assign, readwrite) BOOL shouldEndRefreshingWithNoMoreData;
/* 当前页 默认是0 **/
@property (nonatomic, assign, readwrite) NSUInteger page;
/* 每一页的数量 默认是10 **/
@property (nonatomic, assign, readwrite) NSUInteger perPage;

/* 下拉刷新 **/
@property (nonatomic, strong, readwrite) RACSubject *refreshTableViewSubject;
/* 选中命令 **/
@property (nonatomic, strong, readwrite) RACCommand *didSelectedCommand;
/* 请求服务器数据的命令 **/
@property (nonatomic, strong, readonly) RACCommand *requestRemoteDataCommand;



/**
 获取本地数据

 */
- (id)fetchLocalData;



/**
 请求服务器数据

 @param page 页码
 */
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;


@end

NS_ASSUME_NONNULL_END
