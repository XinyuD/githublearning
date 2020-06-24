//
//  UIImage+Cut.m
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-5-17.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import "UIImage+Cut.h"
#import "UIImage+RoundedCorner.h"
@implementation UIImage (Cut)


- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize
{
    UIImage *newimage;
    UIImage *image = self;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        else{
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
//        UIGraphicsBeginImageContext(asize);
        //高清处理
        UIGraphicsBeginImageContextWithOptions(asize, YES, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToRect(context, CGRectMake(0, 0, asize.width, asize.height));
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        //        CGContextRelease(context);
        UIGraphicsEndImageContext();
    }
    return newimage;
}

- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize roundedCornerImage:(NSInteger)roundedCornerImage borderSize:(NSInteger)borderSize
{
    UIImage *image = [self clipImageWithScaleWithsize:asize];
    return [image roundedCornerImage:roundedCornerImage borderSize:borderSize];
}

- (UIImage *)clipImageInRect:(CGRect)argRect
{
    UIImage* image = self;
    CGRect rect = argRect;
    CGFloat x = argRect.origin.x;
    CGFloat y = argRect.origin.y;
    CGFloat fWidth = argRect.size.width;
    CGFloat fHeight = argRect.size.height;
    CGFloat fImageW = image.size.width*self.scale;
    CGFloat fImageH = image.size.height*self.scale;
    UIImageOrientation photoOrientation = image.imageOrientation;
    //NSLog("the image orientation is %@", m_pImage.imageOrientation);
    if(photoOrientation == UIImageOrientationUp )
    {
        rect = CGRectMake(x, y, fWidth, fHeight);
    }
    else if(photoOrientation == UIImageOrientationDown)
    {
        rect = CGRectMake(fImageW-x-fWidth, fImageH-y-fHeight, fWidth, fHeight);
    }
    else if(photoOrientation == UIImageOrientationLeft )
    {
        rect = CGRectMake(fImageH-y-fHeight,x,fHeight, fWidth);
    }
    else if(photoOrientation == UIImageOrientationRight)
    {
        rect = CGRectMake(y,fImageW-x-fWidth,fHeight, fWidth);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    UIImage*  pResultImage = [UIImage imageWithCGImage:imageRef  scale:[[UIScreen mainScreen] scale] orientation:photoOrientation];
    CGImageRelease(imageRef);
    return pResultImage;
}

-(UIImage*)clipImagefromBiggestSquare
{
    
    // Get the biggist square from the picture
    CGFloat fImageW = self.size.width*self.scale;
    CGFloat fImageH = self.size.height*self.scale;
    CGRect rect;
    if(fImageW>=fImageH)
    {
        rect = CGRectMake(fImageW/2-fImageH/2, 0, fImageH, fImageH);
    }
    else
        rect = CGRectMake(0, fImageH/2-fImageW/2, fImageW, fImageW);
    
    UIImage* newImage = [self clipImageInRect:rect];
    return newImage;
}

- (UIImage *)clipImageAs3to4FromTop
{
    // Get the 3 to 4 square from the picture
    CGFloat fImageW = self.size.width*self.scale;
    CGFloat fImageH = self.size.height*self.scale;
    CGRect rect;
    if(fImageW/fImageH <= (3.0/4.0))
    {
        CGFloat fNewH = fImageW/3*4;
        rect = CGRectMake(0, 0, fImageW, fNewH);
    }
    else
    {
        CGFloat fNewW = fImageH/4.0*3.0;
        rect = CGRectMake(fImageW/2.0 - fNewW/2.0, 0, fNewW, fImageH);
    }
    UIImage* newImage = [self clipImageInRect:rect];
    return newImage;
}

- (UIImage *)clipImageAs16to9FromTop
{
    // Get the 16 to 9 square from the picture
    CGFloat fImageW = self.size.width*self.scale;
    //    CGFloat fImageH = self.size.height*self.scale;
    CGRect rect;
    CGFloat fNewH = fImageW/16.0*9.0;
    rect = CGRectMake(0, 0, fImageW, fNewH);
    UIImage* newImage = [self clipImageInRect:rect];
    return newImage;
}
- (UIImage *)clipImageAs1to1FromTop
{
    // Get the 16 to 9 square from the picture
    CGFloat fImageW = self.size.width*self.scale;
    CGFloat fImageH = self.size.height*self.scale;
    CGRect rect;
    //    CGFloat fNewH = fImageW/fImageW;
    rect = CGRectMake(0, 0, fImageW, fImageH);
    UIImage* newImage = [self clipImageInRect:rect];
    return newImage;
}


+(UIImage*)GetScreenShotInView:(UIView*)argView inRect:(CGRect)argRect
{
    UIGraphicsBeginImageContextWithOptions(argView.bounds.size, NO,[[UIScreen mainScreen] scale]);
    if ([argView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        BOOL bFlag = [argView drawViewHierarchyInRect:argView.bounds afterScreenUpdates:NO];
        if (bFlag==NO)
        {
            NSLog(@"Failed");
        }
        else
        {
            NSLog(@"Success");
        }
    }
    else
    {
        [argView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage* pScreenShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat fScale = (pScreenShotImage.size.width*pScreenShotImage.scale) /argView.frame.size.width ;
    CGRect rectInImage = CGRectMake(argRect.origin.x*fScale, argRect.origin.y*fScale, argRect.size.width*fScale, argRect.size.height*fScale);
    
    UIImage* pSubImage = [pScreenShotImage clipImageInRect:rectInImage];
    return pSubImage;

}

-(UIImage*)ClipImageWithEmptyBorderInSize:(CGSize)argSize contentSize:(CGSize)argContentSize
{
    //创建一个view
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, argSize.width, argSize.height)];
    //将image放到view的中间
//    containerView.backgroundColor = [UIColor whiteColor];
    containerView.backgroundColor = [UIColor colorWithRed:54%256/255.0 green:52%256/255.0 blue:64%256/255.0 alpha:1];
    UIImageView *pImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, argContentSize.width, argContentSize.height)];
    
    if (argContentSize.width == CGSizeZero.width && argContentSize.height == CGSizeZero.height)
    {
        pImg.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    }
    pImg.image = self;
    pImg.center = containerView.center;
    [containerView addSubview:pImg];
    //绘制image
    UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, NO, [UIScreen mainScreen].scale);
    [containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
@end
