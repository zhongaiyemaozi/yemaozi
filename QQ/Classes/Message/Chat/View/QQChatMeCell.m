//
//  QQChatMeCell.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQChatMeCell.h"
#import "QQChat.h"

@interface QQChatMeCell ()

@property (nonatomic, weak) UILabel *chatLabel;
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation QQChatMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupUI];
}

#pragma mark - 页面搭建
- (void)setupUI{
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"123";
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:timeLabel];
    
    UIImageView *avatarView = [[UIImageView alloc] init];
    avatarView.image = [UIImage imageNamed:@"1"];
    [self.contentView addSubview:avatarView];
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed:@"Dialog_green.right"];
    [self.contentView addSubview:backgroundView];
    
    UILabel *chatLabel = [[UILabel alloc] init];
    chatLabel.numberOfLines = 0;
    chatLabel.font = [UIFont systemFontOfSize:14];
    chatLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:chatLabel];
    chatLabel.preferredMaxLayoutWidth = 200;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.centerX.equalTo(self.contentView);
    }];
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
        make.top.equalTo(timeLabel.mas_bottom).offset(8);
        make.width.height.offset(40);
    }];
    
    [chatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(avatarView.mas_left).offset(-16);
        //        make.width.lessThanOrEqualTo(@200);
        make.top.equalTo(avatarView);
    }];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(chatLabel).mas_offset(UIEdgeInsetsMake(-8, -8, -8, -14));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.bottom.greaterThanOrEqualTo(backgroundView.mas_bottom);
        make.bottom.greaterThanOrEqualTo(avatarView.mas_bottom);
    }];
    
    self.timeLabel = timeLabel;
    self.chatLabel = chatLabel;
    
}

-(void)setChat:(QQChat *)chat {
    
    _chat = chat;
    self.chatLabel.text = chat.text;
    self.timeLabel.text = chat.time;
}

@end
