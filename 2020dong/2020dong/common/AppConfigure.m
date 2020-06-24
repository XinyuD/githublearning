//
//  AppConfigure.m
//  2019
//
//  Created by 董融 on 2018/12/27.
//  Copyright © 2018年 董融. All rights reserved.
//

#import "AppConfigure.h"

@implementation AppConfigure

///DEBUG = 1 测试   DEBUG = 1 正式
+ (NSString*)GetWebServiceDomain
{
    if (DEBUG)
        return @"http://sjdh.1bu2bu.com/index.php?s=/Api/";  //测试服务器
    else
        return @"http://bjsjdh.imwork.net:8082/ShiJiDaHeng/server/index.php?s=/Api/";  //正式服务器
    return @"http://biangc.cn/api/";
}

#pragma mark -- 返回当前设备版本号
+ (double)iOSVersion
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+(double) GetYStartPos
{
    if ([AppConfigure iOSVersion] >= 7.0)
    {
        if (isFullScreen)
        {
            return 44;
        }
        return 20;
    }
    else
        return 0;
}

+(UIColor *)MainBgColor
{
    return UIColorFromHex(0xF3F3F3);
}

#pragma mark - screen adaption

+(CGFloat) GetScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+(CGFloat) GetScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}


+(CGFloat)GetLengthAdaptRate;
{
    CGFloat rate = 1;
    //3.5 和 4 英寸宽度 320 pt
    if([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina4 ||
       [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35)
    {
        rate = 320/375.0;
    }
    //6 6s 7 8 宽度 375 pt  375*667
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina47 || [[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina58)
    {
        rate = 1;
    }
    //plus 414*736
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina55 || [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina65 || [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina61)
    {
        rate = 414/375.0;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina)
    {
        return 768.0/320.0;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard)
    {
        return 768.0/320.0;
    }
    return rate;
}

#pragma mark -- 加载图片
+ (void)LoadImageWithImageView:(UIImageView *)argImageView ImageViewUrl:(NSString *)argUrl PlaceHoldImage:(UIImage *)argPlaceHoldImage
{
    argImageView.image = argPlaceHoldImage;
    NSString *pCacheDataFile = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"CacheData"];
    NSString *pFilePath = [pCacheDataFile stringByAppendingPathComponent:[argUrl md5]];
    NSFileManager *pFM = [NSFileManager defaultManager];
    if (![pFM fileExistsAtPath:pCacheDataFile])
    {
        [pFM createDirectoryAtPath:pCacheDataFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([pFM fileExistsAtPath:pFilePath])
    {
        NSData *pData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:pFilePath]];
        if (pData != nil)
        {
            argImageView.image = [UIImage imageWithData:pData];
        }
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:argUrl]];
            [data writeToFile:pFilePath atomically:YES];
            if (data != nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    argImageView.image = [UIImage imageWithData:data];
                });
            }
        });
    }
}

+ (UIImage *)CacheImageWithUrl:(NSString *)argUrl
{
    NSString *pCacheDataFile = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"CacheData"];
    NSString *pFilePath = [pCacheDataFile stringByAppendingPathComponent:[argUrl md5]];
    NSFileManager *pFM = [NSFileManager defaultManager];
    if (![pFM fileExistsAtPath:pCacheDataFile])
    {
        [pFM createDirectoryAtPath:pCacheDataFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([pFM fileExistsAtPath:pFilePath])
    {
        NSData *pData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:pFilePath]];
        if (pData != nil)
        {
            return [UIImage imageWithData:pData];
        }
    }
    else
    {
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:argUrl]];
        [data writeToFile:pFilePath atomically:YES];
        if (data != nil)
        {
            return [UIImage imageWithData:data];
        }
    }
    return nil;
}

+(CGSize) GetAdaptedImageSize:(UIImage*)argImage
{
    return CGSizeMake(round(argImage.size.width*[AppConfigure GetImageRate]),
                      round(argImage.size.height*[AppConfigure GetImageRate]));
}

+(CGFloat) GetImageRate
{
    //CGFloat height = [AppConfigure GetScreenHeight];
    
    //CGFloat rate = ([AppConfigure GetScreenHeight]/320);
    CGFloat rate = 1;
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4 ||
       [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35)
    {
        rate = 641/750.0;
    }
    if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina47)
    {
        rate = 1;
        
        //rate = 0.91;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina55)
    {
        rate = 1;
        //rate = 1.18;
    }
    /*else if(([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina4||[[UIDevice currentDevice] resolution]==UIDeviceResolution_iPhoneRetina35) && [BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.0] && (![BUSystemVersion SystemVersionGreaterThanOrEqualTo:8.1]))
     {
     //rate = 375.0/414.0;
     rate = 320.0/414.0;
     rate = 1;
     }*/
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina )
    {
        return 768.0/320.0;
    }
    else if([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard)
    {
        return 768.0/320.0;
    }
    
    
    NSLog(@"image rate is %f", rate);
    return rate;
}
@end
