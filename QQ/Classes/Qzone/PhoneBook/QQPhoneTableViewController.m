//
//  QQPhoneTableViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/3/4.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQPhoneTableViewController.h"
#import "QQContact.h"
#import "QQDetailViewController.h"
#import "QQContactViewCell.h"

@interface QQPhoneTableViewController ()<UISearchResultsUpdating,QQDetailViewControllerDelegate>

@property (nonatomic, strong) QQDetailViewController *detail;

@property (nonatomic, strong) UISearchController *searchController;

@end

static NSString *phoneCell = @"phoneCell";

@implementation QQPhoneTableViewController{
    
    //专门保存模型对象的数组
    NSMutableArray<QQContact *> *_modelList;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchResultsUpdater = self;
    [self loadData];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clickedAddButton:)];
    
    self.navigationItem.rightBarButtonItems = @[barBtn,self.editButtonItem];
    
    [self.tableView registerClass:[QQContactViewCell class] forCellReuseIdentifier:phoneCell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _modelList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:phoneCell forIndexPath:indexPath];
    
//    cell.title.text = _modelList[indexPath.row].name;
    
//    cell.detail.text = _modelList[indexPath.row].phone;
    
    
    cell.textLabel.text =_modelList[indexPath.row].name;
    
    cell.detailTextLabel.text = _modelList[indexPath.row].phone;
    
    return cell;
}
#pragma mark - 数据持久化代码
#pragma mark - 加载数据（取）

- (void)loadData {
    
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"chen.cm"];
    
    _modelList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    if (_modelList == nil) {
        
        _modelList = [NSMutableArray array];
    }
}


#pragma mark - UItableView 的代理方法(选中某一行会调用)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    QQDetailViewController *detail = [[QQDetailViewController alloc]init];
    _detail = detail;
    detail.delegate = self;
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (_modelList[indexPath.row]) {

        _detail.model = _modelList[indexPath.row];

    }

    [self pushVC];

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
    for (QQContact *item in _modelList) {
        if (text.length != 0 && [item.name containsString:text]) {
            [tempArray addObject:item.name];
        }else if (text.length != 0 && [item.phone containsString:text]){
            [tempArray addObject:item.phone];
        }
    }
    
    // 给searchResultViewController进行传值，并且reloadData
    QQSearchResultsTableViewController *searchResultsViewController = (QQSearchResultsTableViewController *)searchController.searchResultsController;
    searchResultsViewController.tableView.frame = CGRectMake(0, 64, YFScreen.width, YFScreen.height - 64);
    searchResultsViewController.searchDataArray = [NSMutableArray arrayWithArray:tempArray];
    [searchResultsViewController.tableView reloadData];
}


//MARK:跳转调用的方法
- (void)pushVC {
    
    _detail.delegate = self;
    _detail.hidesBottomBarWhenPushed = YES;
    _detail.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:_detail animated:YES];
    
    
}

#pragma mark - 实现侧滑效果，侧滑里多一个删除按钮(此方式是 UITableView 的数据源方法)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //它会把当前的编辑状态传进来，如果是删除，那么editingStyle就等于UITableViewCellEditingStyleDelete
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //先删除数组中的元素
        [_modelList removeObjectAtIndex:indexPath.row];
        //刷新tableView
        [self.tableView reloadData];
        
        //删除某行并有动画效果的方法
        //第一个参数：是一个数组，如果你需要删除多行，那么把这些行的索引包装成数组传递
        //第二个参数：动画效果的样式
        //使用这个方法之前，必须先删除数组中的元素，否则会报错
        //        [self.tableView deleteSections:@[ indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
        
        
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        
        
        //状态是插入
        
    }
    
}

#pragma mark - 修改组头
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
    
}

#pragma mark - 移动cell
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //先保存要移动的数据
    QQContact *model = _modelList[sourceIndexPath.row];
    //删除数组中要移动的这个数据
    [_modelList removeObjectAtIndex:sourceIndexPath.row];
    //再插入之前的数据到要移动的位置
    [_modelList insertObject:model atIndex:sourceIndexPath.row];
    
    
    [self saveData];
}

#pragma mark - 返回侧滑按钮的数组
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteAC = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //先删除数组中的元素
        [_modelList removeObjectAtIndex:indexPath.row];
        
        
        //刷新tableView
        //[self.tableView reloadData];//全部刷新，而且没有动画效果
        
        //删除某行并有动画效果的方法
        //第一个参数：是一个数组，如果你需要删除多行，那么把这些行的索引包装成数组传递
        //第二个参数：动画效果的样式
        //使用这个方法之前，必须先删除数组中的元素，否则会报错
        [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self saveData];
    }];
    
    UITableViewRowAction *collectAc = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了收藏");
    }];
    
    collectAc.backgroundColor = [UIColor redColor];
    
    return @[ deleteAC,collectAc ];
    
}

#pragma mark - cell是否可以排序，YES代表可以，NO代表不
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


#pragma mark - 点击了左侧+号按钮来添加联系人
- (void)clickedAddButton:(UIBarButtonItem *)sender {
    QQDetailViewController *detail = [[QQDetailViewController alloc]init];
    _detail = detail;
    [self pushVC];
}


#pragma mark - 实现详情控制器的代理方法
- (void)detailVC:(QQDetailViewController *)vc withModel:(QQContact *)model {
    
    if (![_modelList containsObject:model]) {
        
        [_modelList addObject:model];
        
    }
    [self.tableView reloadData];
    
    [self saveData];
    
    
}





#pragma mark - 加载数据（存）
- (void)saveData {
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"chen.cm"];
    
    //归档
    [NSKeyedArchiver archiveRootObject:_modelList toFile:path];
}



@end

