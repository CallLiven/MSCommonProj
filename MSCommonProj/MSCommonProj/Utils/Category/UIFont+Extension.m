//
//  UIFont+Extension.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "UIFont+Extension.h"


/**
 *  极细体
 */
static NSString *const PingFangSC_Ultralight = @"PingFangSC-Ultralight";
/**
 *  常规体
 */
static NSString *const PingFangSC_Regular = @"PingFangSC-Regular";
/**
 *  中粗体
 */
static NSString *const PingFangSC_Semibold = @"PingFangSC-Semibold";
/**
 *  纤细体
 */
static NSString *const PingFangSC_Thin = @"PingFangSC-Thin";
/**
 *  细体
 */
static NSString *const PingFangSC_Light = @"PingFangSC-Light";
/**
 *  中黑体
 */
static NSString *const PingFangSC_Medium = @"PingFangSC-Medium";



@implementation UIFont (Extension)
/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:PingFangSC_Ultralight size:fontSize];
}

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:PingFangSC_Regular size:fontSize];
}

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:PingFangSC_Semibold size:fontSize];
}

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:PingFangSC_Thin size:fontSize];
}

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:PingFangSC_Light size:fontSize];
}

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:PingFangSC_Medium size:fontSize];
}

@end
