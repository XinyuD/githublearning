//
//  BUCoreUtility.m
//  RainbowHotel
//
//  Created by apple on 10-9-12.
//  Copyright 2010 . All rights reserved.
//

#import "BUCoreUtility.h"

@implementation BUCoreUtility

+ (UIImage *)newImageFromResource:(NSString *)filename
{
    if ([[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadStandard||
        [[UIDevice currentDevice] resolution]==UIDeviceResolution_iPadRetina)
    {
        NSArray* arrFileNames = [filename componentsSeparatedByString:@"."];
        if ([arrFileNames count]>1)
        {
            NSString *imageFile = [[NSString alloc] initWithFormat:@"%@/%@~ipad.%@",
                                   [[NSBundle mainBundle] resourcePath], [arrFileNames objectAtIndex:0],[arrFileNames objectAtIndex:1]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile])
            {
                UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageFile];
                return image;
            }
            else
            {
            }
        }
    }
    
    NSString *imageFile = [[NSString alloc] initWithFormat:@"%@/%@",
                           [[NSBundle mainBundle] resourcePath], filename];
    UIImage *image = nil;
    image = [[UIImage alloc] initWithContentsOfFile:imageFile];
    return image;
}

+(UIImageView*) newImageView:(NSString*)imageFileName
{
	UIImage* image = [BUCoreUtility newImageFromResource:imageFileName];
    if (image!=nil)
    {
        UIImageView* pImageView = [[UIImageView alloc] initWithImage:image];
        return pImageView;
    }
	return nil;
}

+(UIImageView*)newImageViewForAdaptScreen:(NSString*)imageFileName
{
    UIImage* pImage = [BUCoreUtility newImageFromResource:imageFileName];
    if (pImage==nil)
        return nil;
    CGSize size = [AppConfigure GetAdaptedImageSize:pImage];
    UIImageView* pView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    pView.image = pImage;
    return pView;
}


+ (UIImage *)newImageFromURL:(NSString *)url
{
    NSString * strURL=@"";
    strURL = url;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFile = [[NSString alloc] initWithFormat:@"%@/%@",documentsDirectory,[strURL stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imageFile];
    
    if (image==nil)
    {
        NSData *pImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
        if (pImageData!=nil)
        {
            image = [[UIImage alloc] initWithData:pImageData];
            [BUCoreUtility SaveImageToCache:image WithImageFileName:strURL];
        }
        else
        {
            image = [BUCoreUtility newImageFromResource:@"noPhoto.png"];
        }
    }
    return image;
}

+(UIImage*)ChangeImage:(UIImage*)argImage toColor:(UIColor*)argNewColor
{
    if(argImage == nil)
        return nil;
    CGRect rect = CGRectMake(0, 0, argImage.size.width, argImage.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, argImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, argImage.CGImage);
    CGContextSetFillColorWithColor(context, [argNewColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (argImage.imageOrientation==UIImageOrientationDownMirrored)
    {
        UIImage *flippedImage = [[UIImage alloc] initWithCGImage:img.CGImage
                                                           scale:argImage.scale
                                                     orientation:UIImageOrientationUp];
        
        return flippedImage;
    }
    
    UIImage *flippedImage = [[UIImage alloc] initWithCGImage:img.CGImage
                                                       scale:argImage.scale
                                                 orientation:UIImageOrientationDownMirrored];//argImage.imageOrientation
    
    return flippedImage;
}

+(UIImage*)CreateRectangeImageWithSize:(CGSize)argSize cornerRadious:(double)argRadious fillColor:(UIColor*)argColor andBorderColor:(UIColor*)argBorderColor
{
    CGRect boxRect = CGRectMake(1, 1, argSize.width-2, argSize.height-2);
    UIGraphicsBeginImageContextWithOptions(argSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + argRadious, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - argRadious, CGRectGetMinY(boxRect) + argRadious, argRadious, 3 * (float)M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - argRadious, CGRectGetMaxY(boxRect) - argRadious, argRadious, 0, (float)M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + argRadious, CGRectGetMaxY(boxRect) - argRadious, argRadious, (float)M_PI / 2, (float)M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + argRadious, CGRectGetMinY(boxRect) + argRadious, argRadious, (float)M_PI, 3 * (float)M_PI / 2, 0);
    CGContextSetFillColorWithColor(context, argColor.CGColor);
    CGContextSetStrokeColorWithColor(context,argBorderColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    //CGContextFillPath(context);
    //CGContextStrokePath(context);

    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)SaveImageToCache:(UIImage*)image
      WithImageFileName:(NSString*)imageFileName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString * imageFile = [[NSString alloc] initWithFormat:@"%@/%@",documentsDirectory,[imageFileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    
    NSLog(@"%@---%@",imageFileName,imageFile);
    if ([imageFileName hasSuffix:@".jpg"]) {
        // The value 'image' must be a UIImage object
        // The value '1.0' represents image compression quality as value from 0.0 to 1.0
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:imageFile atomically:YES];
    }
    else
    {
        // Write image to PNG
        [UIImagePNGRepresentation(image) writeToFile:imageFile atomically:YES];
    }
}

+(NSString*)GetFilePathFromName:(NSString*)filename withFileSourceType:(enum enumFileSourceType)type
{
    NSString* strPath;
    if(type == eUser)
    {
        NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        strPath = [arr objectAtIndex:0];
    }
    else if(type == eApp)
    {
        strPath = [[NSBundle mainBundle] resourcePath];
    }
    NSString* strFile = [NSString stringWithFormat:@"%@/%@", strPath, filename];
    return strFile;
}

+ (UIColor*)getAverageColorForImage:(UIImage *)image atLocation:(CGPoint)point withRadius:(int)radialSize
{
    int sampleSize = (radialSize * 2) + 1;
    int pixelsToCount = sampleSize * sampleSize;
    
    int xStartPoint = point.x - radialSize;
    int yStartPoint = point.y - radialSize;
    
    // Make sure we are not running off the edge of the image
    if(xStartPoint < 0){
        xStartPoint = 0;
    }
    else if (xStartPoint + sampleSize > image.size.width){
        xStartPoint = image.size.width - sampleSize - 1;
    }
    
    if(yStartPoint < 0){
        yStartPoint = 0;
    }
    else if (yStartPoint + sampleSize > image.size.height){
        yStartPoint = image.size.height - sampleSize - 1;
    }
    
    // This is the representation of the pixels we would like to average
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(xStartPoint, yStartPoint, sampleSize, sampleSize));
    
    // Get the image dimensions
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    
    // Set the color space to RGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Understand the bit length of the data
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = (NSUInteger)8;
    
    // Set up a Common Graphics Context
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (int)((bytesPerRow * 0) + 0 * bytesPerPixel);
    
    CGFloat cumulativeRed = 0.0;
    CGFloat cumulativeGreen = 0.0;
    CGFloat cumulativeBlue = 0.0;
    
    for (int ii = 0 ; ii < pixelsToCount ; ++ii){
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        __unused CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        
        cumulativeRed += red;
        cumulativeGreen += green;
        cumulativeBlue += blue;
        
        byteIndex += 4;
    }
    
    CGFloat avgRed = (cumulativeRed / pixelsToCount);
    CGFloat avgGreen = (cumulativeGreen / pixelsToCount);
    CGFloat avgBlue = (cumulativeBlue / pixelsToCount);
    
    free(rawData);
    
    return [UIColor colorWithRed:avgRed green:avgGreen blue:avgBlue alpha:1.0];

}


@end
