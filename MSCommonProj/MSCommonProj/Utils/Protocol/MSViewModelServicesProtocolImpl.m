//
//  MSViewModelServicesProtocolImpl.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSViewModelServicesProtocolImpl.h"

@implementation MSViewModelServicesProtocolImpl

@synthesize client = _client;

- (instancetype)init {
    self = [super init];
    if (self) {
        _client = [MSHTTPService shareInstance];
    }
    return self;
}



- (void)pushViewModel:(MSViewModel *)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(MSViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootViewModel:(MSViewModel *)viewModel {}

@end
