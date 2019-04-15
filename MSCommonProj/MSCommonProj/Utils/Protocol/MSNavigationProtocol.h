//
//  MSNavigationProtocol.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSViewModel;

@protocol MSNavigationProtocol <NSObject>

/* push **/
- (void)pushViewModel:(MSViewModel *)viewModel animated:(BOOL)animated;

/* pop **/
- (void)popViewModelAnimated:(BOOL)animated;

/* pop to root **/
- (void)popToRootViewModelAnimated:(BOOL)animated;

/* present **/
- (void)presentViewModel:(MSViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

/* dismiss **/
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

/* reset root **/
- (void)resetRootViewModel:(MSViewModel *)viewModel;

@end

