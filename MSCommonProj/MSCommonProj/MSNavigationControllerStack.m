//
//  MSNavigationControllerStack.m
//  Douyin
//
//  Created by Liven on 2019/4/23.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSNavigationControllerStack.h"
#import "MSNavigationController.h"
#import "MSRouter.h"
#import "AppDelegate.h"

@interface MSNavigationControllerStack()
@property (nonatomic, strong, readwrite) id<MSViewModelServicesProtocol> services;
@property (nonatomic, strong, readwrite) NSMutableArray *navigationControllers;
@end

@implementation MSNavigationControllerStack

- (instancetype)initWithServices:(id<MSViewModelServicesProtocol>)services {
    self = [super init];
    if (self) {
        self.services = services;
        self.navigationControllers = [[NSMutableArray alloc]init];
        [self registerNavigationHooks];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    if (navigationController) {
        [self.navigationControllers addObject:navigationController];
    }
}


- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}


- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}


- (void)registerNavigationHooks {
    @weakify(self);
    [[(NSObject *)self.services rac_signalForSelector:@selector(pushViewModel:animated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UIViewController *viewController = (UIViewController *)[MSRouter.sharedInstance viewControllerForViewModel:tuple.first];
        [self.navigationControllers.lastObject pushViewController:viewController animated:[tuple.second boolValue]];
    }];
    
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.navigationControllers.lastObject popViewModelAnimated:[tuple.first boolValue]];
    }];
    
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(popToRootViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(presentViewModel:animated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UIViewController *viewController = (UIViewController *)[MSRouter.sharedInstance viewControllerForViewModel:tuple.first];
        UINavigationController *presentViewController = self.navigationControllers.lastObject;
        if (![viewController isKindOfClass:UINavigationController.class]) {
            viewController = [[MSNavigationController alloc]initWithRootViewController:viewController];
        }
        [self pushNavigationController:(UINavigationController *)viewController];
        [presentViewController presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
    }];
    
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self popNavigationController];
        [self.navigationControllers.lastObject dismissViewControllerAnimated:tuple.first completion:tuple.second];
    }];
    
    
    [[(NSObject *)self.services rac_signalForSelector:@selector(resetRootViewModel:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.navigationControllers removeAllObjects];
        UIViewController *viewController = (UIViewController *)[MSRouter.sharedInstance viewControllerForViewModel:tuple.first];
        if (![viewController isKindOfClass:UINavigationController.class]) {
            viewController = [[MSNavigationController alloc]initWithRootViewController:viewController];
            [self pushNavigationController:(UINavigationController *)viewController];
        }
        AppDelegate *appdelegate = [AppDelegate shareDelegate];
        appdelegate.window.rootViewController = viewController;
    }];
}

@end
