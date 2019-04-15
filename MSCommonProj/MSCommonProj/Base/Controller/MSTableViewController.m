//
//  MSTableViewController.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSTableViewController.h"
#import "UIScrollView+MSRefresh.h"

@interface MSTableViewController ()<UITableViewDelegate,UITableViewDataSource>
/* tableView **/
@property (nonatomic, strong, readwrite) MSTableView *tableView;
/* 内容缩进 默认是UIEdgeInsetsMake(64,0,0,0) **/
@property (nonatomic, assign, readwrite) UIEdgeInsets contentInset;
/* viewModel **/
@property (nonatomic, strong, readonly) MSTableViewModel *viewModel;
@end


@implementation MSTableViewController

@dynamic viewModel;

/**
 init

 */
- (instancetype)initWithViewModel:(MSViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        if ([viewModel shouldRequestRemoteDataOnViewDidLoad]) {
            @weakify(self);
            [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
                @strongify(self);
                [self.viewModel.requestRemoteDataCommand execute:@(0)];
            }];
        }
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self ms_layoutSubViews];
}


- (void)bindViewModel {
    [super bindViewModel];
    
    @weakify(self)
    [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
    
    if (self.viewModel.shouldPullDownToRefresh) {
        [self.viewModel.refreshTableViewSubject subscribeNext:^(id x) {
           @strongify(self)
            [self.tableView.mj_header beginRefreshing];
        }];
    }
    
}


- (void)ms_layoutSubViews {
    MSTableView *tableView = [[MSTableView alloc]initWithFrame:self.view.bounds style:self.viewModel.style];
    tableView.backgroundColor = MS_Main_BackgroudColor;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = self.contentInset;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // 下拉刷新
    if (self.viewModel.shouldPullDownToRefresh) {
        @weakify(self)
        [self.tableView ms_addHeaderRefresh:^(MJRefreshNormalHeader * _Nonnull header) {
            @strongify(self)
            [self tableViewDidTriggerHeaderRefresh];
        }];
    }
    
    // 上拉加载
    if (self.viewModel.shouldPullUpToLoadMore) {
        @weakify(self)
        [self.tableView ms_addFooterRefresh:^(MJRefreshAutoNormalFooter * _Nonnull footer) {
           @strongify(self)
            [self tableViewDidTriggerFooterRefresh];
        }];
        
        RAC(self.tableView.mj_footer,hidden) = [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] map:^id(NSArray *dataSource) {
            @strongify(self)
            NSUInteger count = dataSource.count;
            if (count == 0) return @1;
            if (self.viewModel.shouldEndRefreshingWithNoMoreData) return @0;
            return (count % self.viewModel.perPage)?@1:@0;
        }];
    }
    
    
    if (@available(iOS 11.0,*)) {
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
}


#pragma mark - 上下拉事件
/**
 下拉刷新
 */
- (void)tableViewDidTriggerHeaderRefresh {
    @weakify(self)
    [[[self.viewModel.requestRemoteDataCommand execute:@0] deliverOnMainThread] subscribeNext:^(id x) {
       @strongify(self)
        self.viewModel.page = 0;
        if (self.viewModel.shouldEndRefreshingWithNoMoreData) {
            [self.tableView.mj_footer resetNoMoreData];
        }
    } error:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
    } completed:^{
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self requestDataCompleted];
    }];
    
    
}


/**
 上拉加载
 */
- (void)tableViewDidTriggerFooterRefresh {
    @weakify(self);
    [[[self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page + 1)] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.page += 1;
    } error:^(NSError *error) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
    } completed:^{
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        [self requestDataCompleted];
    }];
    
}


- (void)requestDataCompleted {
    NSUInteger count = self.viewModel.dataSource.count;
    if (self.viewModel.shouldEndRefreshingWithNoMoreData && count && self.viewModel.perPage) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark - tableView
/**
 reload tableView Data
 */
- (void)reloadData {
    [self.tableView reloadData];
}

- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0);
}

/**
 dequeueReusableCell
 
 @param tableView tableView
 @param identifier identifier
 @param indexPath indexPath
 */
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}


/**
 configure cell data
 
 @param cell cell
 @param indexPath indexPath
 @param object object
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
}



#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.viewModel.shouldMultiSections) {
        return self.viewModel.dataSource?self.viewModel.dataSource.count:0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.shouldMultiSections) {
        return [self.viewModel.dataSource[section] count];
    }
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    id object = nil;
    if (self.viewModel.shouldMultiSections) {
        object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    }
    if (!self.viewModel.shouldMultiSections) {
        object = self.viewModel.dataSource[indexPath.row];
    }
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    
    return cell;
}


#pragma makr - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectedCommand execute:indexPath];
}


- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
}

@end
