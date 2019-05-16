//
//  MSKeyedSubscript.h
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSKeyedSubscript : NSObject

/* 实例初始化 **/
+ (instancetype)subscript;

/* 拼接一个字典 **/
+ (instancetype)subscriptWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (id)objectForKeySubsript:(id)key;
- (void)setObject:(id)obj forKeyedSubscript:(id)key;



/* 转化字典 **/
- (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
