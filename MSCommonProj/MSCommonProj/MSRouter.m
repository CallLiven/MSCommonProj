//
//  MSRouter.m
//  Douyin
//
//  Created by Liven on 2019/4/23.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSRouter.h"

@interface MSRouter()

/* viewModel 到 viewController 的映射 **/
@property (nonatomic, strong, readwrite) NSDictionary *viewModelMappings;

@end


@implementation MSRouter

static MSRouter *_instance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super alloc]init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}



/**
 viewModel 与 viewController 的映射
 
 @param viewModel viewModel
 @return viewController
 */

- (MSViewController *)viewControllerForViewModel:(MSViewModel *)viewModel {
    NSString *viewController = self.viewModelMappings[NSStringFromClass(viewModel.class)];
    
    NSParameterAssert([NSClassFromString(viewController) isSubclassOfClass:[MSViewController class]]);
    NSParameterAssert([NSClassFromString(viewController) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewController) alloc]initWithViewModel:viewModel];
}


- (NSDictionary *)viewModelMappings {
    return @{
             };
}



@end
