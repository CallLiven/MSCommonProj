//
//  ConstantMacros.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/9.
//  Copyright © 2019年 Liven. All rights reserved.
//  常量

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^VoidBlock)(void);
typedef BOOL (^BoolBlock)(void);
typedef int  (^IntBlcok) (void);
typedef id   (^IdBlock)  (void);

typedef void (^VoidBlock_int)(int);
typedef BOOL (^BoolBlock_int)(int);
typedef int  (^IntBlock_int) (int);
typedef id   (^IdBlock_int)  (int);

typedef void (^VoidBlock_string)(NSString *);
typedef BOOL (^BoolBlock_string)(NSString *);
typedef int  (^IntBlock_string) (NSString *);
typedef id   (^IdBlock_string)  (NSString *);

typedef void (^VoidBlock_id)(id);
typedef BOOL (^BoolBlock_id)(id);
typedef int  (^IntBlock_id) (id);
typedef id   (^IdBlock_id)  (id);


@interface ConstantMacros : NSObject

@end

NS_ASSUME_NONNULL_END
