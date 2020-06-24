//
//  UIImage+Scale.h
//  PhotoCut
//
//  Created by 聂康 on 15/7/7.
//  Copyright (c) 2015年 聂康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

- (UIImage *)CompressImage:(UIImage *)image;

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

- (UIImage *)getImageFromBigImage:(UIImage *)bigImage andMyImageRect:(CGRect)myImageRect;

- (NSData *)imageData:(UIImage *)image;

- (BOOL)storeHeadImageToCash:(UIImage *)image;

- (UIImage *)getHeadImageFromCash;

- (BOOL)storeFrontCoverToCash:(UIImage *)image;

-(UIImage*)subImage:(UIImage *)rect;

- (void)uploadFrontCover:(UIImage*)image andImageName:(NSString*)urlStr;

- (UIImage *)getFrontCoverFromCash;

- (void)storeImage:(UIImage *)image andImageName:(NSString *)urlStr;
- (UIImage *)normalizedImage:(UIImage *)image;
- (NSString *)getUploadPath:(NSString *)fileName;

- (UIImage *)getImage:(NSString *)urlStr;

- (NSData *)getImageData:(NSString *)urlStr;

- (NSString *)getAvatarPath;

- (void)deleteImage:(NSString *)urlStr;

- (void)deleteAll;

@end
