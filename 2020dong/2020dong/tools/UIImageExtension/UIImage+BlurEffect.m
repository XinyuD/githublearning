//
//  UIImage+BlurEffect.m
//  Fitness
//
//  Created by 1bu2bu-3 on 16/6/13.
//  Copyright © 2016年 1bu2bu-3. All rights reserved.
//

#import "UIImage+BlurEffect.h"

@implementation UIImage (BlurEffect)

+ (UIImage *)GetBlurEffectImageWithUrl:(NSURL *)argImgUrl
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithContentsOfURL:argImgUrl];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@2.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}

@end
