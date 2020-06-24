//
//  BURequest.h
//  2019
//
//  Created by 董融 on 2018/12/28.
//  Copyright © 2018年 董融. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@class BURequest;
@class BUBaseResponseData;

@protocol BURequestDelegate <NSObject>

/**
 *  请求成功
 *
 *  @param argRequestTag 请求的标示符
 *  @param argData       返回的数据
 */
-(void)RequestSucceeded:(NSString *)argRequestTag withResponseData:(NSArray *)argData;
@optional

/**
 *  请求失败
 *
 *  @param argRequest 请求对象
 */
-(void)RequestFailed:(BURequest *)argRequest;

/**
 *  请求出错
 *
 *  @param argRequest 请求对象
 *  @param argMsg     错误原因
 */
-(void)RequestErrorHappened:(BURequest *)argRequest withErrorMsg:(NSString *)argMsg;

-(void)RequestSucceeded:(NSString *)argRequestTag withChargeData:(NSData *)argData;

@end

@interface BURequest : NSObject

@property (weak, nonatomic) id<BURequestDelegate> propDelegate;

/**
 *  请求url
 */
@property (readonly, strong, nonatomic) NSString* propUrl;

/**
 *  普通请求参数
 */
@property (strong, nonatomic ) NSDictionary* propParameters;   // record the parameters

/**
 *  图片请求参数
 */
@property (strong,nonatomic,readonly) NSDictionary *propImageParameters;

/**
 *  设置返回具体data的类型
 */
@property (assign) Class propDataClass;

/**
 *  请求的标识符
 */
@property (readonly, strong, nonatomic) NSString* propRequestTag;

/**
 *  请求返回的基础解析数据
 */
@property (readonly, nonatomic) BUBaseResponseData* propResponseData;


// Initialization
- (id)initWithUrl:(NSString*)argUrl andTag:(NSString*)argTag;

// Start the asynchronous request
- (void)PostAsynchronous;

// use Get request
-(void)GetAsynchronous;

// Set the parameters for the request
- (void)SetParamValue:(NSString*)argValue forKey:(NSString *)argKey;

// Set the image data parameter for the request
- (void)AddImageData:(UIImage*)argImage forKey:(NSString *)argKey;

// Cancel the request
- (void)Cancel;

@end

NS_ASSUME_NONNULL_END
