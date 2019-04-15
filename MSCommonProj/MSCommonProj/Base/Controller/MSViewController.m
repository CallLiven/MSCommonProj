//
//  MSViewController.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSViewController.h"
#import "MSNavigationController.h"

@interface MSViewController ()
/* viewModel **/
@property (nonatomic, strong, readwrite) MSViewModel *viewModel;
@end

@implementation MSViewController


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    MSViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController bindViewModel];
    }];
    return viewController;
}


- (instancetype)initWithViewModel:(MSViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏细线
    self.viewModel.prefersNaviagtionBarBottomLineHidden?[(MSNavigationController *)self.navigationController hideNavigationBottomLine]:[(MSNavigationController *)self.navigationController showNavigationBottomLine];
    //键盘配置
    IQKeyboardManager.sharedManager.enable = self.viewModel.keyboardEnable;
    IQKeyboardManager.sharedManager.shouldResignOnTouchOutside = self.viewModel.shouldResignOnTouchOutSide;
    IQKeyboardManager.sharedManager.keyboardDistanceFromTextField = self.viewModel.keyboardDistanceFromTextField;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.viewModel.willDisappearSubject sendNext:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    // 导航栏隐藏
    self.fd_prefersNavigationBarHidden = self.viewModel.prefersNavigationBarHidden;
    // pop手势
    self.fd_interactivePopDisabled = self.viewModel.interactivePopDisable;
}


- (void)bindViewModel {
    @weakify(self)
    RAC(self.navigationItem, title) = RACObserve(self.viewModel, title);
    
    [[[RACObserve(self.viewModel, interactivePopDisable) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(NSNumber *x) {
       @strongify(self)
        self.fd_interactivePopDisabled = x.boolValue;
    }];
    
}

#pragma mark - Orientation 方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
-(BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


#pragma mark - Status bar 状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}


- (void)dealloc {
    [self.viewModel.deallocSubject sendNext:nil];
}

@end
