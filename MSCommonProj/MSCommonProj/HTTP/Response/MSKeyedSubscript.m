//
//  MSKeyedSubscript.m
//  Douyin
//
//  Created by Liven on 2019/4/17.
//  Copyright © 2019 Liven. All rights reserved.
//

#import "MSKeyedSubscript.h"

@interface MSKeyedSubscript()
@property (nonatomic, strong, readwrite) NSMutableDictionary *kvs;
@end

@implementation MSKeyedSubscript

- (instancetype)init {
    self = [super init];
    if (self) {
        self.kvs = [NSMutableDictionary dictionary];
    }
    return self;
}

/* 实例初始化 **/
+ (instancetype)subscript {
    return [[self alloc]init];
}

/* 拼接一个字典 **/
+ (instancetype)subscriptWithDictionary:(NSDictionary *)dict {
    return [[self alloc]initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.kvs = [NSMutableDictionary dictionary];
        if ([dict count]) [self.kvs addEntriesFromDictionary:dict];
    }
    return self;
}

- (id)objectForKeySubsript:(id)key {
    return key?[self.kvs objectForKey:key]:nil;
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    if (key) {
        if (obj) {
            [self.kvs setObject:obj forKeyedSubscript:key];
        }else{
            [self.kvs removeObjectForKey:key];
        }
    }
}


/* 转化字典 **/
- (NSDictionary *)dictionary {
    return self.kvs.copy;
}

@end
