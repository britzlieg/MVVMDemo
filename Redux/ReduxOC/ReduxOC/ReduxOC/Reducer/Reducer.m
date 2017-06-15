//
//  Reducer.m
//  PhantomSteward
//
//  Created by LiangHao on 10/01/2017.
//  Copyright © 2017 PhantomSmart. All rights reserved.
//

#import "Reducer.h"
#import "State.h"
#import "Action.h"

@implementation Reducer

+ (NSArray *)reducers {
    return @[[self todoReducer], [self operationReducer]];
}

+ (ReducerBlock)todoReducer {
    ReducerBlock block = ^(State **state, Action *action) {
        if (state == NULL) {
            return;
        }
        
        State* newState = *state;
        switch (action.type) {
            case ReduxActionTypeQueryAllToDo: {
                break;
            }
            case ReduxActionTypeAddToDo: {
                break;
            }
            case ReduxActionTypeEditToDo: {
                break;
            }
            case ReduxActionTypeRemoveToDo: {
                break;
            }
            default:
                break;
        }
    };
    return block;
}

+ (ReducerBlock)operationReducer {
    ReducerBlock block = ^(State **state, Action *action) {
        if (state == NULL) {
            return;
        }
        switch (action.type) {
            case ReduxActionTypeQueryAllToDo:
                break;
                
            default:
                break;
        }
    };
    return block;
}

@end
