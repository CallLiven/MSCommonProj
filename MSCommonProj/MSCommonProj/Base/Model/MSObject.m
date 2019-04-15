//
//  MRObject.m
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import "MSObject.h"

@implementation MSObject


/**
 将json转为model
 
 @param json Json (NSData,NSString,NSDictionary)
 */
+ (instancetype)modelWithJSON:(id)json {
    return [self yy_modelWithJSON:json];
}


/**
 字典转模型
 
 @param dictionary dict
 */
+ (instancetype)modelwithDictionary:(NSDictionary *)dictionary {
    return [self yy_modelWithDictionary:dictionary];
}



/**
 json-array 转 模型数组
 
 @param json json
 */
+ (NSArray *)modelArrayWithJSON:(id)json {
    return [self modelArrayWithJSON:json];
}



/**
 字典 转 JSON
 
 @param dic dic
 */
+ (NSString *)dictionaryToJSON:(NSDictionary *)dic {
    return [self dictionaryToJSON:dic];
}



/**
 模型 转 json对象
 
 */
- (id)toJSONObject {
    return [self yy_modelToJSONObject];
}



/**
 模型 转 NSData
 
 */
- (NSData *)toJSONData {
    return [self yy_modelToJSONData];
}



/**
 模型 转 JSONString
 
 */
- (NSString *)toJSONString {
    return [self yy_modelToJSONString];
}

@end
