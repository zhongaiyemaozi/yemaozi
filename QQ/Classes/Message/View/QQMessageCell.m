//
//  QQMessageCell.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/16.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQMessageCell.h"
#import "QQMessage.h"

@interface QQMessageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end


@implementation QQMessageCell

- (void)setFrindData:(QQMessage *)frindData {
    
    self.iconImage.image = [UIImage imageNamed:frindData.icon];
    self.nameLabel.text = frindData.name;
    self.subTitleLabel.text = frindData.title;
    self.timeLabel.text = frindData.time;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    //切圆角
    _iconImage.layer.cornerRadius = 25;
    _iconImage.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
