//
//  MSHTTPServiceConstant.h
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#ifndef MSHTTPServiceConstant_h
#define MSHTTPServiceConstant_h

/* 访问超时时长 **/
#define RequestTimeout 60
/* The Http request error domain **/
#define MSHTTPServiceErrorDomain @"MSHTTPServiceErrorDomain"
#define MSHTTPServiceErrorHTTPStatusCodeKey @"MSHTTPServiceErrorHTTPStatusCodeKey"
#define MSHTTPServiceErrorDescriptionKey @"MSHTTPServiceErrorDescriptionKey"
#define MSHTTPServiceErrorRequestURLKey @"MSHTTPServiceErrorRequestURLKey"

/* 解析失败错误代码 **/
#define MSHTTPServiceErrorConnectionFailed 668
#define MSHTTPServiceErrorJSONParsingFaild 669

/* 服务器请求失败 **/
#define MSHTTPServiceErrorBadRequest 670
#define MSHTTPServiceErrorRequestForbidden 671
#define MSHTTPServiceErrorServiceRequestFailed 672
#define MSHTTPServiceErrorSecureConnectionFailed 673

/* 服务器返回固定字段 **/
/* 状态码key **/
#define MSHTTPServiceResponseCodeKey @"status_code"

#endif /* MSHTTPServiceConstant_h */
