//
//  QQAddHeaderView.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/21.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQAddHeaderView.h"

@implementation QQAddHeaderView{
    
    NSMutableArray<UIButton *> *_btnList;
    UIView *_lineView;
    UIButton *_selectBtn;
}

- (instancetype)init {
    if (self = [super init]) {
        
        [self setupUI];
        
    }
    return self;
    
}

#pragma mark - 重写setter方法
- (void)setOffsetX:(CGFloat)offsetX {
    
    _offsetX = offsetX;
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(offsetX);
        
    }];
    //立即算出frame
    NSInteger index = _lineView.frame.origin.x / _lineView.bounds.size.width;
    
    //先让原来的button变成NO
    _selectBtn.selected = NO;
    //按钮数组里的某个元素
    _btnList[index].selected = YES;
    _selectBtn = _btnList[index];
    
}


#pragma mark - 页面搭建
- (void)setupUI {
    
    //MARK:创建三个按钮
    NSArray *arr = @[ @"找人",@"找群",@"找公众号" ];
    
    NSMutableArray<UIButton *> *btnArr = [[NSMutableArray alloc]initWithCapacity:arr.count];
    
    NSInteger idx = 0;
    for (NSString *str in arr) {
        
        UIButton *btn = [UIButton cz_textButton:str fontSize:14 normalColor:[UIColor blackColor] selectedColor:[UIColor blackColor]];
        
        btn.tag = idx++;
        
        [btnArr addObject:btn];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(changeCategory:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    _btnList = btnArr;
    
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        
    }];
    
    //MARK:创建蓝色条子
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor blueColor];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.height.mas_offset(4);
        make.width.equalTo(btnArr[0].mas_width);
    }];
    
    _lineView = line;
    
    //一启动默认让第0个按钮被选中
    btnArr[0].selected = YES;
    _selectBtn = btnArr[0];
}

#pragma mark - 点击了分类按钮
- (void)changeCategory:(UIButton *)sender {
    
    _selectBtn.selected = NO;
    
    sender.selected = YES;
    
    _selectBtn = sender;
    
    CGFloat offsetX = sender.tag * sender.bounds.size.width;
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(offsetX);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
       //立即更新
        [self layoutIfNeeded];
    }];
    //把当前被点击的按钮的索引赋值给整个视图的tag
    self.tag = sender.tag;
    
    
    //发送一条事件
    //相当于告诉之前跟我打招呼的那个人，我现在被点了
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}




@end
