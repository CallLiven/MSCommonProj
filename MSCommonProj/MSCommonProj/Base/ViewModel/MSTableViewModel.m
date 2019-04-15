
//
//  MSTableViewModel.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSTableViewModel.h"

@interface MSTableViewModel()
/* 请求服务器数据的命令 **/
@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;
@end



@implementation MSTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 0;
    self.perPage = 10;
    
    self.requestRemoteDataCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSNumber *page) {
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
}


- (id)fetchLocalData {
    return nil;
}


- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}



- (RACSubject *)refreshTableViewSubject {
    if (!_refreshTableViewSubject) {
        _refreshTableViewSubject = [RACSubject subject];
    }
    return _refreshTableViewSubject;
}


@end
