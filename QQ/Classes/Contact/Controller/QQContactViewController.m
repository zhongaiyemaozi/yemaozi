//
//  QQContactViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQContactViewController.h"
#import "QQAddAnyViewController.h"
#import "QQChatViewController.h"
#import "QQMessageCell.h"
#import "QQMessage.h"
static NSString *rid = @"contact";

@interface QQContactViewController () <UITableViewDataSource,UISearchResultsUpdating,UITableViewDelegate>

@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic, strong) NSArray<QQMessage *> *TwodataList;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation QQContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.TwodataList = [self loadData];
    
    [self setupUI];

}

#pragma mark - 页面搭建
-(void)setupUI{
    
    UITableView *tb = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tb.dataSource = self;
    tb.delegate = self;
    tb.rowHeight = 70;
    
    UINib *nib = [UINib nibWithNibName:@"QQMessageCell" bundle:nil];
    [tb registerNib:nib forCellReuseIdentifier:rid];
    
    [self.view addSubview:tb];
    
    
    self.tableView = tb;

    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchResultsUpdater = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightToVC)];
    self.navigationItem.rightBarButtonItem = btn;
    
}

#pragma mark - 右上角添加的点击事件
- (void)rightToVC {
    
    QQAddAnyViewController *addAny = [[QQAddAnyViewController alloc]init];
    
    [self.navigationController pushViewController:addAny animated:YES];

}

#pragma mark - 搜索框
- (UISearchController *)searchController
{
    if (!_searchController) {
        QQSearchResultsTableViewController *searchResultsViewController = [[QQSearchResultsTableViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController]; // 传入nil表示使用当前控制器
        _searchController.searchBar.frame = CGRectMake(0, 0, 200, 44);
        _searchController.searchBar.placeholder = @"搜索号码";
    }
    return _searchController;
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 创建临时数组，存放搜索到的内容
    NSMutableArray *tempArray = [NSMutableArray array];
    NSString *text = searchController.searchBar.text;
    for (QQMessage *item in _TwodataList) {
        if (text.length != 0 && [item.name containsString:text]) {
            [tempArray addObject:item.name];
        }
    }
    
    // 给searchResultViewController进行传值，并且reloadData
    QQSearchResultsTableViewController *searchResultsViewController = (QQSearchResultsTableViewController *)searchController.searchResultsController;
    searchResultsViewController.tableView.frame = CGRectMake(0, 64, YFScreen.width, YFScreen.height - 64);
    searchResultsViewController.searchDataArray = [NSMutableArray arrayWithArray:tempArray];
    [searchResultsViewController.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _TwodataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    
    cell.frindData = self.TwodataList[indexPath.row];
    
    return cell;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    QQChatViewController *chat = [[QQChatViewController alloc]init];
    
    [self.navigationController pushViewController:chat animated:YES];
    
}

- (NSArray *)loadData {
    
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"mesg.plist" withExtension:nil];
    
    NSArray *arr = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrM = [[NSMutableArray alloc]initWithCapacity:arr.count];
    
    for (NSDictionary *dict in arr) {
        
        QQMessage *model = [[QQMessage alloc]init];
        
        [model setValuesForKeysWithDictionary:dict];
        
        [arrM addObject:model];
    }
    
    return arrM.copy;
    
}




@end
