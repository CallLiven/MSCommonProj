//
//  UIBarButtonItem+MSExtension.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/15.
//  Copyright © 2019 Liven. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MSExtension)

/**
 通过系统的方法，初始化一个UIBarButtonItem
 
 @param title 显示的文字，例如'完成'、'取消'
 @param titleColor title的颜色，if nil ，The Color is [UIColor whiteColor]
 @param imageName 图片名称
 @param target target
 @param selector selector
 @param textType 是否是纯文字
 @return init a UIBarButtonItem
 */
+ (UIBarButtonItem *)ms_systemItemWithTitle:(NSString *__nullable)title
                                 titleColor:(UIColor *__nullable)titleColor
                                  imageName:(NSString *__nullable)imageName
                                     target:(id __nullable)target
                                   selector:(SEL __nullable)selector
                                   textType:(BOOL)textType;



/**
 通过自定义的方法，快速初始化一个UIBarButtonItem，内部是按钮
 
 @param title 显示的文字，例如'完成'、'取消'
 @param titleColor title的颜色，if nil ，The Color is [UIColor whiteColor]
 @param imageName 图片名称
 @param target target
 @param selector selector
 @param contentHorizontalAlignment 文本对齐方向
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)ms_customItemWithTitle:(NSString *__nullable)title
                                 titleColor:(UIColor *__nullable)titleColor
                                  imageName:(NSString *__nullable)imageName
                                     target:(id __nullable)target
                                   selector:(SEL __nullable)selector
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;


/**
 快速创建一个导航栏leftBarButtonItem 用于返回（pop）或者（dismiss），切记只能是纯图片 （eg: < or X）
 且可以加大点击范围
 @param title title
 @param imageName 返回按钮的图片
 @param target target
 @param action action
 @return UIBarButtonItem Instance
 */
+ (UIBarButtonItem *)ms_backItemWithTitle:(NSString *__nullable)title
                                imageName:(NSString *__nullable)imageName
                                   target:(id __nullable)target
                                   action:(SEL __nullable)action;


@end

NS_ASSUME_NONNULL_END
