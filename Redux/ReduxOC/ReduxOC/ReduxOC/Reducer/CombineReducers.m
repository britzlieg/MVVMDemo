//
//  CombineReducers.m
//  ReduxOC
//
//  Created by ZhijieLi on 09/06/2017.
//  Copyright © 2017 britzlieg. All rights reserved.
//

#import "CombineReducers.h"

@interface CombineReducers()

@property (nonatomic, strong, readwrite) NSArray<ReducerBlock> *combineReducers;

@end

@implementation CombineReducers

- (instancetype)init {
    self = [super init];
    if (self) {
        _combineReducers = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Getter
- (NSArray<ReducerBlock> *)combineReducers {
    return [_combineReducers copy];
}

@end
