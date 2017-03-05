//
//  UIViewController+CZAddition.m
//  002-Meituan
//
//  Created by apple on 16/5/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIViewController+CZAddition.h"

@implementation UIViewController (CZAddition)

- (void)cz_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    // 1> 添加子控制器 － 否则响应者链条会被打断，导致事件无法正常传递，而且错误非常难改！
    [self addChildViewController:childController];
    
    // 2> 添加子控制器的视图
    [view addSubview:childController.view];
    
    // 3> 完成子控制器的添加
    [childController didMoveToParentViewController:self];
}

@end
