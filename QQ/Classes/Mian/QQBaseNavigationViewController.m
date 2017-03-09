//
//  QQBaseNavigationViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/3/4.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQBaseNavigationViewController.h"

@interface QQBaseNavigationViewController ()

@end

@implementation QQBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}

@end
