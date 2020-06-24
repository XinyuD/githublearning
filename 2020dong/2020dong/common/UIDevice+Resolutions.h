//
//  UIDevice+Resolutions.h
//  pbuHeavenTemple
//
//  Created by  -3 on 12-12-11.
//
//

#import <Foundation/Foundation.h>

enum {
    UIDeviceResolution_Unknown          = 0,
    UIDeviceResolution_iPhoneStandard   = 1,    // iPhone 1,3,3GS Standard Display    (320x480px)
    UIDeviceResolution_iPhoneRetina35   = 2,    // iPhone 4,4S Retina Display 3.5"    (640x960px)
    UIDeviceResolution_iPhoneRetina4    = 3,    // iPhone 5 Retina Display 4"         (640x1136px)
    UIDeviceResolution_iPhoneRetina47    = 4,    // iPhone 6 Retina Display 4.7"      (750x1334px)
    UIDeviceResolution_iPhoneRetina55    = 5,    // iPhone plus Retina Display 5.5" (1242x2208px)
    UIDeviceResolution_iPhoneRetina58    = 6,    // iPhone x,xs Retina Display 5.8" (1125x2436px)
    UIDeviceResolution_iPhoneRetina65    = 7,    // iPhone xs max Retina Display 6.5" (1242x2688px)
    UIDeviceResolution_iPhoneRetina61    = 8,    // iPhone xr Retina Display 6.1" (828x1792px)
    UIDeviceResolution_iPadStandard     = 9,    // iPad 1,2,mini Standard Display     (1024x768px)
    UIDeviceResolution_iPadRetina       = 10     // iPad 3 Retina Display              (2048x1536px)
};

typedef NSUInteger UIDeviceResolution;

@interface UIDevice(Resolutions)

-(UIDeviceResolution)resolution;

NSString *NSStringFromResolution(UIDeviceResolution resolution);

@end
