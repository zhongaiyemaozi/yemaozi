//
//  YHExpressionInputView.h
//  Expression
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHExpressionInputViewDelegate <NSObject>

//点击发送按钮
- (void)sendBtnDidTap;

@optional
- (void)emoticonInputDidTapText:(NSString *)text;
- (void)emoticonInputDidTapBackspace;

@end

/// 表情键盘
@interface YHExpressionInputView : UIView
@property (nonatomic, weak) id<YHExpressionInputViewDelegate> delegate;
@property (nonatomic, strong) UITextView *textView;
+ (instancetype)sharedView;
@end
