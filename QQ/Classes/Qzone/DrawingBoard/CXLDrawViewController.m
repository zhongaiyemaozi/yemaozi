//
//  CXLDrawViewController.m
//  小画板
//
//  Created by 夜猫子 on 2017/3/4.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "CXLDrawViewController.h"
#import "CXLPanelView.h"

@interface CXLDrawViewController ()

@property (weak, nonatomic) IBOutlet CXLPanelView *panelView;


@end

@implementation CXLDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"小画板";
    
    
}

//清除按钮
- (IBAction)clearDraw:(UIButton *)sender {
    
    //清除面板View的路径数组
    [_panelView.pathList removeAllObjects];
    //重绘
    [_panelView setNeedsDisplay];
    
}

//保存按钮
- (IBAction)saveDrawBtn:(id)sender {
    //参数1：图片大小
    //参数2：是否不透明 YES为不透明，NO为透明
    //参数3：缩放因子，传入0，则会自动根据屏幕来得到缩放因子
    UIGraphicsBeginImageContextWithOptions(_panelView.bounds.size, YES, 0);
    //绘制东西到上下文（跳到UIView的头文件，最下面那个方法就是从UIView里面截图保存到上下文）
    //第一个参数：截多大范围
    //第二个参数：截屏后是否刷新
    [_panelView drawViewHierarchyInRect:_panelView.bounds afterScreenUpdates:YES];
    
    //从当前的图片上下文中获取一张图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    //要把图片输出到相册,是一个非常固定的函数，这个函数为了方便你们以后用，请记得记在小本子上
    //根图片有关，所以先敲UIImage，跟保存有关，所以再敲save
    //参数1：保存那张图片
    //参数2和参数3：就是当保存完毕后调用哪个对象的哪个方法
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    //结束图片上下文
    UIGraphicsEndImageContext();
    
    
}


//图片写入相册完毕会调用的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        
        NSLog(@"%@",error);
    }else{
        
        NSLog(@"保存成功");
    }
    
}

//滑块
- (IBAction)changeSizeValue:(UISlider *)sender {
    
    self.panelView.lineWidth = sender.value;
    
}

//颜色
- (IBAction)changColor:(UIButton *)sender {
    
    self.panelView.lineColor = sender.backgroundColor;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
