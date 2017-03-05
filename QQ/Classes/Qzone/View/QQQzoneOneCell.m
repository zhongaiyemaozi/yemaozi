//
//  QQQzoneOneCell.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/24.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQQzoneOneCell.h"

@implementation QQQzoneOneCell

+(instancetype)zoneOneCell{
    
    UINib *nib = [UINib nibWithNibName:@"QQQzoneOneCell" bundle:nil];
    
    return [[nib instantiateWithOwner:nil options:nil]firstObject];
}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
