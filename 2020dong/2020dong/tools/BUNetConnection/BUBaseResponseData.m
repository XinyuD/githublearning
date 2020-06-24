//
//  BUBaseResponseData.m
//  2019
//
//  Created by 董融 on 2018/12/28.
//  Copyright © 2018年 董融. All rights reserved.
//

#import "BUBaseResponseData.h"

@implementation BUBaseResponseData

@synthesize  state_code;
@synthesize  error_msg;
@synthesize  propParsedDatas;

-(instancetype)init
{
    self = [super init];
    self.error_msg = @"";
    self.propParsedDatas = [NSArray array];
    return self;
}

- (void)setData:(id)data
{
    if (data != nil && ![data isKindOfClass:[NSString class]])
    {
        _data = data;
    }
}

-(NSArray*)ParseDataArray:(Class)argDataClass
{
    if([self.data isKindOfClass:[NSArray class]])
    {
        self.propParsedDatas = [self ParseJSONArray:self.data WithDataClass:argDataClass];
        return self.propParsedDatas;
    }
    if([self.data isKindOfClass:[NSDictionary class]])
    {
        id pObject = [RMMapper objectWithClass:argDataClass fromDictionary:self.data];
        self.propParsedDatas = [NSArray arrayWithObject:pObject];
        return self.propParsedDatas;
    }
    if ([self.data isKindOfClass:[NSString class]])
    {
        NSString *strData = (NSString *)self.data;
        if (![strData isEqualToString:@""])
        {
            self.propParsedDatas = [NSArray arrayWithObject:strData];
            return self.propParsedDatas;
        }
    }
    return nil;
}

-(NSArray*)ParseJSONArray:(NSArray*)argJSONArray
            WithDataClass:(Class)argDataClass
{
    NSArray* arrResult = [RMMapper arrayOfClass:argDataClass fromArrayOfDictionary:argJSONArray];
    
    return arrResult;
}

@end
