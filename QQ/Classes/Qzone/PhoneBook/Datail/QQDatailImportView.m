//
//  QQDatailImportView.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/24.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQDatailImportView.h"

@interface QQDatailImportView ()




@end


@implementation QQDatailImportView

- (instancetype)init {
    
    if ( self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    
}

+(instancetype)datatilImportView{
    
    UINib *nib = [UINib nibWithNibName:@"QQDatailImportView" bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil]firstObject];
    
}

- (void)setupUI {
    
    
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
