
//
//  MSURLParameters.m
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSURLParameters.h"

@implementation MSURLExtendsParameters

+ (instancetype)extendsParameters {
    return [[self alloc]init];
}

- (NSString *)version_code {
    return @"5.7.0";
}

- (NSString *)pass_region {
    return @"1";
}

- (NSString *)pass_route {
    return @"1";
}

- (NSString *)js_sdk_version {
    return @"1.13.0.0";
}

- (NSString *)app_name {
    return @"aweme";
}

- (NSString *)vid {
    return @"03ED2DE4-1CC1-4042B099-546CD2283472";
}

- (NSString *)app_version {
    return @"5.7.0";
}

- (NSString *)device_id {
    return @"61011313726";
}

- (NSString *)channel {
    return @"App Store";
}

- (NSString *)aid {
    return @"1128";
}

- (NSString *)screen_width {
    return [NSString stringWithFormat:@"%f",SCREEN_W];
}

- (NSString *)openudid {
    return @"07bc6e010007982e8a9faf9cf0beb1c7841f16eb";
}

- (NSString *)os_api {
    return @"18";
}

- (NSString *)ac {
    return @"WIFI";
}

- (NSString *)os_version {
    return @"12.2";
}

- (NSString *)device_platform {
    return @"iphone";
}

- (NSString *)build_number {
    return @"57010";
}

- (NSString *)device_type {
    return @"iPhone9,4";
}

- (NSString *)iid {
    return @"68732512027";
}

- (NSString *)mas {
    return @"019d716f2d0715471849f3ab72bbf2a17b713f5c6c8dd1d6d0d8d8";
}

- (NSString *)as {
    return @"a2c5331b3fac6cbef58168";
}

- (NSString *)ts {
    return @"1555381967";
}

@end





@implementation MSURLParameters

+ (instancetype)urlParametersWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    return [[self alloc]initUrlParametersWithMethod:method path:path parameters:parameters];
}

- (instancetype)initUrlParametersWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    self = [super init];
    if (self) {
        self.method = method;
        self.path = path;
        self.parameters = parameters;
        self.extendsParameters = [MSURLExtendsParameters extendsParameters];
    }
    return self;
}

@end
