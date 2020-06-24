//
//  UIImage+Rotate.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-8-5.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Rotate) 

-(UIImage*)RotateCW90Degree;
-(UIImage*)RotateACW90Degree;

+(UIImageOrientation) GetCW90DegreeOrienation:(UIImageOrientation)argOldOrienation;
+(UIImageOrientation) GetACW90DegreeOrienation:(UIImageOrientation)argOldOrienation;

-(UIImage*)RotateImageToOrientation:(UIImageOrientation)argOrientation;
@end
