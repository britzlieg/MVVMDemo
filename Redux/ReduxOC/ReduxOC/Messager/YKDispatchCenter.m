//
//  YKDispatchCenter.m
//  ReduxOC
//
//  Created by ZhijieLi on 15/06/2017.
//  Copyright © 2017 britzlieg. All rights reserved.
//

#import "YKDispatchCenter.h"

static YKDispatchCenter *_shareCenter = nil;

@interface YKDispatchCenter()

@property (nonatomic, strong) NSMutableDictionary<NSString *,id> *registerDictionary;

@property (nonatomic, strong) dispatch_queue_t serialQueue;

@property (nonatomic, strong) NSMutableDictionary *actionDictionary;

@end

@implementation YKDispatchCenter

#pragma mark - Public
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareCenter = [[YKDispatchCenter alloc]init];
    });
    return _shareCenter;
}

- (void)dispatchMessage: (YKMessage *)message {
    if (message == nil) {
        return;
    }
    if (![self.registerDictionary.allKeys containsObject:message.identify]) {
        return;
    }
    [self dealMessage:[message copy]];
}

- (void)subscribeWithBinder: (NSObject *)binder messageIdentify: (NSString *)messageIdentify handler: (YKDispatchCenterHandler)handler {
    if (![self.registerDictionary.allKeys containsObject:messageIdentify]) {
        return;
    }
    if (![self.actionDictionary.allKeys containsObject:messageIdentify]) {

        NSMutableArray *actionArray = [[NSMutableArray alloc]init];
        [actionArray addObject:[handler copy]];

        NSPointerArray *pointerArray = [NSPointerArray weakObjectsPointerArray];
        [pointerArray addPointer:(__bridge void * _Nullable)(binder)];

        NSMutableDictionary *mDictionary = [[NSMutableDictionary alloc]init];
        [mDictionary setObject:actionArray forKey:@"actions"];
        [mDictionary setObject:pointerArray forKey:@"binders"];

        [self.actionDictionary setObject:mDictionary forKey:messageIdentify];

        return;
    }
    NSMutableDictionary *mDictionary = [self.actionDictionary objectForKey:messageIdentify];

    NSMutableArray *actionArray = [mDictionary objectForKey:@"actions"];
    [actionArray addObject:[handler copy]];

    NSPointerArray *pointerArray = [mDictionary objectForKey:@"binders"];
    [pointerArray addPointer:(__bridge void * _Nullable)(binder)];

    [mDictionary setObject:actionArray forKey:@"actions"];
    [mDictionary setObject:pointerArray forKey:@"binders"];

    [self.actionDictionary setObject:mDictionary forKey:messageIdentify];
}

- (BOOL)registerMessageWithIdentify: (NSString *)messageIdentify {
    if ([self.registerDictionary.allKeys containsObject:messageIdentify]) {
        return NO;
    }
    [self.registerDictionary setValue:@"" forKey:messageIdentify];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(observerHandler:) name:messageIdentify object:nil];
    return YES;
}

- (BOOL)unRegisterMessageWithIdentify: (NSString *)messageIdentify {
    if (![self.registerDictionary.allKeys containsObject:messageIdentify]) {
        return NO;
    }
    [self.registerDictionary removeObjectForKey:messageIdentify];
    [self.actionDictionary removeObjectForKey:messageIdentify];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:messageIdentify object:nil];
    return YES;
}

#pragma mark - Private
- (void)dealMessage: (YKMessage *)message {
    // 实现异步发送通知
    dispatch_async(self.serialQueue, ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:message.identify object:message];
    });
}

- (void)observerHandler: (NSNotification *)notification {
    // 实现异步接收通知
    dispatch_async(self.serialQueue, ^{
        YKMessage *object = (YKMessage *)notification.object;
        if (object != nil) {
            NSString *messageIdentify = object.identify;
            [self actionAndCleanWithMessageIdentify:messageIdentify message:object doHandler:YES];
        }
    });
}

- (void)actionAndCleanWithMessageIdentify: (NSString *)messageIdentify message: (YKMessage *)message doHandler: (BOOL)doHandler {
    NSMutableDictionary *mDictionary = [self.actionDictionary objectForKey:messageIdentify];
    NSMutableArray *actionArray = [mDictionary objectForKey:@"actions"];
    NSPointerArray *pointerArray = [mDictionary objectForKey:@"binders"];

    NSMutableArray *needRemoveIndexs = [[NSMutableArray alloc]init];

    for (int i=0; i<actionArray.count; i++) {
        id action = [actionArray objectAtIndex:i];
        id binder = [pointerArray pointerAtIndex:i];

        if (binder != nil && binder != NULL) {
            if (doHandler == YES) {
                YKDispatchCenterHandler handler = (YKDispatchCenterHandler)action;
                if (handler) {
                    handler(message,nil);
                }
            }
        }
        else {
            [needRemoveIndexs addObject:@(i)];
        }
    }

    // remove Indexs
    for (int j=0; j<needRemoveIndexs.count; j++) {
        int removeIndex = [needRemoveIndexs[j]intValue];
        [actionArray removeObjectAtIndex:removeIndex];
        [pointerArray removePointerAtIndex:removeIndex];
    }

    [mDictionary setObject:actionArray forKey:@"actions"];
    [mDictionary setObject:pointerArray forKey:@"binders"];

    [self.actionDictionary setObject:mDictionary forKey:messageIdentify];
}

- (void)manualClean {
    for (int i=0; self.registerDictionary.allKeys.count; i++) {
        NSString *messageIdentify = self.registerDictionary.allKeys[i];
        [self actionAndCleanWithMessageIdentify:messageIdentify message:nil doHandler:NO];
    }
}

#pragma mark - Getter
- (NSMutableDictionary<NSString *,id> *)registerDictionary {
    if (!_registerDictionary) {
        _registerDictionary = [[NSMutableDictionary<NSString *,id> alloc]init];
    }
    return _registerDictionary;
}

- (NSMutableDictionary *)actionDictionary {
    if (!_actionDictionary) {
        _actionDictionary = [[NSMutableDictionary alloc]init];
    }
    return _actionDictionary;
}

- (dispatch_queue_t)serialQueue {
    if (!_serialQueue) {
        _serialQueue = dispatch_queue_create("dispatch_serialQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _serialQueue;
}


@end
