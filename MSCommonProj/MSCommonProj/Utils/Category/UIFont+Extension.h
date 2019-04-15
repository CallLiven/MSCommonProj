//
//  UIFont+Extension.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/* IOS版本 **/
#define IOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])

/* 设置系统的字体大小（YES：粗体 NO：常规） **/
#define Font(__size__,__bold__) ((__bold__)?([UIFont boldSystemFontOfSize:__size__]):([UIFont systemFontOfSize:__size__]))

/* 极细体 **/
#define UltralightFont(__size__) ((IOSVersion<9.0)?Font(__size__ , YES):[UIFont fontForPingFangSC_UltralightFontOfSize:__size__])

/* 纤细体 **/
#define ThinFont(__size__)       ((IOSVersion<9.0)?Font(__size__ , YES):[UIFont fontForPingFangSC_ThinFontOfSize:__size__])

/* 细体 **/
#define LightFont(__size__)      ((IOSVersion<9.0)?Font(__size__ , YES):[UIFont fontForPingFangSC_LightFontOfSize:__size__])

/* 中等 **/
#define MediumFont(__size__)     ((IOSVersion<9.0)?Font(__size__ , YES):[UIFont fontForPingFangSC_MediumFontOfSize:__size__])

/* 常规 **/
#define RegularFont(__size__)    ((IOSVersion<9.0)?Font(__size__ , NO):[UIFont fontForPingFangSC_RegularFontOfSize:__size__])

/* 中粗体 **/
#define SemiboldFont(__size__)   ((IOSVersion<9.0)?Font(__size__ , YES):[UIFont fontForPingFangSC_SemiboldFontOfSize:__size__])



@interface UIFont (Extension)

/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize;

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize;

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize;


@end

NS_ASSUME_NONNULL_END
