//
//  QQChatViewController.h
//  QQ
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQBaseViewController.h"
#import "QQChat.h"

@interface QQChatViewController : QQBaseViewController

- (void)sendMessageWithText:(NSString *)text messageType:(QQChatType)type;
- (NSString *)replyWithText:(NSString *)text;

@property (nonatomic, weak) UITextField *textField;


@end
