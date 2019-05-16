//
//  MSHTTPRequest.h
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSObject.h"
#import "MSURLParameters.h"

@interface MSHTTPRequest : MSObject

/* 请求参数 **/
@property (nonatomic, strong, readonly) MSURLParameters *urlParameters;
/**
 创建请求类

 @param parameters parameters
 */
+ (instancetype)requestWithParameters:(MSURLParameters *)parameters;

@end



@interface MSHTTPRequest(MSHTTPService)

- (RACSignal *)enqueueResultClass:(Class)resultClass dataKey:(NSString *)dataKey;

@end


