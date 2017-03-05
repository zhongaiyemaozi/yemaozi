//
//  QQContactViewCell.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/24.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQContactViewCell.h"


@interface QQContactViewCell ()




@end

@implementation QQContactViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ( self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
    
}

- (void)setupUI {
    
    //设置cell右边的>
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *title = [[UILabel alloc]init];
    _title = title;
    [self.contentView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    UILabel *detail = [[UILabel alloc]init];
    _detail = detail;
    [self.contentView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).offset(-self.contentView.bounds.size.width /4);
        make.top.equalTo(title.mas_top);
    }];
  
}

@end
