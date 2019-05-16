//
//  MSHTTPService.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSHTTPService.h"
#import "MSHTTPServiceConstant.h"

#import <AFNetworkActivityIndicatorManager.h>
#import <MJExtension.h>

@implementation MSHTTPService

static MSHTTPService *_service = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[self alloc]initWithBaseURL:nil sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return _service;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [super allocWithZone:zone];
    });
    return _service;
}

- (id)copyWithZone:(NSZone *)zone {
    return _service;
}



- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (self) {
        [self configHTTPService];
    }
    return self;
}


- (void)configHTTPService {
    // 超时时长
    self.requestSerializer.timeoutInterval = RequestTimeout;
    // 请求格式 JSON
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    // 返回格式 JSON
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置返回contentType
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                      @"text/json",
                                                      @"text/javascript",
                                                      @"text/html",
                                                      @"text/plain",
                                                      @"text/html; charset=UTF-8",
                                                      nil];
    
    // 安全策略
    AFSecurityPolicy *securityPoliy = [AFSecurityPolicy defaultPolicy];
    // 是否允许无效的证书(也就是自建的证书),默认是NO
    securityPoliy.allowInvalidCertificates = YES;
    // 假如证书的域名与你请求的域名不一致，需要把该项设置为NO
    securityPoliy.validatesDomainName = NO;
    self.securityPolicy = securityPoliy;
    
    
    // 开启网络监测
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                NSLog(@"未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"无网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"手机网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"wifi网络");
            }
                break;
                
            default:
                break;
        }
    }];
    
    [self.reachabilityManager startMonitoring];
}


#pragma mark - 网络请求
/**
 网络请求 1.0
 
 @param request request
 @param resultClass resultClass
 */
- (RACSignal *)enqueueRequest:(MSHTTPRequest *)request
                      dataKey:(NSString *)dataKey
                  resultClass:(Class)resultClass {
    if (!request) return [RACSignal error:[NSError errorWithDomain:MSHTTPServiceErrorDomain code:-1 userInfo:nil]];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params addEntriesFromDictionary:request.urlParameters.parameters];
    [params addEntriesFromDictionary:[request.urlParameters.extendsParameters mj_keyValues]];
    
    @weakify(self);
    return [[self enqueueRequestWithPath:request.urlParameters.path parameters:params method:request.urlParameters.method] reduceEach:^RACStream *(NSURLResponse *response,NSDictionary *responseObject){
        @strongify(self);
        // 请求成功，解析数据
        return [[self parsedResponseOfClass:resultClass dataKey:dataKey fromJSON:responseObject] map:^id(id parseResult) {
            MSHTTPResponse *parsedResponse = [[MSHTTPResponse alloc]initWithResponseObject:responseObject parsedObject:parseResult];
            return parsedResponse;
        }];
    }];
    
}


/**
 网络请求 2.0
 
 @param path path
 @param parameters 参数
 @param method 方式
 */
- (RACSignal *)enqueueRequestWithPath:(NSString *)path parameters:(id)parameters method:(NSString *)method {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSError *serialzationError = nil;
        NSString *absoluteString = path;
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:absoluteString parameters:@{} error:&serialzationError];
        
        // 序列化报错
        if (serialzationError) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue?:dispatch_get_main_queue(), ^{
                [subscriber sendError:serialzationError];
            });
#pragma clang diagnostic pop
            return [RACDisposable disposableWithBlock:^{
            }];
        }
        
        // 创建请求任务
        __block NSURLSessionDataTask *task = nil;
        task = [self dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            [self httpRequestLog:task body:parameters error:error];
            if (error) {
                NSError *parsedError = [self errorFromRequestWithTask:task httpResponse:(NSHTTPURLResponse *)response responseObject:responseObject error:error];
                [subscriber sendError:parsedError];
            }else{
                NSInteger statusCode = [responseObject[MSHTTPServiceResponseCodeKey] integerValue];
                if (statusCode == MSHTTPResponseCodeSucess) {
                    [subscriber sendNext:RACTuplePack(response,responseObject)];
                    [subscriber sendCompleted];
                }else{
                    [subscriber sendError:error];
                }
            }
        }];
        
        // 开始请求
        [task resume];
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
        
    }];
    
    // 多次订阅同样的信号，只执行一次
    return [signal replayLazily];
}



