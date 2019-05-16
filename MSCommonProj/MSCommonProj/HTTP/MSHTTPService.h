//
//  MSHTTPService.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "MSHTTPRequest.h"
#import "MSHTTPResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSHTTPService : AFHTTPSessionManager

/* 初始化 **/
+ (instancetype)shareInstance;


/* 网络请求 **/
- (RACSignal *)enqueueRequest:(MSHTTPRequest *)request
                      dataKey:(NSString *)dataKey
                  resultClass:(Class)resultClass;

@end

NS_ASSUME_NONNULL_END
