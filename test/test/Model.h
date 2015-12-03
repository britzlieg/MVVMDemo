//
//  Model.h
//  test
//
//  Created by ZhijieLi on 12/3/15.
//  Copyright © 2015 ZhijieLi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSDictionary *responseObjectDict,NSError *error);
typedef void (^FailBlock)(NSDictionary *responseObjectDict,NSError *error);

@class Owner;
@interface Model : NSObject

@property (nonatomic, copy) NSString *col;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *tag3;

@property (nonatomic, assign) NSInteger startIndex;

@property (nonatomic, assign) NSInteger returnNumber;

@property (nonatomic, strong) NSArray *imgs;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, assign) NSInteger totalNum;

+ (void)getImagesListWithPage: (NSInteger)aPage SuccessBlock :(SuccessBlock)success FailBlock :(FailBlock)fail;


@end
@interface Imgs : NSObject

@property (nonatomic, copy) NSString *pictureId;

@property (nonatomic, assign) NSInteger dressNum;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, strong) Owner *owner;

@property (nonatomic, copy) NSString *hostName;

@property (nonatomic, copy) NSString *canAlbumId;

@property (nonatomic, assign) NSInteger thumbLargeTnWidth;

@property (nonatomic, assign) NSInteger thumbLargeTnHeight;

@property (nonatomic, copy) NSString *albumObjNum;

@property (nonatomic, assign) NSInteger albumNum;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) NSInteger isVip;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger dressImgNum;

@property (nonatomic, assign) NSInteger isDapei;

@property (nonatomic, assign) NSInteger thumbnailWidth;

@property (nonatomic, assign) NSInteger thumbLargeHeight;

@property (nonatomic, copy) NSString *siteLogo;

@property (nonatomic, copy) NSString *parentTag;

@property (nonatomic, copy) NSString *pictureSign;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger imageHeight;

@property (nonatomic, assign) NSInteger thumbLargeWidth;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *fromPageTitle;

@property (nonatomic, assign) NSInteger thumbnailHeight;

@property (nonatomic, copy) NSString *isBook;

@property (nonatomic, copy) NSString *albumDi;

@property (nonatomic, copy) NSString *fashion;

@property (nonatomic, copy) NSString *bookId;

@property (nonatomic, assign) NSInteger fromName;

@property (nonatomic, copy) NSString *appId;

@property (nonatomic, copy) NSString *downloadUrl;

@property (nonatomic, copy) NSString *setId;

@property (nonatomic, copy) NSString *thumbLargeTnUrl;

@property (nonatomic, copy) NSString *siteUrl;

@property (nonatomic, assign) NSInteger imageWidth;

@property (nonatomic, copy) NSString *albumId;

@property (nonatomic, copy) NSString *thumbLargeUrl;

@property (nonatomic, copy) NSString *dataSrc;

@property (nonatomic, copy) NSString *thumbnailUrl;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *objTag;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *contentSign;

@property (nonatomic, copy) NSString *albumName;

@property (nonatomic, copy) NSString *dressTag;

@property (nonatomic, assign) NSInteger dressPrice;

@property (nonatomic, assign) NSInteger dressDiscount;

@property (nonatomic, copy) NSString *fromUrl;

@property (nonatomic, copy) NSString *siteName;

@property (nonatomic, copy) NSString *dressId;

@property (nonatomic, copy) NSString *column;

@property (nonatomic, copy) NSString *dressBuyLink;

@property (nonatomic, copy) NSString *photoId;

@property (nonatomic, copy) NSString *dressExtInfo;

@property (nonatomic, copy) NSString *objUrl;

@property (nonatomic, assign) NSInteger isAlbum;

@end

@interface Owner : NSObject

@property (nonatomic, copy) NSString *resUrl;

@property (nonatomic, copy) NSString *isJiaju;

@property (nonatomic, copy) NSString *isHunjia;

@property (nonatomic, copy) NSString *isVip;

@property (nonatomic, copy) NSString *isLanv;

@property (nonatomic, copy) NSString *lanvName;

@property (nonatomic, copy) NSString *isSelf;

@property (nonatomic, copy) NSString *contactName;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *portrait;

@property (nonatomic, copy) NSString *cert;

@property (nonatomic, copy) NSString *userSign;

@property (nonatomic, copy) NSString *orgName;

@property (nonatomic, copy) NSString *budgetNum;

@end

