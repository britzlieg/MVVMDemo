//
//  YKDispatchCenter.h
//  ReduxOC
//
//  Created by ZhijieLi on 15/06/2017.
//  Copyright © 2017 britzlieg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKMessage.h"


/**
 回调闭包

 @param message 消息
 @param ext 扩展参数，暂时没用
 */
typedef void (^YKDispatchCenterHandler)(YKMessage *message,id ext);

@interface YKDispatchCenter : NSObject

/**
 单例方法

 @return 单例
 */
+ (instancetype)shared;

/**
 分发消息

 @param message 消息
 */
- (void)dispatchMessage: (YKMessage *)message;


/**
 订阅消息

 @param binder 绑定者
 @param messageIdentify 消息唯一标识
 @param handler 收到消息的回调
 
 - note: 当绑定者binder被回收，handler将不会被执行
 */
- (void)subscribeWithBinder: (NSObject *)binder messageIdentify: (NSString *)messageIdentify handler: (YKDispatchCenterHandler)handler;

/**
 手动清理消息列表中的绑定者已被回收的消息
 */
- (void)manualClean;

/**
 注册消息

 @param messageIdentify 消息唯一标识
 @return 注册结果
 */
- (BOOL)registerMessageWithIdentify: (NSString *)messageIdentify;

/**
 反注册消息

 @param messageIdentify 消息唯一标识
 @return 反注册结果
 */
- (BOOL)unRegisterMessageWithIdentify: (NSString *)messageIdentify;

@end
