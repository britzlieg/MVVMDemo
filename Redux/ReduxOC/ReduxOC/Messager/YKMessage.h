//
//  YKMessage.h
//  ReduxOC
//
//  Created by ZhijieLi on 15/06/2017.
//  Copyright © 2017 britzlieg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKMessage : NSObject

/**
 消息唯一标识
 */
@property (nonatomic, readonly) NSString *identify;

/**
 消息内容
 */
@property (nonatomic, readonly) id context;

/**
 消息初始化函数

 @param identify 消息唯一标识
 @param context 内容
 @return 消息
 */
- (instancetype)initWithIdentify: (NSString *)identify context: (id)context;


@end
