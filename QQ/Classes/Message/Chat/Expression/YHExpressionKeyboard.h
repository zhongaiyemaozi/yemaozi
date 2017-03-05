//
//  YHExpressionKeyboard.h
//  Expression
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHExpressionTextView;
#pragma mark - @protocol YHExpressionKeyboardDelegate
@class YHExpressionKeyboard;
@protocol YHExpressionKeyboardDelegate <NSObject>

//点击发送
- (void)sendBtnDidTap:(NSString *)text;

@optional
//根据键盘是否弹起，设置tableView frame
- (void)keyboard:(YHExpressionKeyboard *)keyBoard changeDuration:(CGFloat)durtaion;
//选择了“+”内容
- (void)didSelectExtraItem:(NSString *)itemName;

@end


#pragma mark - YHExpressionKeyboard

@interface YHExpressionKeyboard : UIView

@property (nonatomic, assign) int maxNumberOfRowsToShow;//最大显示行

@property (nonatomic, strong) YHExpressionTextView *textView;

/**
 初始化方式
 
 @param viewController YHExpressionKeyboard所在的控制器
 @param aboveView 在viewController的view中,位于YHExpressionKeyboard上方的视图,（用于设置aboveView的滚动）
 @return YHExpressionKeyboard
 */
- (instancetype)initWithViewController:( UIViewController <YHExpressionKeyboardDelegate>*)viewController aboveView:( UIView *)aboveView;


/**
 结束编辑
 */
- (void)endEditing;

@end
