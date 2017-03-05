//
//  CXLPanelView.m
//  小画板
//
//  Created by 夜猫子 on 2017/3/4.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "CXLPanelView.h"
#import "CXLBeziePath.h"

@implementation CXLPanelView


- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _pathList = [NSMutableArray array];
    
    _lineWidth = 1;//程序启动时先给个默认值
    
}


- (void)drawRect:(CGRect)rect {
    
    //把数组中保存的所有路径都绘制出来
    for (CXLBeziePath *path in _pathList) {
        
        [path.lineColor set];
        [path stroke];
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //拿到触摸对象
    UITouch *t = touches.anyObject;
    
    //拿到按下的那个点的坐标
    CGPoint location = [t locationInView:self];
    
    //创建路径对象
    CXLBeziePath *path = [CXLBeziePath bezierPath];
    
    //把刚刚收到的线条大小值赋值给这个绘图路径
    path.lineWidth = self.lineWidth;
    
    //我们希望每个路径对象能保存自己的颜色，系统提供的没法满足，因为没有这个属性
    //所以我们要自己写一个类继承UIBezierPath，给它加属性
    path.lineColor = self.lineColor;
    
    //添加到数组
    [_pathList addObject:path];
    
    //添加起始点,把按下的点作为绘图起点
    [path moveToPoint:location];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //每移动一次，就画一条线段
    
    //拿到触摸对象
    UITouch *t = touches.anyObject;
    
    //拿到按下的那个点的坐标
    CGPoint location = [t locationInView:self];
    
    //每次move应该拿最近那次添加的路径对象，最近添加的肯定就是lastObject
    UIBezierPath *path = _pathList.lastObject;
    
    //把当前移动到的点添加到绘图路径对象中
    [path addLineToPoint:location];
    
    //重绘
    [self setNeedsDisplay];
}



@end
