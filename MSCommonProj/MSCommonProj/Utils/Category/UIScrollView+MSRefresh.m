//
//  UIScrollView+MSRefresh.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/15.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "UIScrollView+MSRefresh.h"

@implementation UIScrollView (MSRefresh)



/**
 添加下拉刷新控件
 
 @param refreshingBlock block
 */
- (MJRefreshNormalHeader *)ms_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock {
    __weak typeof(&*self) weakSelf = self;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __weak typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock?:refreshingBlock((MJRefreshNormalHeader *)strongSelf.mj_header);
    }];
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = mj_header;
    return mj_header;
}




/**
 添加上拉加载控件\
 
 @param refreshingBlock block
 */
- (MJRefreshAutoNormalFooter *)ms_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock {
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock?:refreshingBlock((MJRefreshAutoNormalFooter *)strongSelf.mj_footer);
    }];
    [mj_footer setTitle:@"我是有底线的" forState:MJRefreshStateNoMoreData];
    self.mj_footer = mj_footer;
    return mj_footer;
}

@end
