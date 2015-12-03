//
//  zipAndUnzip.h
//  test
//
//  Created by ZhijieLi on 11/20/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  压缩工具
 */
@interface GZipAndUnzipUtil : NSObject
/**
 *  解压
 *
 *  @param data 压缩的数据
 *
 *  @return 解压后的数据
 */
+ (NSData *)unZipWithData:(NSData*)data;
/**
 *  压缩
 *
 *  @param data 原始数据
 *
 *  @return 压缩后的数据
 */
+ (NSData *)zipWithData:(NSData*)data;
/**
 *  压缩数据后用base64编码
 *
 *  @param aData 原始数据
 *
 *  @return 经过压缩和base64编码的数据
 */
+ (NSData *)compressWithBase64AndData :(NSData *)aData;
/**
 *  用base64解码后解压数据
 *
 *  @param aData 经过压缩和base64编码的数据
 *
 *  @return 原始数据
 */
+ (NSData *)deCompressWithBase64AndData :(NSData *)aData;
@end