/**
 解析数据 3.0
 
 @param resultClass 返回数据转模型
 @param dataKey 数据字段
 @param responseObject responseObject
 */
- (RACSignal *)parsedResponseOfClass:(Class)resultClass dataKey:(NSString *)dataKey fromJSON:(NSDictionary *)responseObject {
    // 获取返回的主要数据
    if (dataKey.length>0 && dataKey) {
        responseObject = [responseObject objectForKey:dataKey];
    }
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 定义字典解析
        void (^parseJSONDictionary)(NSDictionary *) = ^(NSDictionary *JSONDictionary) {
            // 无目标模型或者数据字段，则返回全部服务器数据
            if (resultClass == nil) {
                [subscriber sendNext:JSONDictionary];
                return ;
            }
            if (dataKey.length==0 || dataKey == nil) {
                [subscriber sendNext:JSONDictionary];
                return ;
            }
            
            // 继续解析
            NSArray *JSONArray =  [JSONDictionary objectForKey:dataKey];
            if ([JSONArray isKindOfClass:NSArray.class]) {
                // 字典数组 转 对应模型数组
                NSArray *parasedObjects = [NSArray yy_modelArrayWithClass:resultClass.class json:JSONArray];
                [subscriber sendNext:parasedObjects];
            }
            else {
                MSObject *parsedObject = [resultClass yy_modelWithDictionary:JSONDictionary];
                [subscriber sendNext:parsedObject];
            }
        };
        
        
        if ([responseObject isKindOfClass:NSArray.class]) {
            if (resultClass == nil) {
                [subscriber sendNext:responseObject];
            }
            else if (dataKey.length == 0 || dataKey == nil) {
                [subscriber sendNext:responseObject];
            }
            else {
                // 数组，保证数组里面装的都是 NSDictionary
                for (NSDictionary *JSONDictionary in responseObject) {
                    if (![JSONDictionary isKindOfClass:NSDictionary.class]) {
                        NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Invalid JSON array element : %@", @""),JSONDictionary];
                        [subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
                        return nil;
                    }
                }
                
                // 字典转数组
                NSArray *parsedObjects = [NSArray yy_modelArrayWithClass:resultClass.class json:responseObject];
                [subscriber sendNext:parsedObjects];
            }
            [subscriber sendCompleted];
        }
        else if ([responseObject isKindOfClass:NSDictionary.class]) {
            parseJSONDictionary(responseObject);
            [subscriber sendCompleted];
        }
        else if (responseObject == nil || [responseObject isKindOfClass:[NSNull class]]) {
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        }
        else{
            NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Response wasn't an array or dictionary (%@): %@", @""), [responseObject class], responseObject];
            [subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
        }
        
        return nil;
    }];
}



/**
 拼接本地错误信息 4.0
 
 @param resason 报错信息
 */
- (NSError *)parsingErrorWithFailureReason:(NSString *)resason {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (resason != nil) userInfo[NSLocalizedFailureReasonErrorKey] = resason;
    return [NSError errorWithDomain:MSHTTPServiceErrorDomain code:MSHTTPServiceErrorJSONParsingFaild userInfo:userInfo];
}



/**
 解析请求错误信息 5.0
 
 @param task task
 @param httpResponse response
 @param responseObject responseObject
 @param error error
 */
