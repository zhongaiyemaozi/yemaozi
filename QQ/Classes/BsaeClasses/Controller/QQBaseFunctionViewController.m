//
//  QQBaseFunctionViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQBaseFunctionViewController.h"
#import "QQFuctionModel.h"
#import "QQFunctionCell.h"

@interface QQBaseFunctionViewController ()

@end

@implementation QQBaseFunctionViewController{
    
    NSArray<NSArray *> *_modelList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

#pragma mark - 加载数据
-(void)loadDataWithPlistName:(NSString *)plistName{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    
    NSArray *arrayAll = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray array];

    for (NSArray *dictArr in arrayAll) {

        NSMutableArray *modelArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArr) {

            QQFuctionModel *model = [QQFuctionModel new];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [modelArray addObject:model];
        }

        [arrayM addObject:modelArray];
    }

    _modelList = arrayM.copy;
}

#pragma mark - 实现数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _modelList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray *sectionArr = _modelList[section];

    return sectionArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *sectionArr = _modelList[indexPath.section];

    QQFuctionModel *model = sectionArr[indexPath.row];

    NSString *rid = model.detail.length > 0 ? @"detail" : @"normal";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];

    cell.textLabel.text = model.name;
    cell.imageView.image = [UIImage imageNamed:model.icon];
    cell.detailTextLabel.text = model.detail;

    return cell;
}

#pragma mark - 页面搭建
-(void)setupUI{

    UITableView *tb = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];

    tb.dataSource = self;

    tb.delegate = self;
    
    [tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normal"];
    [tb registerClass:[QQFunctionCell class] forCellReuseIdentifier:@"detail"];

    [self.view addSubview:tb];

    _tableView = tb;
}


@end
