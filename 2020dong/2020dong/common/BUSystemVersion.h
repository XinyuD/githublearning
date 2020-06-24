//
//  BUSystemVersion.h
//  WeddingHelper
//
//  Created by  on 13-10-8.
//  Copyright (c) 2013年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUSystemVersion : NSObject

+(BOOL)IsIOS7;

+(BOOL)SystemVersionGreaterThanOrEqualTo:(float)argVersion;

+(BOOL)SystemVersionGreaterThanOrEqualToSeven;

@end
