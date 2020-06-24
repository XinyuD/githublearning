//
//  BUCoreUtility.h
//  RainbowHotel
//
//  Created by apple on 10-9-12.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUCoreUtility : NSObject {

}

enum enumFileSourceType
{
    eUser,
    eApp
};

+(UIImage *)newImageFromResource:(NSString *)filename;
+(UIImage *)newImageFromURL:(NSString *)url;
+(UIImageView*)newImageView:(NSString *)imageFileName;
+(UIImageView*)newImageViewForAdaptScreen:(NSString*)imageFileName;

+(UIImage*)CreateRectangeImageWithSize:(CGSize)argSize cornerRadious:(double)argRadious fillColor:(UIColor*)argColor andBorderColor:(UIColor*)argBorderColor;

+(UIImage*)ChangeImage:(UIImage*)argImage toColor:(UIColor*)argNewColor;

+(NSString*)GetFilePathFromName:(NSString*)filename withFileSourceType:(enum enumFileSourceType)type;

@end
 
