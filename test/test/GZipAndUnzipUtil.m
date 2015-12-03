//
//  zipAndUnzip.m
//  test
//
//  Created by ZhijieLi on 11/20/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import "GZipAndUnzipUtil.h"
#import "zlib.h"

@implementation GZipAndUnzipUtil

//解压缩
+ (NSData *)unZipWithData:(NSData*)data
{
    if ([data length] == 0) return data;

    unsigned full_length = (int)[data length];
    unsigned half_length = (int)[data length] / 2;

    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;

    z_stream strm;
    strm.next_in = (Bytef *)[data bytes];
    strm.avail_in = (int)[data length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;

    if (inflateInit2(&strm, (15+32)) != Z_OK)
        return nil;

    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uint)[decompressed length] - (uint)strm.total_out;

        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END)
            done = YES;
        else if (status != Z_OK)
            break;
    }
    if (inflateEnd (&strm) != Z_OK)
        return nil;

    // Set real length.
    if (done)
    {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    else return nil;
}


//压缩
+ (NSData *)zipWithData:(NSData*)data
{
    if ([data length] == 0) return data;

    z_stream strm;

    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in=(Bytef *)[data bytes];
    strm.avail_in = (int)[data length];

    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION

    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;

    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion

    do {

        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy: 16384];

        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)[compressed length] - (uint)strm.total_out;

        deflate(&strm, Z_FINISH);

    } while (strm.avail_out == 0);

    deflateEnd(&strm);

    [compressed setLength: strm.total_out];
    return [NSData dataWithData:compressed];
}

// 压缩数据后用base64编码
+ (NSData *)compressWithBase64AndData :(NSData *)aData {
    // 压缩
    NSData *zipData = [GZipAndUnzipUtil zipWithData:aData];
    // 编码
    NSData *zipEncodeData = [zipData base64EncodedDataWithOptions:0];
    return zipEncodeData;
}

// 用base64解码后解压数据
+ (NSData *)deCompressWithBase64AndData :(NSData *)aData {
    // 解码
    NSData *zipDecodeData = [[NSData alloc]initWithBase64EncodedData:aData options:0];
    // 解压
    NSData *unzipData = [GZipAndUnzipUtil unZipWithData:zipDecodeData];
    return unzipData;
}


@end
