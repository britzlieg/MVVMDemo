//
//  ViewModel.h
//  test
//
//  Created by ZhijieLi on 12/3/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

@property (strong,nonatomic) NSDictionary *data;
@property (strong,nonatomic) NSString *racMsg;  


- (void)getImagesList;
- (void)getNextImagesList;
- (void)getPreImagesList;

@end
