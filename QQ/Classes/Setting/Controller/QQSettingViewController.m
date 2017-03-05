//
//  QQSettingViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQSettingViewController.h"
#import "QQAboutViewController.h"
#import "QQCommonViewController.h"

@interface QQSettingViewController ()

@end

@implementation QQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载Plist文件
    [self loadDataWithPlistName:@"functionSettings.plist"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 选中每一行调用的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 3 && indexPath.item == 0) {
        //取消这一行的选中状态
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        QQAboutViewController *vc = [QQAboutViewController new];
        
        vc.view.backgroundColor = [UIColor whiteColor];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        QQCommonViewController *commonVC = [[QQCommonViewController alloc]init];
        
        [self.navigationController pushViewController:commonVC animated:YES];
        
        
    }
}

@end
