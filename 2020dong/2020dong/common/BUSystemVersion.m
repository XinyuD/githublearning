//
//  BUSystemVersion.m
//  WeddingHelper
//
//  Created by   on 13-10-8.
//  Copyright (c) 2013年  . All rights reserved.
//

#import "BUSystemVersion.h"

@implementation BUSystemVersion

+(BOOL)IsIOS7
{
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] == 7)
        return YES;
    else
        return NO;
}

+(BOOL)SystemVersionGreaterThanOrEqualTo:(float)argVersion
{
    return [[[UIDevice currentDevice] systemVersion] compare:[NSString stringWithFormat:@"%f",argVersion] options:NSNumericSearch] != NSOrderedAscending;
}

+(BOOL)SystemVersionGreaterThanOrEqualToSeven
{
    return [BUSystemVersion SystemVersionGreaterThanOrEqualTo:7.0];
}


@end
