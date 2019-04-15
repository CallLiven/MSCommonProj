//
//  MSNavigationController.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSNavigationController.h"
#import "MSViewController.h"

@interface MSNavigationController ()
/* 导航栏分割线 **/
@property (nonatomic, strong, readwrite) UIImageView *navigationBottomLine;
@end



@implementation MSNavigationController


+ (void)initialize {
    [self setupNavigationBarTheme];
    
    [self setupBarButtonItemTheme];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}


#pragma mark - 初始化
- (void)setup {
    [self setupNavigationBarBottomLine];
}

#pragma mark - 设置导航栏分割线
- (void)setupNavigationBarBottomLine {
    // 隐藏系统导航栏分割线
    UIImageView *navigationBarBottomLine = [self findHairlineImageViewUnder:self.navigationBar];
    navigationBarBottomLine.hidden = YES;
    // 添加自己的分割线
    CGFloat navSystemLineH = 0.5f;
    UIImageView *navSystemLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.navigationBar.height - navSystemLineH, SCREEN_W, navSystemLineH)];
    navSystemLine.backgroundColor = Color(223.0f, 223.0f, 221.0f);
    [self.navigationBar addSubview:navSystemLine];
    self.navigationBottomLine = navSystemLine;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subView];
        if (imageView) return imageView;
    }
    return nil;
}


#pragma mark - 设置UINavigationBarTheme的主题
+ (void)setupNavigationBarTheme {
    UINavigationBar *appearance = [UINavigationBar appearance];
    // 设置背景
    [appearance setTranslucent:YES];
    // 设置导航栏文字按钮的渲染色
    [appearance setTintColor:[UIColor whiteColor]];
    // 设置导航栏的背景渲染色
    [appearance setBarTintColor:ColorWithHexString(@"#FFFFFFFF")];
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = MediumFont(19.0f);
    textAttrs[NSForegroundColorAttributeName] = ColorWithHexString(@"#2B1101FF");
    
    // UIOffsetZero是结构体，只要包装成NSValue对象，才能放进字典/数组中
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
    
    // 去掉导航栏的阴影图片
    [appearance setShadowImage:[UIImage new]];
}


#pragma mark - 设置UIBarButtonItem的主题
+ (void)setupBarButtonItemTheme {
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    CGFloat fontSize = 16.0f;
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = RegularFont(fontSize);
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeZero;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}


#pragma mark - Publi Method
- (void)showNavigationBottomLine {
    self.navigationBottomLine.hidden = NO;
}

- (void)hideNavigationBottomLine {
    self.navigationBottomLine.hidden = YES;
}


/* 能拦截所有push进来的子控制器 **/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0) {
        // 隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        NSString *title = @"返回";
        // eg: [A push B]
        // 1. 取出当前的控制器的title ， 也就是取出 A.title
        // [[self topViewController] navigationItem].title 这样来获取title 而不是[[self topViewController] title]
        title = [[self topViewController] navigationItem].title ? :@"返回";
        
        // 2. 判断要被Push的控制器(B)是否是 YEViewController
        if ([viewController isKindOfClass:MSViewController.class]) {
             MSViewModel *viewModel = [(MSViewController *)viewController viewModel];
            
            // 3. 查看backTitle是否有值
            title = viewModel.backTitle?:title;
        }
        
        // 4. 这里可以设置导航栏的左右按钮 统一管理方法
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem ye_backItemWithTitle:title imageName:@"arrow_left" target:self action:@selector(itemBack)];
    }
    // push
    [super pushViewController:viewController animated:animated];
}

- (void)itemBack {
    [self popViewControllerAnimated:YES];
}

#pragma mark - Override
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}

@end
