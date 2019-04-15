//
//  UIScrollView+MSRefresh.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/15.
//  Copyright © 2019 Liven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MSRefresh)


/**
 添加下拉刷新控件

 @param refreshingBlock block
 */
- (MJRefreshNormalHeader *)ms_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock;




/**
 添加上拉加载控件

 @param refreshingBlock block
 */
- (MJRefreshAutoNormalFooter *)ms_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock;

@end

NS_ASSUME_NONNULL_END
