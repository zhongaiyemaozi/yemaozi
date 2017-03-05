//
//  QQDetailViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/22.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQDetailViewController.h"
#import "QQDatailImportView.h"
#import "QQContact.h"

@interface QQDetailViewController ()

@property (nonatomic, strong) QQDatailImportView *headerView;

@end

@implementation QQDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickedSaveButton:)];
    self.navigationItem.title = @"编辑";
    
}


#pragma mark - 重写setter方法
- (void)setModel:(QQContact *)model {
 
    _model = model;
    
}

#pragma mark - 页面布局
- (void)setupUI {
    
    QQDatailImportView *headerView = [QQDatailImportView datatilImportView];
    _headerView = headerView;
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    self.headerView.nameLabel.text = self.model.name;
    self.headerView.phoneLabel.text = self.model.phone;
    
    
}

#pragma mark - 点击了保存按钮
- (void)clickedSaveButton:(UIBarButtonItem *)sender {
    
    if (_model) {
        
        _model.name = self.headerView.nameLabel.text;
        _model.phone = self.headerView.phoneLabel.text;
        
        [self.delegate detailVC:self withModel:_model];
        
    }else {
        
        QQContact *model = [[QQContact alloc]init];
        
        model.name = self.headerView.nameLabel.text;
        model.phone = self.headerView.phoneLabel.text;
        [self.delegate detailVC:self withModel:model];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
