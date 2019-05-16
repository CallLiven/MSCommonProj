//
//  AppDelegate.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/8.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSNavigationControllerStack.h"
#import "MSViewModelServicesProtocolImpl.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/* 管理导航栏的堆栈 **/
@property (nonatomic, strong, readonly) MSNavigationControllerStack *navigationControllerStack;

/* 获取到APPDelegate **/
+ (AppDelegate *)shareDelegate;

@end

