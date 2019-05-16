//
//  MSNavigationControllerStack.h
//  Douyin
//
//  Created by Liven on 2019/4/23.
//  Copyright © 2019 Liven. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSViewModelServicesProtocol;

@interface MSNavigationControllerStack : NSObject

- (instancetype)initWithServices:(id<MSViewModelServicesProtocol>)services;

- (void)pushNavigationController:(UINavigationController *)navigationController;

- (UINavigationController *)popNavigationController;

- (UINavigationController *)topNavigationController;

@end

NS_ASSUME_NONNULL_END
