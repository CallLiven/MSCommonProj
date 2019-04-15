//
//  SystemMacros.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/8.
//  Copyright © 2019年 Liven. All rights reserved.
//  所有系统宏定义

#ifndef SystemMacros_h
#define SystemMacros_h

/* 应用名称 **/
#define APPName ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
/* 应用版本号 **/
#define APPVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
/* 应用build **/
#define APPBuild ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])


/* 导航栏高度 **/
#define NAV_BAR_HEIGHT (IS_IPHONE_X?88.0f:64.0f)
/* tabBar高度 **/
#define TAB_BAR_HEIGHT (IS_IPHONE_X?83.0f:49.0f)


/* 屏幕尺寸相关 **/
#define SCREEN_W ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_H ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_B ([[UIScreen mainScreen] bounds])
#define SCREEN_MAX_LENGTH (MAX(SCREEN_W, SCREEN_H))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_W, SCREEN_H))


/* 设备类型 **/
#define IS_IPAD  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/* 手机类型 **/
#define IS_IPHONE_4_OR_LESS  (IS_IPHONE && SCREEN_MAX_LENGTH  < 568.0)
#define IS_IPHONE_5          (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6          (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P         (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X          (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

/* iOS Version 相关 **/
#define IOS_Version ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS7_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define IOS8_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define IOS9_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0)
#define IOS10_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
#define IOS11_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 11.0)
#define IOS12_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 12.0)


/* AppDelegate **/
#define MSAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
/* 通知中心 **/
#define MSNotificationCenterInstance [NSNotificationCenter defaultCenter]
/* userDefaullt **/
#define MSUserDefaults [NSUserDefaults standardUserDefaults]


/* AppCaches 文件夹路径 **/
#define CachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
/* App DocumentDirectory 文件夹路径 **/
#define DocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]


/* 是否为空对象 **/
#define ObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])
/* 字符串为空 **/
#define StringIsEmpty(__string) ((__string.length == 0) || ObjectIsNil(__string))
/* 字符串不为空 **/
#define StringIsNotEmpty(__string)  (!StringIsEmpty(__string))
/* 数组为空 **/
#define ArrayIsEmpty(__array) ((ObjectIsNil(__array)) || (__array.count==0))


/* 设置图片 **/
#define ImageNamed(__imageName) [UIImage imageNamed:__imageName]


/* 颜色 **/
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/* 颜色+透明度 **/
#define ColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/* 随机色 **/
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
/* 根据hex 获取颜色 **/
#define ColorWithHexString(__hexString__) ([UIColor colorWithHexString:__hexString__])



/* 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容]) **/
#ifdef DEBUG
#define NSLog(format, ...)  printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

#endif /* SystemMacros_h */
