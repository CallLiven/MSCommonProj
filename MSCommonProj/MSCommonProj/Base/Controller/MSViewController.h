//
//  MSViewController.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSViewController : UIViewController
/* viewModel **/
@property (nonatomic, strong, readonly) MSViewModel *viewModel;


/**
 初始化方法

 @param viewModel viewModel
 */
- (instancetype)initWithViewModel:(MSViewModel *)viewModel;


/**
 绑定数据模型
 */
- (void)bindViewModel;

@end

NS_ASSUME_NONNULL_END
