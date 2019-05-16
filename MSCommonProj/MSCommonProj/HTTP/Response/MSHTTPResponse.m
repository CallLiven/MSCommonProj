//
//  MSHTTPResponse.m
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSHTTPResponse.h"
#import "MSHTTPServiceConstant.h"

@interface MSHTTPResponse ()
/* 服务器返回的数据 **/
@property (nonatomic, strong, readwrite) id parseResult;
/* 状态码 **/
@property (nonatomic, assign, readwrite) MSHTTPResponseCode code;
@end

@implementation MSHTTPResponse


/**
 初始化方法
 
 @param responseObject 服务器返回数据
 @param parsedResult 处理后的数据
 */
- (instancetype)initWithResponseObject:(id)responseObject parsedObject:(id)parsedResult {
    self = [super init];
    if (self) {
        self.parseResult = parsedResult?:NSNull.null;
        self.code = [responseObject[MSHTTPServiceResponseCodeKey] integerValue];
    }
    return self;
}

@end
