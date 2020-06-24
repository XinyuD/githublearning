//
//  UIImage+Cut.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-5-17.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (Cut)

- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize;
- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize roundedCornerImage:(NSInteger)roundedCornerImage borderSize:(NSInteger)borderSize;
- (UIImage *)clipImageInRect:(CGRect)argRect;
- (UIImage *)clipImagefromBiggestSquare;
- (UIImage *)clipImageAs3to4FromTop;

- (UIImage *)clipImageAs16to9FromTop;
- (UIImage *)clipImageAs1to1FromTop;

+(UIImage*)GetScreenShotInView:(UIView*)argView inRect:(CGRect)argRect;
-(UIImage*)ClipImageWithEmptyBorderInSize:(CGSize)argSize contentSize:(CGSize)argContentSize;
@end
