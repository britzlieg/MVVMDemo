//
//  zipAndUnzip.h
//  test
//
//  Created by ZhijieLi on 11/20/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZipAndUnzipUtil : NSObject
/**
 *  解压
 */
+ (NSData *)unZipWithData:(NSData*)data;
/**
 *  压缩
 */
+ (NSData *)zipWithData:(NSData*)data;
@end
