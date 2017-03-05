//
//  QQSliderViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQSliderViewController.h"

@interface QQSliderViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITapGestureRecognizer *tap;

@property(nonatomic,strong)UIPanGestureRecognizer *pan;

@end

@implementation QQSliderViewController

#pragma mark - 自定义设置左右控制器
- (instancetype)initWithLeftVC:(UIViewController *)leftVC andRightVC:(UIViewController *)rightVC {
    
    if ( self = [super init]) {
        
        [self addChildViewController:leftVC];
        [self addChildViewController:rightVC];
        
        [self.view addSubview:leftVC.view];
        [self.view addSubview:rightVC.view];
        
        [leftVC didMoveToParentViewController:self];
        [rightVC didMoveToParentViewController:self];
        
        _leftVC = leftVC;
        _rightVC = rightVC;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //给根视图添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    _pan = pan;
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark - 实现拖拽手势方法
- (void)pan:(UIPanGestureRecognizer *)sender {
    //MARK:首页才可以拖拽的判断
    if (![self isTopviewController]) {
        return;
    }
    
    
    CGPoint offset = [sender translationInView:self.view];

    [sender setTranslation:CGPointZero inView:self.view];

    if (offset.x + _rightVC.view.frame.origin.x < 0) {

        _rightVC.view.transform = CGAffineTransformIdentity;
        
        return;
    }

    CGFloat width = self.view.bounds.size.width;
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            
            _rightVC.view.transform = CGAffineTransformTranslate(_rightVC.view.transform, offset.x, 0);
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:

            if (_rightVC.view.frame.origin.x > _rightVC.view.bounds.size.width * 0.5) {
                
                [self showLeftWithWidth:width];
                
            }else {
                
                [self closeLeftVC];
                
            }
        default:
            break;
    }
    
}

#pragma mark - 显示左控制器
- (void)showLeftWithWidth:(CGFloat)width {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _rightVC.view.transform = CGAffineTransformMakeTranslation(width - 72, 0);
        
    }completion:^(BOOL finished) {
        
        [self.view removeGestureRecognizer:_pan];
    }];
    //实例化点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];

    [_rightVC.view addGestureRecognizer:tap];

    _tap = tap;
    
}

#pragma mark - 实现点按手势的方法
- (void)tap:(UITapGestureRecognizer *)sender {
    
    [self closeLeftVC];
    
}

#pragma mark - 删除左边拖拽手势
- (void)closeLeftVC {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _rightVC.view.transform = CGAffineTransformIdentity;
        
    }];
    //删除拖拽手势
    [_rightVC.view removeGestureRecognizer:_tap];
    //添加拖拽手势
    [self.view addGestureRecognizer:_pan];
}

#pragma mark - 判断是否为首页
- (BOOL)isTopviewController {
    
    UITabBarController *rightVC = (UITabBarController *)_rightVC;
    UINavigationController *nav = rightVC.selectedViewController;
    if (nav.viewControllers.count > 1) {
        return NO;
    }else {
        return YES;
    }
}



@end
