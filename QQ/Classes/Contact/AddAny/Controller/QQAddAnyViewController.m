//
//  QQAddAnyViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/21.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQAddAnyViewController.h"
#import "QQAddHeaderView.h"

@interface QQAddAnyViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) QQAddHeaderView *headerView;

@property (nonatomic, weak) UIScrollView *scrollView;


@end

@implementation QQAddAnyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];

    self.navigationItem.title = @"添加";
}

#pragma mark - 页面搭建
- (void)setupUI {
    
    //MARK:头部视图添加
    QQAddHeaderView *topView = [[QQAddHeaderView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];

    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(28*3/2);
        make.top.equalTo(self.view).offset(64);
    }];
    _headerView = topView;
    //MARK:通知接收
    [topView addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    
    //MARK:下面视图添加ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom);
    }];
    _scrollView = scrollView;
    //遵守代理
    scrollView.delegate = self;
    NSArray *className = @[ @"QQLookManViewController",@"QQLookCrowdViewController",@"QQLookPublicViewController" ];
    
    NSMutableArray<UIView *> *viewArrM = [[NSMutableArray alloc]initWithCapacity:className.count];
    
    for (NSInteger i = 0; i < className.count; i++) {
        //把控制器实例化
        Class cls = NSClassFromString(className[i]);
        UIViewController *vc = [[cls alloc] init];
        //把控制器添加到当前控制器作为子控制器
        [self addChildViewController:vc];
        //把当前控制器的根视图加入到scrollView里面
        [scrollView addSubview:vc.view];
        //此方法必须调用,告诉控制器已经添加结束
        [vc didMoveToParentViewController:self];
        
        [viewArrM addObject:vc.view];
        
    }
    
    scrollView.pagingEnabled = YES;
    //到最后一个不允许回弹
    scrollView.bounces = NO;
    //MARK:把控制器的View进行排序
    
    [viewArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [viewArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(scrollView);
        make.size.equalTo(scrollView);
    }];
    
    
}

#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.isTracking || scrollView.isDragging || scrollView.isDecelerating) {
        
        CGFloat offset = scrollView.contentOffset.x / 3;
        
        self.headerView.offsetX = offset;
        
    }
    
}

#pragma mark - 通知调用此方法
- (void)changePage:(QQAddHeaderView *)sender {
    
    //用代码来改变scrollView的偏移量
    [_scrollView setContentOffset:CGPointMake(sender.tag * _scrollView.bounds.size.width, 0) animated:NO];
    
}



@end
