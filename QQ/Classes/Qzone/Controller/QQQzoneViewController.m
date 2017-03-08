//
//  QQQzoneViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQQzoneViewController.h"
#import "QQQzoneOneCell.h"
#import "QQPhoneTableViewController.h"

@interface QQQzoneViewController ()<UITableViewDataSource,UISearchResultsUpdating,UITableViewDelegate>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSArray *arrList;

@end

static NSString *qzoneCell = @"qzoneCell";

@implementation QQQzoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
       
    [self loadData];
    
}


- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView = tableView;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorColor = [UIColor darkGrayColor];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(44);
        make.left.top.right.equalTo(self.view);
    }];
    
    
    QQQzoneOneCell *topView = [QQQzoneOneCell zoneOneCell];
    self.tableView.tableHeaderView = topView;
    self.searchController.searchResultsUpdater = self;

    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:qzoneCell];
    
    
    
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:qzoneCell forIndexPath:indexPath];
    
    cell.textLabel.text = _arrList[indexPath.row];
    
    return cell;
}



#pragma mark - 搜索框搭建
- (UISearchController *)searchController
{
    if (!_searchController) {
        QQSearchResultsTableViewController *searchResultsViewController = [[QQSearchResultsTableViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController];
        // 传入nil表示使用当前控制器
        _searchController.searchBar.frame = CGRectMake(0, 0, 200, 44);
        _searchController.searchBar.placeholder = @"搜索电影/音乐/商品...";
    }
    return _searchController;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 创建临时数组，存放搜索到的内容
    NSMutableArray *tempArray = [NSMutableArray array];
    NSString *text = searchController.searchBar.text;
    for (NSString *item in self.dataArray) {
        if (text.length != 0 && [item containsString:text]) {
            [tempArray addObject:item];
        }
    }
    
    // 给searchResultViewController进行传值，并且reloadData
    QQSearchResultsTableViewController *searchResultsViewController = (QQSearchResultsTableViewController *)searchController.searchResultsController;
    searchResultsViewController.tableView.frame = CGRectMake(0, 64, YFScreen.width, YFScreen.height - 64);
    searchResultsViewController.searchDataArray = [NSMutableArray arrayWithArray:tempArray];
    [searchResultsViewController.tableView reloadData];
}

#pragma mark - 加载数据
- (void)loadData {
    
    NSString *str = [[NSBundle mainBundle]pathForResource:@"OneProperty List.plist" ofType:nil];
    
    _arrList = [NSArray arrayWithContentsOfFile:str];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        QQPhoneTableViewController *phoneVC = [[QQPhoneTableViewController alloc]init];
        
        [self.navigationController pushViewController:phoneVC animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        
        UIStoryboard *SB = [UIStoryboard storyboardWithName:@"CXLDrawViewController" bundle:nil];
        
        UIViewController *drawVC = [SB instantiateInitialViewController];
        
        [self.navigationController pushViewController:drawVC animated:YES];
        
    }
    
    
}


@end
