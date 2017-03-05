//
//  QQContact.m
//  QQ
//
//  Created by 夜猫子 on 2017/2/22.
//  Copyright © 2017年 夜猫子. All rights reserved.
//

#import "QQContact.h"

@implementation QQContact

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    _name = [aDecoder decodeObjectForKey:@"name"];
    
    _phone = [aDecoder decodeObjectForKey:@"phone"];
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_name forKey:@"name"];
    
    [aCoder encodeObject:_phone forKey:@"phone"];
    
}

@end
