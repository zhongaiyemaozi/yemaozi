//
//  QQBaseNavigationViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/3/4.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQBaseNavigationViewController.h"

@interface QQBaseNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation QQBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    //清空interactivePopGestureRecognizer的delegate可以恢复因替换导航条的back按钮失去系统默认手势
//    self.interactivePopGestureRecognizer.delegate = nil;
//    
//    //禁止手势冲突
//    self.interactivePopGestureRecognizer.enabled = NO;
//    
//    //在runtime中查到的系统tagert 和方法名 手动添加手势，调用系统的方法,这个警告看着不爽，我直接强制去掉了~
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//#pragma clang diagnostic pop
//    
//    pan.delegate = self;
//    
//    [self.view addGestureRecognizer:pan];
    
    // 添加右滑手势
//    [self addSwipeRecognizer];
}

//#pragma mark 添加右滑手势
//- (void)addSwipeRecognizer
//{
//    // 初始化手势并添加执行方法
//    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(return)];
//    swipeRecognizer.delegate = self;
//    // 手势方向
//    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
//    
//    // 响应的手指数
//    swipeRecognizer.numberOfTouchesRequired = 1;
//    
//    // 添加手势
//    [[self view] addGestureRecognizer:swipeRecognizer];
//}
//
//#pragma mark 返回上一级
//- (void)return
//{
//    // 最低控制器无需返回
//    if (self.viewControllers.count <= 1) return;
//    
//    // pop返回上一级
//    [self popToRootViewControllerAnimated:YES];
//}
//
//
//
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return YES;
//}

@end
