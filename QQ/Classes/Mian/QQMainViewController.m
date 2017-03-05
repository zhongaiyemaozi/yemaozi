//
//  QQMainViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQMainViewController.h"
#import "QQBaseNavigationViewController.h"
@interface QQMainViewController ()

@end

@implementation QQMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self addControllers];
}

#pragma mark - 添加子控制器
-(void)addControllers{
    
    
    UIViewController *vc1 = [self controllerWithClassName:@"QQMessageViewController" andTitle:@"消息" andImgName:@"tab_recent_nor"];
    
    UIViewController *vc2 = [self controllerWithClassName:@"QQContactViewController" andTitle:@"联系人" andImgName:@"tab_buddy_nor"];
    
    UIViewController *vc3 = [self controllerWithClassName:@"QQQzoneViewController" andTitle:@"动态" andImgName:@"tab_qworld_nor"];
    
    self.viewControllers = @[ vc1,vc2,vc3 ];
}


#pragma mark - 控制器的封装
-(UIViewController *)controllerWithClassName:(NSString *)clsName andTitle:(NSString *)title andImgName:(NSString *)imgName{
    
    Class cls = NSClassFromString(clsName);
    
    NSAssert( [cls isSubclassOfClass:[UIViewController class]]  , @"传入的类名不是合法的控制器类名");
    
    UIViewController *vc = [cls new];
    
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imgName];
    
    QQBaseNavigationViewController *nav = [[QQBaseNavigationViewController alloc] initWithRootViewController:vc];
    
    nav.view.backgroundColor = [UIColor whiteColor];
    
    
    return nav;
}

@end
