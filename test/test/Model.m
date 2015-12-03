//
//  Model.m
//  test
//
//  Created by ZhijieLi on 12/3/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import "Model.h"
#import <AFNetworking.h>

static NSString *urlString = @"http://image.baidu.com/data/imgs?col=%e7%be%8e%e5%a5%b3&tag=%e5%b0%8f%e6%b8%85%e6%96%b0&sort=0&pn=1&rn=1&p=channel&from=1";

@implementation Model
+ (void)getImagesListWithPage: (NSInteger)aPage SuccessBlock :(SuccessBlock)success FailBlock :(FailBlock)fail {

    NSString *urlString = [NSString stringWithFormat:@"%@%ld%@",@"http://image.baidu.com/data/imgs?col=%e7%be%8e%e5%a5%b3&tag=%e5%b0%8f%e6%b8%85%e6%96%b0&sort=0&pn=1",aPage,@"&rn=1&p=channel&from=1"];
    AFHTTPRequestOperationManager *managere = [AFHTTPRequestOperationManager manager];
    [managere GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(responseObject,nil);
        NSLog(@"success");
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        fail(nil,error);
        NSLog(@"fail");
    }];
}
@end
@implementation Imgs

@end


@implementation Owner

@end


