//
//  QQLookPublicViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/21.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQLookPublicViewController.h"
#import "QQContactAddSearchController.h"
#import "QQCommonViewController.h"

@interface QQLookPublicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;
@end

static NSString *oneCell = @"oneCell";

@implementation QQLookPublicViewController



- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    _tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    //MARK:注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:oneCell];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark - 搜索框搭建
- (UISearchController *)searchController
{
    if (!_searchController) {
        QQContactAddSearchController *searchResultsViewController = [[QQContactAddSearchController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController]; // 传入nil表示使用当前控制器
        _searchController.searchBar.frame = CGRectMake(10, 10, 200, 44);
        _searchController.searchBar.placeholder = @"QQ号/手机号/群/公众号";
    }
    return _searchController;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell forIndexPath:indexPath];
    
    cell.textLabel.text = @"正在建设中";
    
    return cell;
}

#pragma mark - UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    QQCommonViewController *commonVC = [[QQCommonViewController alloc]init];
    [self.navigationController pushViewController:commonVC animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
