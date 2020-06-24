//
//  UIImage+Scale.m
//  PhotoCut
//
//  Created by 聂康 on 15/7/7.
//  Copyright (c) 2015年 聂康. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

//等比例缩放
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//压缩图片尺寸
- (UIImage *)CompressImage:(UIImage *)image{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat smallSide = 360;
    if(width <= smallSide || height <= 360){
        return image;
    }
    else{
        if(width <= height){
            CGFloat targetHeight = smallSide*height/width;
            return [image reSizeImage:image toSize:CGSizeMake(smallSide, targetHeight)];
        }
        else{
            CGFloat targetWidth = smallSide*width/height;
            return [image reSizeImage:image toSize:CGSizeMake(targetWidth, smallSide)];
        }
    }
}

//自定义图片尺寸
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
//    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(reSize.width, reSize.height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

//自定义裁剪
- (UIImage *)getImageFromBigImage:(UIImage *)bigImage andMyImageRect:(CGRect)myImageRect{
    //大图bigImage
    //定义myImageRect，截图的区域
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = myImageRect.size.width;
    size.height = myImageRect.size.height;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}

//图片压缩
- (NSData *)imageData:(UIImage *)image{
    UIImage *newImage = [image CompressImage:image];
    return UIImageJPEGRepresentation(newImage, 0.8);
}

//存储头像到沙盒
- (BOOL)storeHeadImageToCash:(UIImage *)image{
    NSString *paths = [self getAvatarPath];
    NSString *filePath = [paths stringByAppendingPathComponent:@"head.jpg"];
    BOOL result = [[image imageData:image] writeToFile:filePath atomically:YES];
    if(result){
        return YES;
    }
    else{
        return NO;
    }
}

//取出头像
- (UIImage*)getHeadImageFromCash{
    NSString *paths = [self getAvatarPath];
    NSString *filePath = [paths stringByAppendingPathComponent:@"head.jpg"];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if(isExist){
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:data];
        return image;
    }
    else{
        return nil;
    }
}

//上传图片
- (void)uploadFrontCover:(UIImage*)image andImageName:(NSString*)urlStr{
    NSData * imageData = UIImageJPEGRepresentation([image subImage:image], 0.8);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = NSTemporaryDirectory();
    NSString *filePath = [path stringByAppendingString:@"image"];
    BOOL isDir = NO;
    BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDir];
    if(!(isExist && isDir)){
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [imageData writeToFile:[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",urlStr]] atomically:YES];
}

//封面处理
-(UIImage*)subImage:(UIImage *)image
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, image.size.width, image.size.width*9/16));
    
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsEndImageContext();
    
    NSLog(@"%f %f %f",smallImage.size.width,smallImage.size.height,smallImage.size.width/smallImage.size.height);
    
    UIImage *newImage = [smallImage CompressImage:smallImage];
    NSLog(@"%f %f %f",newImage.size.width,newImage.size.height,newImage.size.width/smallImage.size.height);
    
    return [smallImage CompressImage:smallImage];
    
}

//存封面
- (BOOL)storeFrontCoverToCash:(UIImage *)image{
    NSString *paths = [self getAvatarPath];
    NSString *filePath = [paths stringByAppendingPathComponent:@"frontCover.jpg"];
    BOOL result = [[image imageData:image] writeToFile:filePath atomically:YES];
    if(result){
        return YES;
    }
    else{
        return NO;
    }
}

//取封面
- (UIImage *)getFrontCoverFromCash{
    NSString *paths = [self getAvatarPath];
    NSString *filePath = [paths stringByAppendingPathComponent:@"frontCover.jpg"];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if(isExist){
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        return image;
    }
    else{
        return nil;
    }
}

//上传图片
- (void)storeImage:(UIImage*)image andImageName:(NSString*)urlStr{
    NSData * imageData = [image imageData:image];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = NSTemporaryDirectory();
    NSString *filePath = [path stringByAppendingString:@"image"];
    BOOL isDir = NO;
    BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDir];
    if(!(isExist && isDir)){
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [imageData writeToFile:[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",urlStr]] atomically:YES];
}
//处理图片方向
- (UIImage *)normalizedImage:(UIImage *)image
{
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

//取出图片
- (UIImage*)getImage:(NSString*)urlStr{
    NSString *paths = NSTemporaryDirectory();
    NSString *filePath = [paths stringByAppendingString:[NSString stringWithFormat:@"image/%@",urlStr]];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExist = [manager fileExistsAtPath:filePath];
    if(isExist){
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        return image;
    }
    else{
        return nil;
    }
}

//得到对应图片路径
- (NSString *)getUploadPath:(NSString *)fileName{
    NSString *path = NSTemporaryDirectory();
    NSString *filePath = [path stringByAppendingString:[NSString stringWithFormat:@"image/%@",fileName]];
    return filePath;
}

- (NSString *)getAvatarPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:@"uid"];
    BOOL isDir = NO;
    BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDir];
    if(!(isExist && isDir)){
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}

- (NSData*)getImageData:(NSString*)urlStr{
    NSString *paths = NSTemporaryDirectory();
    NSString *filePath = [paths stringByAppendingString:[NSString stringWithFormat:@"image/%@",urlStr]];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExist = [manager fileExistsAtPath:filePath];
    if(isExist){
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        return data;
    }
    else{
        return nil;
    }
}

- (void)deleteImage:(NSString*)urlStr{
    NSString *paths = NSTemporaryDirectory();
    NSString *filePath = [paths stringByAppendingString:[NSString stringWithFormat:@"image/%@",urlStr]];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExist = [manager fileExistsAtPath:filePath];
    if(isExist){
        [manager removeItemAtPath:filePath error:nil];
    }
}

- (void)deleteAll{
    NSString *paths = NSTemporaryDirectory();
    NSString *filePath = [paths stringByAppendingString:@"image"];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExist = [manager fileExistsAtPath:filePath];
    if(isExist){
        [manager removeItemAtPath:filePath error:nil];
    }
}


@end
