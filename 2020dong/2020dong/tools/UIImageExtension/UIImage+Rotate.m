//
//  UIImage+Rotate.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-8-5.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "UIImage+Rotate.h"

@implementation UIImage(Rotate)

-(NSInteger)GetIndexFromImageOrientation:(UIImageOrientation)argOrientation
{
    switch (argOrientation) {
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            return 1;
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            return 2;
            break;
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            return 3;
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            return 4;
            break;
        default:
            break;
    }
    return 0;
}

+(UIImageOrientation) GetCW90DegreeOrienation:(UIImageOrientation)argOldOrienation
{
    UIImageOrientation orientation;
    switch (argOldOrienation) {
        case UIImageOrientationUp:
            orientation = UIImageOrientationRight;
            break;
        case UIImageOrientationRight:
            orientation = UIImageOrientationDown;
            break;
        case UIImageOrientationDown:
            orientation = UIImageOrientationLeft;
            break;
        case UIImageOrientationLeft:
            orientation = UIImageOrientationUp;
            break;
        case UIImageOrientationUpMirrored:
            orientation = UIImageOrientationRightMirrored;
            break;
        case UIImageOrientationRightMirrored:
            orientation = UIImageOrientationDownMirrored;
            break;
        case UIImageOrientationDownMirrored:
            orientation = UIImageOrientationLeftMirrored;
            break;
        case UIImageOrientationLeftMirrored:
            orientation = UIImageOrientationUpMirrored;
        default:
            break;
    }
    return orientation;

}
+(UIImageOrientation) GetACW90DegreeOrienation:(UIImageOrientation)argOldOrienation
{
    UIImageOrientation orientation;
    switch (argOldOrienation) {
        case UIImageOrientationUp:
            orientation = UIImageOrientationLeft;
            break;
        case UIImageOrientationLeft:
            orientation = UIImageOrientationDown;
            break;
        case UIImageOrientationDown:
            orientation = UIImageOrientationRight;
            break;
        case UIImageOrientationRight:
            orientation = UIImageOrientationUp;
            break;
        case UIImageOrientationUpMirrored:
            orientation = UIImageOrientationLeftMirrored;
            break;
        case UIImageOrientationLeftMirrored:
            orientation = UIImageOrientationDownMirrored;
            break;
        case UIImageOrientationDownMirrored:
            orientation = UIImageOrientationRightMirrored;
            break;
        case UIImageOrientationRightMirrored:
            orientation = UIImageOrientationUpMirrored;
        default:
            break;
    }
    return orientation;

}

-(UIImage*)RotateCW90Degree
{
    UIImageOrientation orientation = [UIImage GetCW90DegreeOrienation:self.imageOrientation];
    return [self RotateImageToOrientation:orientation];
}

-(UIImage*)RotateACW90Degree
{
    UIImageOrientation orientation = [UIImage GetACW90DegreeOrienation:self.imageOrientation];
    return [self RotateImageToOrientation:orientation];
}

-(UIImage*)RotateImageToOrientation:(UIImageOrientation)argOrientation
{
    UIImage* newImage = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:argOrientation];
    return newImage;
}

@end
