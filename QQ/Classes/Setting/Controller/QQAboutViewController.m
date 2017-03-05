//
//  QQAboutViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQAboutViewController.h"
#import "QQCommonViewController.h"

@interface QQAboutViewController ()

@end

@implementation QQAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataWithPlistName:@"About.plist"];
    
    [self setHeader];
}

#pragma mark - 页面搭建
-(void)setHeader{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 150)];

    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_about_pic"]];
    
    [headerView addSubview:iv];
    
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView);
        make.top.equalTo(headerView).offset(8);
        
    }];
    
    //创建版本label
    UILabel *lbl = [UILabel new];
    
    lbl.text = @"V4.8.1001";
    
    [headerView addSubview:lbl];
    
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(headerView);
        make.top.equalTo(iv.mas_bottom).offset(8);
    }];

    self.tableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDelegate代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQCommonViewController *commonVC = [[QQCommonViewController alloc]init];
    
    [self.navigationController pushViewController:commonVC animated:YES];
    
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
