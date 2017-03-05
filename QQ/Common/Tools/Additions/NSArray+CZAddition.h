//
//  NSArray+CZAddition.h
//  Zhifubao
//
//  Created by 刘凡 on 16/4/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CZAddition)

/// 从 plist 文件创建指定 clsName 对象数组
///
/// @param plistName plist 文件名
/// @param clsName   要创建模型的类名
///
/// @return clsName 的对象数组
+ (NSArray *)cz_objectListWithPlistName:(NSString *)plistName clsName:(NSString *)clsName;

@end
