//
//  BUPageRequest.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-8-6.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUPageRequest.h"
#import "NSString+IntValue.h"

@implementation BUPageRequest
@synthesize propPageCount;
@synthesize propRequestTag = m_strRequestTag;
@synthesize propDelegate;
@synthesize propDataClass;


-(id)initWithUrl:(NSString *)argUrl andTag:(NSString *)argTag
{
    self = [super init];
    self.propIndex = 0;
    self.propPageCount = 20;
    m_strIndexKey = @"index";
    m_strPageCountKey = @"count";
    m_strUrl = argUrl;

    m_arrRequests = [[NSMutableArray alloc] init];
    m_strRequestTag = argTag;
    m_dicParameters = [[NSMutableDictionary alloc] init];
    
    return self;
}

-(void)SetParamValue:(NSString *)argValue forKey:(NSString *)argKey
{
     [m_dicParameters setValue:argValue forKey:argKey];
}


-(void)RequestFromStart
{
    [self RequestMore];
}

-(void)RequestMore
{
    [m_pRequest Cancel];
    m_pRequest = [[BURequest alloc] initWithUrl:m_strUrl andTag:m_strRequestTag];
    [m_arrRequests addObject:m_pRequest];
    [self SetParamValue:[NSString IntergerString:self.propPageCount] forKey:m_strPageCountKey];
    [self SetParamValue:[NSString IntergerString:self.propIndex] forKey:m_strIndexKey];
    m_pRequest.propParameters = m_dicParameters;
    m_pRequest.propDelegate = self;
     m_pRequest.propDataClass = self.propDataClass;
    [m_pRequest PostAsynchronous];
}

#pragma mark - delegate methods

-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData
{
    if([argData count] != 0)
    if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(RequestSucceeded:withResponseData:)])
    {
        [self.propDelegate RequestSucceeded:argRequestTag withResponseData:argData];
    }
     self.propIndex +=20;
}

-(void)RequestFailed:(BURequest *)argRequest
{
    if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(RequestFailed:)])
    {
        [self.propDelegate RequestFailed:argRequest];
    }
}

@end
