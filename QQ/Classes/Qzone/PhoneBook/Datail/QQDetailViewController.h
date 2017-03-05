//
//  QQDetailViewController.h
//  QQ
//
//  Created by 夜猫子 on 2017/2/22.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QQDetailViewController,QQContact;

@protocol QQDetailViewControllerDelegate <NSObject>

- (void)detailVC:(QQDetailViewController *)vc withModel:(QQContact *)model;

@end

@interface QQDetailViewController : UIViewController

@property (nonatomic, weak) id<QQDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) QQContact *model;

@end
