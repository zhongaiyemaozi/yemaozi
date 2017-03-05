//
//  QQAddContactViewController.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQAddContactViewController.h"
#import "QQCommonViewController.h"
#import "SGGenerateQRCodeVC.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"

@interface QQAddContactViewController ()

@end

@implementation QQAddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载Plist
    [self loadDataWithPlistName:@"functionAddContact.plist"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 1、 获取摄像设备
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (device) {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status == AVAuthorizationStatusNotDetermined) {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                            self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
                            [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
                            NSLog(@"主线程 - - %@", [NSThread currentThread]);
                        });
                        NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                        
                        // 用户第一次同意了访问相机权限
                        NSLog(@"用户第一次同意了访问相机权限");
                        
                    } else {
                        
                        // 用户第一次拒绝了访问相机权限
                        NSLog(@"用户第一次拒绝了访问相机权限");
                    }
                }];
            } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
                SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                [self.navigationController pushViewController:scanningQRCodeVC animated:YES];
            } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
                SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
                [alertView show];
            } else if (status == AVAuthorizationStatusRestricted) {
                NSLog(@"因为系统原因, 无法访问相册");
            }
        } else {
            SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
            [alertView show];
        }
        
        
    }else {
        //取消选中状态
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        QQCommonViewController *commonVC = [[QQCommonViewController alloc]init];
        
        [self.navigationController pushViewController:commonVC animated:YES];

    }
    
}


@end
