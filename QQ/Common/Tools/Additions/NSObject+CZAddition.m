//
//  NSObject+CZAddition.m
//  Zhifubao
//
//  Created by 刘凡 on 16/4/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSObject+CZAddition.h"

@implementation NSObject (CZAddition)

/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)cz_objectWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

@end
