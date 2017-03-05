//
//  QQSliderCell.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/20.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQSliderCell.h"
#import "QQSliderModel.h"

@interface QQSliderCell ()

@property (nonatomic, weak) UIImageView *iconImage;

@property (nonatomic, weak) UILabel *nameLabel;


@end


@implementation QQSliderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
    
}

#pragma mark - 页面搭建
- (void)setupUI {
    
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    _iconImage = iconImage;
    [self.contentView addSubview:iconImage];
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(45 / 2);
        make.top.equalTo(self.contentView).offset((96 - 46) / 2);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(36 / 2);
    }];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    _nameLabel = nameLabel;
    nameLabel.text = @"激活会员";
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(45 / 2);
        make.top.bottom.equalTo(iconImage);
        make.right.equalTo(self.contentView.mas_right).offset(345 / 2);
    }];
    
}

- (void)setModel:(QQSliderModel *)model {
    
    _model = model;
    self.iconImage.image = [UIImage imageNamed:model.icon];
    self.nameLabel.text = model.name;
}

@end
