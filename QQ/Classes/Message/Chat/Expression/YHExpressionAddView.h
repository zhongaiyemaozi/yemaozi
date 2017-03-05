//
//  YHExpressionAddView.h
//  Expression
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHExtraModel;
@interface YHExpressionAddCell : UICollectionViewCell
@property (nonatomic,strong) YHExtraModel *model;

@end

@protocol YHExpressionAddViewDelegate <NSObject>

- (void)extraItemDidTap:(YHExtraModel *)model;

@end

@interface YHExpressionAddView : UIView

@property (nonatomic,weak)id<YHExpressionAddViewDelegate>delegate;
+ (instancetype)sharedView;

@end
