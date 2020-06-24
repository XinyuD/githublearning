//
//  UIDevice+Resolutions.m
//  pbuHeavenTemple
//
//  Created by  -3 on 12-12-11.
//
//

#import "UIDevice+Resolutions.h"

@implementation UIDevice (Resolutions)

- (UIDeviceResolution)resolution
{
    UIDeviceResolution resolution = UIDeviceResolution_Unknown;
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    CGFloat pixelWidth = (CGRectGetWidth(mainScreen.bounds) * scale);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if (scale == 3.0f) {
            //plus
            if (pixelHeight == 2208.0f && pixelWidth == 1242.0f)
                resolution = UIDeviceResolution_iPhoneRetina55;
            
            if (pixelHeight == 1242.0f && pixelWidth == 2208.0f)
                resolution = UIDeviceResolution_iPhoneRetina55;
            //x xs
            if (pixelHeight == 1125.0f && pixelWidth == 2436.0f)
                resolution = UIDeviceResolution_iPhoneRetina58;
            if (pixelHeight == 2436.0f && pixelWidth == 1125.0f)
                resolution = UIDeviceResolution_iPhoneRetina58;
            //xs max
            if (pixelHeight == 1242.0f && pixelWidth == 2688.0f)
                resolution = UIDeviceResolution_iPhoneRetina65;
            if (pixelHeight == 2688.0f && pixelWidth == 1242.0f)
                resolution = UIDeviceResolution_iPhoneRetina65;
        }else if (scale == 2.0f) {
            //4s
            if ( (pixelHeight == 960.0f && pixelWidth == 640.0f) || (pixelHeight == 640.0f && pixelWidth == 960.0f))
                resolution = UIDeviceResolution_iPhoneRetina35;
            //5
            else if ( (pixelHeight == 1136.0f && pixelWidth == 640.0f) || (pixelHeight == 640.0f && pixelWidth ==1136.0f))
                resolution = UIDeviceResolution_iPhoneRetina4;
            //iphone
            else if ( (pixelHeight == 1334.0f && pixelWidth == 750.0f) || (pixelHeight == 750.0f && pixelWidth == 1334.0f))
                resolution = UIDeviceResolution_iPhoneRetina47;
            //xr
            else if ( (pixelHeight == 828.0f && pixelWidth == 1792.0f) || (pixelHeight == 1792.0f && pixelWidth == 828.0f))
                resolution = UIDeviceResolution_iPhoneRetina47;
        } else if (scale == 1.0f && pixelHeight == 480.0f)
            resolution = UIDeviceResolution_iPhoneStandard;
        
    } else {
        if (scale == 2.0f && pixelHeight == 2048.0f) {
            resolution = UIDeviceResolution_iPadRetina;
            
        } else if (scale == 1.0f && pixelHeight == 1024.0f) {
            resolution = UIDeviceResolution_iPadStandard;
        }
    }
    return resolution;
}

@end
