//
//  ViewModel.m
//  test
//
//  Created by ZhijieLi on 12/3/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import "ViewModel.h"
#import "Model.h"
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewModel()
@property (nonatomic) NSInteger currentPage;
@end

@implementation ViewModel

- (instancetype)init {
    self = [super init];
    self.currentPage = 0;
    return self;
}

- (void)getImagesList {
    WS(ws)
    [Model getImagesListWithPage:0 SuccessBlock:^(NSDictionary *responseObjectDict, NSError *error) {
        ws.data = responseObjectDict;
        ws.racMsg = @"success";
    } FailBlock:^(NSDictionary *responseObjectDict, NSError *error) {
        ws.data = nil;
        ws.racMsg = @"fail";

    }];
}

- (void)getNextImagesList {
    WS(ws)
    self.currentPage++;
    [Model getImagesListWithPage:self.currentPage SuccessBlock:^(NSDictionary *responseObjectDict, NSError *error) {
        ws.data = responseObjectDict;
        ws.racMsg = @"success";
    } FailBlock:^(NSDictionary *responseObjectDict, NSError *error) {
        ws.data = nil;
        ws.racMsg = @"fail";
    }];
}

- (void)getPreImagesList {
    WS(ws)
    self.currentPage = self.currentPage == 0 ? 0 : self.currentPage-1;
    [Model getImagesListWithPage:self.currentPage SuccessBlock:^(NSDictionary *responseObjectDict, NSError *error) {
        ws.data = responseObjectDict;
        ws.racMsg = @"success";
    } FailBlock:^(NSDictionary *responseObjectDict, NSError *error) {
        ws.data = nil;
        ws.racMsg = @"fail";
    }];
}



@end
