//
//  UIBarButtonItem+MSExtension.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/15.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "UIBarButtonItem+MSExtension.h"

@implementation UIBarButtonItem (MSExtension)

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
                                   textType:(BOOL)textType {
    UIBarButtonItem *item = textType ? ({
        // 设置普通状态的文字属性
        item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
        titleColor = titleColor?titleColor:[UIColor whiteColor];
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = titleColor;
        textAttrs[NSFontAttributeName] = RegularFont(16.0f);
        NSShadow *shadow = [[NSShadow alloc]init];
        textAttrs[NSShadowAttributeName] = shadow;
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        // 设置高亮状态的文字属性
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:0.5f];
        [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        // 设置不可用状态(disable)的文字属性
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:0.5f];
        [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
        
        item;
    }):({
        item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:selector];
        item;
    });
    return item;
}



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
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    UIButton *item = [[UIButton alloc]init];
    titleColor = titleColor?titleColor:[UIColor whiteColor];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [item.titleLabel setFont:RegularFont(16)];
    [item setTitleColor:titleColor forState:UIControlStateNormal];
    [item setTitleColor:[titleColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    [item setTitleColor:[titleColor colorWithAlphaComponent:0.5f] forState:UIControlStateDisabled];
    [item sizeToFit];
    item.contentHorizontalAlignment = contentHorizontalAlignment;
    [item addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:item];
}


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
                                   action:(SEL __nullable)action {
    return [self ms_customItemWithTitle:title
                             titleColor:nil
                              imageName:imageName
                                 target:target
                               selector:action
             contentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

@end
