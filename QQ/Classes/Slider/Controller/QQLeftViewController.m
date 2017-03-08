//
//  QQLeftViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQLeftViewController.h"
#import "QQSliderModel.h"
#import "QQSliderCell.h"
#import "QQHeaderView.h"
#import "QQSettingViewController.h"
#import "QQSliderViewController.h"
#import "QQMainViewController.h"
#import "QQCommonViewController.h"

@interface QQLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property(nonatomic,weak)QQHeaderView* topView;
@property (nonatomic, strong) NSArray<QQSliderModel *> *SliData;

@end

static NSString *sliCell = @"cell";

@implementation QQLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    //加载数据
    self.SliData = [self loadData];
    
    [self setupUI];

    
}

#pragma mark - 页面搭建
- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[QQSliderCell class] forCellReuseIdentifier:sliCell];
    
    tableView.rowHeight = 48;
    //取消分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UINib *nib = [UINib nibWithNibName:@"QQHeader" bundle:nil];
    QQHeaderView *topView = [[nib instantiateWithOwner:nil options:nil]firstObject];
    tableView.tableHeaderView = topView;
    
    
    UIView *footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(70);
    }];
    
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    [setBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [footView addSubview:setBtn];
    
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(footView);

    }];
    [setBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.SliData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:sliCell forIndexPath:indexPath];
    
    cell.model = self.SliData[indexPath.row];
    
    return cell;
}



#pragma mark - 加载数据
- (NSArray *)loadData {
    
    NSArray *arr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"LeftSlider.plist" withExtension:nil]];
    
    NSMutableArray *arrM = [[NSMutableArray alloc]initWithCapacity:arr.count];
    
    for (NSDictionary *dict in arr) {
        
        QQSliderModel *model = [[QQSliderModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [arrM addObject:model];
    }
    return arrM.copy;
    
}


#pragma mark - 实现设置点击事件
- (void)clickButton:(UIButton *)btn {

    QQSliderViewController *sliderVC = (QQSliderViewController *)self.parentViewController;
    
    QQMainViewController *rightVC = (QQMainViewController *)sliderVC.rightVC;
    
    UINavigationController *nav = rightVC.selectedViewController;

    QQSettingViewController *vc = [[QQSettingViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];

    [nav pushViewController:vc animated:YES];

    [sliderVC closeLeftVC];
    
}

#pragma mark - UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //让点击有动画效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QQSliderViewController *sliderVC = (QQSliderViewController *)self.parentViewController;
    
    QQMainViewController *rightVC = (QQMainViewController *)sliderVC.rightVC;
    
    UINavigationController *nav = rightVC.selectedViewController;
    
    QQCommonViewController *vc = [[QQCommonViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];

    [nav pushViewController:vc animated:YES];
    
    [sliderVC closeLeftVC];
}

@end
