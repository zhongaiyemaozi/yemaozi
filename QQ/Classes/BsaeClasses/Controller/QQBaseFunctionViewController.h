//
//  QQBaseFunctionViewController.h
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQBaseFunctionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
/**
 加载plist文件
 */
- (void)loadDataWithPlistName:(NSString *)PlistName;

@property(nonatomic,weak)UITableView *tableView;

@end
