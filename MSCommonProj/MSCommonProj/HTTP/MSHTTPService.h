//
//  MSHTTPService.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSHTTPService : AFHTTPSessionManager


+ (instancetype)shareInstance;


@end

NS_ASSUME_NONNULL_END
