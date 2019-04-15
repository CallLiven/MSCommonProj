//
//  MSViewModelServicesProtocol.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//  视图模型服务协议 （导航栏操作 + 网络请求）

#import <Foundation/Foundation.h>
#import "MSNavigationProtocol.h"
#import "MSHTTPService.h"

@protocol MSViewModelServicesProtocol <NSObject,MSNavigationProtocol>

@property (nonatomic, strong, readonly) MSHTTPService *client;

@end


