//
//  AppConfigure.h
//  2019
//
//  Created by 董融 on 2018/12/27.
//  Copyright © 2018年 董融. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIDevice+Resolutions.h"
#import "NSString+MD5.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef DEBUG
#undef NSLog
#define NSLog(args, ...)
#endif

#pragma mark - UIColor defines

#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF)) /255.0 \
alpha:a]
#define UIColorFromHex(hexValue) UIColorFromHexWithAlpha(hexValue,1.0)

#define IS_EMPTY_STRING(x)          (IS_NULL(x) || [x isEqual:@""] || [x isEqual:@"(null)"])
#define AFWeak  __weak __typeof(self) weakSelf = self

#pragma mark - Screen defines

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//iPhoneX / iPhoneXS
#define  isIphoneX_XS     (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax    (kScreenWidth == 414.f && kScreenHeight == 896.f ? YES : NO)
//异性全面屏
//#define   isFullScreen    (isIphoneX_XS || isIphoneXR_XSMax)
#define kIsBangsScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})

// Status bar height.
#define  StatusBarHeight     (kIsBangsScreen ? 44.f : 20.f)

// Navigation bar height.
#define  NavigationBarHeight  44.f

// Tabbar height.
#define  TabbarHeight         (kIsBangsScreen ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin         (kIsBangsScreen ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight  (kIsBangsScreen ? 88.f : 64.f)


#pragma mark - Notification Name

#define Notif_Login @"login"

@interface AppConfigure : NSObject

+ (NSString*)GetWebServiceDomain;

+ (double)iOSVersion;

+ (double)GetYStartPos;

+ (UIColor *)MainBgColor;

#pragma mark - screen adaption
+(CGFloat) GetScreenWidth;
+(CGFloat) GetScreenHeight;
+(CGFloat) GetLengthAdaptRate;
+(CGFloat) GetHeightAdaptRate;

#pragma mark -- 加载图片
+ (void)LoadImageWithImageView:(UIImageView *)argImageView ImageViewUrl:(NSString *)argUrl PlaceHoldImage:(UIImage *)argPlaceHoldImage;

+ (UIImage *)CacheImageWithUrl:(NSString *)argUrl;

+(CGSize) GetAdaptedImageSize:(UIImage*)argImage;

+(CGFloat) GetImageRate;
@end

NS_ASSUME_NONNULL_END
