//
//  MSHTTPRequest.m
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSHTTPRequest.h"
#import "MSHTTPService.h"

@interface MSHTTPRequest()
/* 请求参数 **/
@property (nonatomic, strong, readwrite) MSURLParameters *urlParameters;
@end


@implementation MSHTTPRequest

+ (instancetype)requestWithParameters:(MSURLParameters *)parameters {
    return [[self alloc]initRequestWithParameters:parameters];
}

- (instancetype)initRequestWithParameters:(MSURLParameters *)parameters {
    self = [super init];
    if (self) {
        self.urlParameters = parameters;
    }
    return self;
}

@end


@implementation MSHTTPRequest(MSHTTPService)

- (RACSignal *)enqueueResultClass:(Class)resultClass dataKey:(NSString *)dataKey {
    return [[MSHTTPService shareInstance] enqueueRequest:self dataKey:dataKey resultClass:resultClass];
}

@end
