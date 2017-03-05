//
//  YHModel.h
//  Expression
//
//  Created by 夜猫子 on 2017/2/19.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YHEmoticonGroup;

typedef NS_ENUM(NSUInteger, YHEmoticonType) {
    YHEmoticonTypeImage = 0, ///< 图片表情
    YHEmoticonTypeEmoji = 1, ///< Emoji表情
};

@interface YHEmoticon : NSObject
@property (nonatomic, strong) NSString *chs;  ///< 例如 [吃惊]
@property (nonatomic, strong) NSString *cht;  ///< 例如 [吃驚]
@property (nonatomic, strong) NSString *gif;  ///< 例如 d_chijing.gif
@property (nonatomic, strong) NSString *png;  ///< 例如 d_chijing.png
@property (nonatomic, strong) NSString *code; ///< 例如 0x1f60d
@property (nonatomic, assign) YHEmoticonType type;
@property (nonatomic, weak) YHEmoticonGroup *group;
@end


@interface YHEmoticonGroup : NSObject
@property (nonatomic, strong) NSString *groupID; ///< 例如 com.sina.default
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSString *nameCN; ///< 例如 浪小花
@property (nonatomic, strong) NSString *nameEN;
@property (nonatomic, strong) NSString *nameTW;
@property (nonatomic, assign) NSInteger displayOnly;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, strong) NSArray<YHEmoticon *> *emoticons;

@end

@interface YHExtraModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *icon_nor;
@property (nonatomic,copy) NSString *icon_sel;
@end


