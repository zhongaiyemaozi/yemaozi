//
//  QQMessageViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQMessageViewController.h"
#import "QQMessage.h"
#import "QQMessageCell.h"
#import "QQAddContactViewController.h"
#import "QQChatViewController.h"
#import "ODRefreshControl.h"

@interface QQMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray<QQMessage *> *OnedataList;

@property (nonatomic, strong) NSArray<QQMessage *> *TwodataList;

@property (nonatomic,weak)UISegmentedControl *segmentCtrl;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;


@end

static NSString *mesage = @"mesage";

@implementation QQMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.OnedataList = [self loadDataListWithPlistName:@"mesg.plist"];
    self.TwodataList = [self loadDataListWithPlistName:@"Two.plist"];

    
}

#pragma mark - 搜索框搭建
- (UISearchController *)searchController
{
    if (!_searchController) {
        QQSearchResultsTableViewController *searchResultsViewController = [[QQSearchResultsTableViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsViewController];
        // 传入nil表示使用当前控制器
        _searchController.searchBar.frame = CGRectMake(0, 0, 200, 44);
        _searchController.searchBar.placeholder = @"搜索";
    }
    return _searchController;
}


#pragma mark - 页面搭建
-(void)setupUI{
    
    //UITableView设置
    UITableView *tb = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView = tb;
    tb.dataSource = self;
    tb.delegate = self;
    tb.rowHeight = 70;
    tb.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tb.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tb];
    
    //设置表头
    self.tableView.tableHeaderView = self.searchController.searchBar;
  
    //右上角添加+号
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(nextVC)];
    
    UINib *nib = [UINib nibWithNibName:@"QQMessageCell" bundle:nil];
    [tb registerNib:nib forCellReuseIdentifier:mesage];
    
    //分段控件
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"分组",@"全部"]];
    _segmentCtrl = seg;
    for (NSInteger i = 0; i < seg.numberOfSegments; i++) {
        
        [seg setWidth:65 forSegmentAtIndex:i];
    }
    
    seg.selectedSegmentIndex = 0;
    
    [seg addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = seg;
    
    
}

#pragma mark - 右侧按钮点击
-(void)nextVC{
    
    QQAddContactViewController *vc = [QQAddContactViewController new];
    
    vc.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.segmentCtrl.selectedSegmentIndex == 0) {
        return self.OnedataList.count;
    }else {
        return self.TwodataList.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.segmentCtrl.selectedSegmentIndex == 0) {
    QQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:mesage forIndexPath:indexPath];
  
        cell.frindData = self.OnedataList[indexPath.row];
        return cell;
    }else {
        QQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:mesage forIndexPath:indexPath];
        cell.frindData = self.TwodataList[indexPath.row];
        return cell;
    }
 
}


#pragma mark - 加载数据
- (NSArray *)loadDataListWithPlistName:(NSString *)plistName {
    
    NSArray *arr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:plistName withExtension:nil]];
    
    NSMutableArray *arrM = [[NSMutableArray alloc]initWithCapacity:arr.count];
    
    for (NSDictionary *dict in arr) {
        
        QQMessage *model = [[QQMessage alloc]initWithDict:dict];
        
        [arrM addObject:model];
        
    }
    return arrM.copy;
}


#pragma mark - 分段控件触发方法
-(void)changeSegment:(UISegmentedControl *)seg{
//    NSLog(@"%zd",seg.selectedSegmentIndex);

    //刷新tableView
    [_tableView reloadData];
}


#pragma mark - 拖拽tableView退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 结束编辑会让当前view能的所有文本输入框退出键盘
    [self.view endEditing:YES];

    
}

#pragma mark - 点击跳转到聊天的控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    QQChatViewController *chat = [[QQChatViewController alloc]init];

    [self.navigationController pushViewController:chat animated:YES];
    
}


@end
