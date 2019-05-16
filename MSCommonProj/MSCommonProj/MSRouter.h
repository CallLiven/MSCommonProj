//
//  MSRouter.h
//  Douyin
//
//  Created by Liven on 2019/4/23.
//  Copyright © 2019 Liven. All rights reserved.
//  路由器

#import <Foundation/Foundation.h>
#import "MSViewController.h"
#import "MSViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MSRouter : NSObject


+ (instancetype)sharedInstance;

/**
 viewModel 与 viewController 的映射
 
 @param viewModel viewModel
 @return viewController
 */
- (MSViewController *)viewControllerForViewModel:(MSViewModel *)viewModel;


@end

NS_ASSUME_NONNULL_END
