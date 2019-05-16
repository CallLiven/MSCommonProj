//
//  AppDelegate.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/8.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+MSExtension.h"
#import "AppDelegate+MSLifeCircle.h"

#import "MSViewModel.h"

@interface AppDelegate ()
/* 管理导航栏的堆栈 **/
@property (nonatomic, strong, readwrite) MSNavigationControllerStack *navigationControllerStack;
/* 跳转管理 **/
@property (nonatomic, strong, readwrite) MSViewModelServicesProtocolImpl *services;
@end



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self addNotification];
    self.services = [[MSViewModelServicesProtocolImpl alloc]init];
    self.navigationControllerStack = [[MSNavigationControllerStack alloc]initWithServices:self.services];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = WhiteColor;
    [self.services resetRootViewModel:[self initialViewModel]];
    [self.window makeKeyAndVisible];
    
    return YES;
}



/**
 获取ViewModel

 @return viewModel
 */
- (MSViewModel *)initialViewModel {
    return [[MSViewModel alloc]initWithServices:self.services params:@{}];
}


/**
 添加监听
 
 */
- (void)addNotification {
    [[MSNotificationCenterInstance rac_addObserverForName:kSwitchRootViewControllerNotifications object:nil] subscribeNext:^(id x) {
        [self.services resetRootViewModel:[self initialViewModel]];
    }];
}


/**
 获取 delegate

 @return delegate
 */
+ (AppDelegate *)shareDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}



@end
