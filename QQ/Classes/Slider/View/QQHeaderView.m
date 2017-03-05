//
//  QQHeaderView.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/20.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQHeaderView.h"

@interface QQHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *IconBtn;


@end

@implementation QQHeaderView

- (instancetype)init {
    
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    
    _IconBtn.imageView.layer.cornerRadius = 43 / 2;
    _IconBtn.imageView.layer.masksToBounds = YES;
    
}


@end
