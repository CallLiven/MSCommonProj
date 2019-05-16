//
//  MSURLParameters.h
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSKeyedSubscript.h"

NS_ASSUME_NONNULL_BEGIN

/* 配置基本的扩展参数 **/
@interface MSURLExtendsParameters : NSObject

@property (nonatomic, copy, readwrite) NSString *version_code;
@property (nonatomic, copy, readwrite) NSString *pass_region;
@property (nonatomic, copy, readwrite) NSString *pass_route;
@property (nonatomic, copy, readwrite) NSString *js_sdk_version;
@property (nonatomic, copy, readwrite) NSString *app_name;
@property (nonatomic, copy, readwrite) NSString *vid;
@property (nonatomic, copy, readwrite) NSString *app_version;
@property (nonatomic, copy, readwrite) NSString *device_id;
@property (nonatomic, copy, readwrite) NSString *channel;
@property (nonatomic, copy, readwrite) NSString *mcc_mnc;
@property (nonatomic, copy, readwrite) NSString *aid;
@property (nonatomic, copy, readwrite) NSString *screen_width;
@property (nonatomic, copy, readwrite) NSString *openudid;
@property (nonatomic, copy, readwrite) NSString *os_api;
@property (nonatomic, copy, readwrite) NSString *ac;
@property (nonatomic, copy, readwrite) NSString *os_version;
@property (nonatomic, copy, readwrite) NSString *device_platform;
@property (nonatomic, copy, readwrite) NSString *build_number;
@property (nonatomic, copy, readwrite) NSString *device_type;
@property (nonatomic, copy, readwrite) NSString *iid;
@property (nonatomic, copy, readwrite) NSString *idfa;
@property (nonatomic, copy, readwrite) NSString *mas;
@property (nonatomic, copy, readwrite) NSString *as;
@property (nonatomic, copy, readwrite) NSString *ts;

/**
 初始化

 */
+ (instancetype)extendsParameters;

@end




@interface MSURLParameters : NSObject

/* 路径 **/
@property (nonatomic, copy, readwrite) NSString *path;
/* 参数 **/
@property (nonatomic, strong, readwrite) NSDictionary *parameters;
/* 请求方式 **/
@property (nonatomic, copy, readwrite) NSString *method;
/* 扩展参数 **/
@property (nonatomic, strong, readwrite) MSURLExtendsParameters *extendsParameters;


/**
 初始化方法

 @param method 请求方法"POST" "GET"
 @param path 请求路径
 @param parameters 请求参数
 */
+ (instancetype)urlParametersWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
