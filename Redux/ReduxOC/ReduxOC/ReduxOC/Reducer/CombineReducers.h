//
//  CombineReducers.h
//  ReduxOC
//
//  Created by ZhijieLi on 09/06/2017.
//  Copyright © 2017 britzlieg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reducer.h"

@interface CombineReducers : NSObject

@property (nonatomic, strong, readonly) NSArray<ReducerBlock> *combineReducers;

+ (void)registReducer: (NSString *)reducerName;

+ (void)unRegisgerReducer: (NSString *)reducerName;

@end
