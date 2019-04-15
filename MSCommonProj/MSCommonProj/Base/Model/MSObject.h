//
//  MRObject.h
//  MSCommonProj
//
//  Created by Liven on 2019/4/10.
//  Copyright © 2019年 Liven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSObject : NSObject<YYModel>


/**
 将json转为model

 @param json Json (NSData,NSString,NSDictionary)
 */
+ (instancetype)modelWithJSON:(id)json;


/**
 字典转模型

 @param dictionary dict
 */
+ (instancetype)modelwithDictionary:(NSDictionary *)dictionary;



/**
 json-array 转 模型数组

 @param json json
 */
+ (NSArray *)modelArrayWithJSON:(id)json;



/**
 字典 转 JSON

 @param dic dic
 */
+ (NSString *)dictionaryToJSON:(NSDictionary *)dic;



/**
 模型 转 json对象

 */
- (id)toJSONObject;



/**
 模型 转 NSData

 */
- (NSData *)toJSONData;



/**
 模型 转 JSONString
 
 */
- (NSString *)toJSONString;



@end

NS_ASSUME_NONNULL_END
