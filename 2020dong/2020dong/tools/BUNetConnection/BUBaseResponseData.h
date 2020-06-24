//
//  BUBaseResponseData.h
//  2019
//
//  Created by 董融 on 2018/12/28.
//  Copyright © 2018年 董融. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMMapper.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUBaseResponseData : NSObject

@property (assign) int state_code;                                  ///请求状态 0成功 1用户错误 2系统错误

@property (assign) int stateCode;
@property (assign) int status;
@property (strong, nonatomic)NSString *errormsg;
@property (strong,nonatomic) NSString * error_msg;                  ///错误信息
@property (strong,nonatomic) NSString *errorMsg;

@property (strong,nonatomic) id data;                               ///返回值中的data json array
//@property (nonatomic,strong)id bean;
//@property (nonatomic,strong)id map;
@property (nonatomic,strong) NSArray * propParsedDatas;             ///data数组解析过的数据对象的数组


/*
 * Parse data from 'data' array
 * @param argDataClass parsed object's class
 */
-(NSArray*)ParseDataArray:(Class)argDataClass;

/*
 * Parse data from 'data' array
 * @param argJSONArray json array
 * @param argDataClass parsed object's class
 * @retrun parsed object array
 */
-(NSArray*)ParseJSONArray:(NSArray*)argJSONArray
            WithDataClass:(Class)argDataClass;

@end

NS_ASSUME_NONNULL_END
