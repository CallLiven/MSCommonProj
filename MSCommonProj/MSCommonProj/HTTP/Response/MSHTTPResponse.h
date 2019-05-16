//
//  MSHTTPResponse.h
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSObject.h"

NS_ASSUME_NONNULL_BEGIN

/* 请求数据返回的状态码 **/
typedef NS_ENUM(NSUInteger,MSHTTPResponseCode) {
    MSHTTPResponseCodeSucess = 0,   // 请求成功
};


@interface MSHTTPResponse : MSObject

/* 服务器返回的数据 **/
@property (nonatomic, strong, readonly) id parseResult;
/* 状态码 **/
@property (nonatomic, assign, readonly) MSHTTPResponseCode code;



/**
 初始化方法

 @param responseObject 服务器返回数据
 @param parsedResult 处理后的数据
 */
- (instancetype)initWithResponseObject:(id)responseObject parsedObject:(id)parsedResult;

@end

NS_ASSUME_NONNULL_END