- (NSError *)errorFromRequestWithTask:(NSURLSessionDataTask *)task httpResponse:(NSHTTPURLResponse *)httpResponse responseObject:(NSDictionary *)responseObject error:(NSError *)error {
    
    NSInteger HTTPCode = httpResponse.statusCode;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    //意味着连接不上服务器
    NSInteger errorCode = MSHTTPServiceErrorConnectionFailed;
    NSString *errorDesc = @"服务器出错了，请稍后重试";
    /// 其实这里需要处理后台数据错误，一般包在 responseObject
    /// HttpCode错误码解析 https://www.guhei.net/post/jb1153
    /// 1xx : 请求消息 [100  102]
    /// 2xx : 请求成功 [200  206]
    /// 3xx : 请求重定向[300  307]
    /// 4xx : 请求错误  [400  417] 、[422 426] 、449、451
    /// 5xx 、600: 服务器错误 [500 510] 、600
    NSInteger httpFirstCode = HTTPCode/100;
    if (httpFirstCode>0) {
        if (httpFirstCode == 4) {
            //请求c出错了，请稍后重试
            if (HTTPCode == 408) {
                errorDesc = @"请求超时了，请稍后再试";
            }else{
                errorDesc = @"请求出错了，请稍后重试";
            }
            
        }else if (httpFirstCode == 5 || httpFirstCode == 6){
            errorDesc = @"服务器出错了，请稍后重试";
            
        }else if (!self.reachabilityManager.isReachable) {
            errorDesc = @"网络开小差了，请稍后重试";
        }
        
    }else{
        if (!self.reachabilityManager.isReachable){
            errorDesc = @"网络开小差了，请稍后重试~";
        }
    }
    
    switch (HTTPCode) {
        case 400:{
            errorCode = MSHTTPServiceErrorBadRequest;           /// 请求失败
            break;
        }
        case 403:{
            errorCode = MSHTTPServiceErrorRequestForbidden;     /// 服务器拒绝请求
            break;
        }
        case 422:{
            errorCode = MSHTTPServiceErrorServiceRequestFailed; /// 请求出错
            break;
        }
        default:
            /// 从error中解析
            if ([error.domain isEqual:NSURLErrorDomain]) {
                errorDesc = @"请求出错了，请稍后重试~";
                switch (error.code) {
                    case NSURLErrorSecureConnectionFailed:
                    case NSURLErrorServerCertificateHasBadDate:
                    case NSURLErrorServerCertificateHasUnknownRoot:
                    case NSURLErrorServerCertificateUntrusted:
                    case NSURLErrorServerCertificateNotYetValid:
                    case NSURLErrorClientCertificateRejected:
                    case NSURLErrorClientCertificateRequired:
                        errorCode = MSHTTPServiceErrorSecureConnectionFailed; /// 建立安全连接出错了
                        break;
                    case NSURLErrorTimedOut:{
                        errorDesc = @"请求超时，请稍后再试~";
                        break;
                    }
                    case NSURLErrorNotConnectedToInternet:{
                        errorDesc = @"网络开小差了，请稍后重试~";
                        break;
                    }
                }
            }
    }
    userInfo[MSHTTPServiceErrorHTTPStatusCodeKey] = @(HTTPCode);
    userInfo[MSHTTPServiceErrorDescriptionKey] = errorDesc;
    if (task.currentRequest.URL != nil) userInfo[MSHTTPServiceErrorRequestURLKey] = task.currentRequest.URL.absoluteString;
    if (task.error != nil) userInfo[NSUnderlyingErrorKey] = task.error;
    return [NSError errorWithDomain:MSHTTPServiceErrorDomain code:errorCode userInfo:userInfo];
}





#pragma mark - 请求日志打印
- (void)httpRequestLog:(NSURLSessionDataTask *)task body:(id)params error:(NSError *)error {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>👇 REQUEST FINISH 👇>>>>>>>>>>>>>>>>>>>>>>>>>>");
    NSLog(@"Request%@=======>:%@", error?@"失败":@"成功", task.currentRequest.URL.absoluteString);
    NSLog(@"requestBody======>:%@", params);
    NSLog(@"requstHeader=====>:%@", task.currentRequest.allHTTPHeaderFields);
    NSLog(@"response=========>:%@", task.response);
    NSLog(@"error============>:%@", error);
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<👆 REQUEST FINISH 👆<<<<<<<<<<<<<<<<<<<<<<<<<<");
}

@end
