//
//  QQMessage.h
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQMessage : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *time;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
