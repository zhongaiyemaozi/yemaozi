//
//  QQSliderViewController.h
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQSliderViewController : UIViewController

@property(nonatomic,strong)UIViewController *leftVC;

@property(nonatomic,strong)UIViewController *rightVC;

- (instancetype)initWithLeftVC:(UIViewController *)leftVC andRightVC:(UIViewController *)rightVC;

- (void)closeLeftVC;

@end
