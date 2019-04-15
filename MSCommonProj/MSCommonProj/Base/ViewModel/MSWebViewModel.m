//
//  MSWebViewModel.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSWebViewModel.h"


@implementation MSWebViewModel

- (instancetype)initWithServices:(id<MSViewModelServicesProtocol>)services params:(NSDictionary *)params {
    self = [super initWithServices:services params:params];
    if (self) {
        self.shouldPullDownToRefresh = NO;
        self.shouldDisableWebViewClose = NO;
        self.shouldDisableWebViewTitle = NO;
        self.request = params[MSViewModelWebRequestKey];
    }
    return self;
}

@end
