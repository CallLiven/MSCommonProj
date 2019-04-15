//
//  MSViewModel.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSViewModel.h"

/* 传递webView request的key **/
NSString *const MSViewModelWebRequestKey = @"MSViewModelWebRequestKey";


@interface MSViewModel()
/* 整个应用的服务层 **/
@property (nonatomic, strong, readwrite) id<MSViewModelServicesProtocol> services;
/* 传参 **/
@property (nonatomic, strong, readwrite) NSDictionary *params;
/* view will Disappear **/
@property (nonatomic, strong, readwrite) RACSubject *willDisappearSubject;
/* dealloc **/
@property (nonatomic, strong, readwrite) RACSubject *deallocSubject;
@end



@implementation MSViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MSViewModel *viewModel = [super allocWithZone:zone];
    @weakify(viewModel);
    [[viewModel rac_signalForSelector:@selector(initWithServices:params:)] subscribeNext:^(id x) {
        @strongify(viewModel);
        [viewModel initialize];
    }];
    
    return viewModel;
}


- (instancetype)initWithServices:(id<MSViewModelServicesProtocol>)services params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.shouldFetchLocalDatOnViewModelInitialze = YES;
        self.shouldRequestRemoteDataOnViewDidLoad = YES;
        self.prefersNaviagtionBarBottomLineHidden = YES;
        
        self.keyboardEnable = YES;
        self.shouldResignOnTouchOutSide = YES;
        self.keyboardDistanceFromTextField = 10.0f;
        
        self.title = @"";
        self.services = services;
        self.params = params;
    }
    return self;
}


- (RACSubject *)willDisappearSubject {
    if (!_willDisappearSubject) {
        _willDisappearSubject = [RACSubject subject];
    }
    return _willDisappearSubject;
}


- (RACSubject *)deallocSubject {
    if (!_deallocSubject) {
        _deallocSubject = [RACSubject subject];
    }
    return _deallocSubject;
}


- (void)initialize {
    
}


@end
