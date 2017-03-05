//
//  QQChat.h
//  QQ
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    QQChatTypeOther,
    QQChatTypeMe
} QQChatType;

@interface QQChat : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) QQChatType type;

@end
