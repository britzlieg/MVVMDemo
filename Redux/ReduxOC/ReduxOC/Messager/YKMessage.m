//
//  YKMessage.m
//  ReduxOC
//
//  Created by ZhijieLi on 15/06/2017.
//  Copyright © 2017 britzlieg. All rights reserved.
//

#import "YKMessage.h"

@interface YKMessage()<NSCopying>

@property (nonatomic, readwrite) NSString *identify;

@property (nonatomic, readwrite) id context;

@end

@implementation YKMessage

- (instancetype)initWithIdentify: (NSString *)identify context: (id)context {
    self = [super init];
    if (self) {
        _identify = [identify copy];
        _context = [context copy];
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone {
    YKMessage *message = [[[self class]allocWithZone:zone]init];
    message.identify = self.identify;
    message.context = self.context;
    return message;
}

@end
