//
//  BURequest.m
//  2019
//
//  Created by 董融 on 2018/12/28.
//  Copyright © 2018年 董融. All rights reserved.
//

#import "BURequest.h"
#import "BUBaseResponseData.h"
#import "NSString+MD5.h"

@interface BUShowErrorMsg : NSObject
{
    UIAlertView* m_pAlertView;
}

/**
 *  app的token值
 */
@property(nonatomic,copy)NSString *propToken;

+ (instancetype)GetInstance;

- (void)ShowErrorMessage:(NSString*)argError;

@end

@implementation BUShowErrorMsg

static BUShowErrorMsg *_instance;
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)GetInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (void)ShowErrorMessage:(NSString*)argError
{
    if (m_pAlertView.visible == NO)
    {
        m_pAlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:argError delegate:nil
                                        cancelButtonTitle:@"知道了"
                                        otherButtonTitles:nil, nil];
        [m_pAlertView show];
    }
}

@end

@interface BURequest ()
{
    NSString* m_strUrl;                     // record the url;
    NSString* m_strRequestTag;              // the variable to record the reqeust tag
    NSDictionary* m_dicParameters;          // the vairable to record the parameters
    NSDictionary* m_dicImageParas;          // The variable to record the parameters of type UIImage;
    BUBaseResponseData* m_pResponseData;                // The response data
    AFHTTPSessionManager* m_pRequestManager; // The AFHTTPrequest operation manager;
    NSURLSessionDataTask* m_pRequest;        // The post operation
}

@end

@implementation BURequest

@synthesize propUrl = m_strUrl;
@synthesize propParameters = m_dicParameters;
@synthesize propResponseData = m_pResponseData;
@synthesize propRequestTag = m_strRequestTag;

- (void)Init
{
    m_dicParameters = [[NSMutableDictionary alloc] init];
    m_dicImageParas = [[NSMutableDictionary alloc] init];
    m_pRequestManager = [AFHTTPSessionManager manager];
    /*! 设置请求超时时间 */
    m_pRequestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    m_pRequestManager.requestSerializer.timeoutInterval = 30;
    m_pRequestManager.responseSerializer.acceptableContentTypes =  [m_pRequestManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
}

-(id)initWithUrl:(NSString *)argUrl andTag:(NSString *)argTag
{
    self = [super init];
    [self Init];
    m_strUrl = [NSString stringWithFormat:@"%@%@", [AppConfigure GetWebServiceDomain],argUrl];
    m_strRequestTag = argTag;
    return self;
}

- (void)SetParamValue:(NSString*)argValue forKey:(NSString *)argKey;
{
    [m_dicParameters setValue:argValue forKey:argKey];
}

- (void)AddImageData:(UIImage*)argImage forKey:(NSString *)argKey;
{
    [m_dicImageParas setValue:argImage forKey:argKey];
}

-(void)PostAsynchronous
{
    if([m_dicImageParas count] == 0)
    {
        m_pRequest = [m_pRequestManager POST:m_strUrl parameters:m_dicParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self RequestSucceedWithResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self RequestFailureWithError:error];
        }];
    }
    else
    {
        m_pRequest = [m_pRequestManager POST:m_strUrl parameters:m_dicParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSArray* arrKeys = self->m_dicImageParas.allKeys;
            for( NSString* strKey in arrKeys)
            {
                UIImage* pImage = [self->m_dicImageParas objectForKey:strKey];
                NSData *imageData = UIImageJPEGRepresentation(pImage, 0.7);
                [formData appendPartWithFileData:imageData
                                            name:strKey
                                        fileName:@"test.jpg"
                                        mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self RequestSucceedWithResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self RequestFailureWithError:error];
        }];
    }
}

-(void)GetAsynchronous
{
    m_pRequest = [m_pRequestManager GET:m_strUrl parameters:m_dicParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self RequestSucceedWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self RequestFailureWithError:error];
    }];
}

-(void)Cancel
{
    if(m_pRequest != nil)
        [m_pRequest cancel];
}

- (void)RequestSucceedWithResponseObject:(id)responseObject
{
    NSData *serializedData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    id responseJSON = [NSJSONSerialization JSONObjectWithData:serializedData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@---%@", responseObject, m_strRequestTag);
    m_pResponseData =[RMMapper objectWithClass:[BUBaseResponseData class] fromDictionary:responseJSON];
    NSLog(@"%@ --- %@", m_pResponseData, m_strRequestTag);
    
    if(m_pResponseData.stateCode == 1002)
    {
        ///账号别的地方登陆
        NSLog(@"%@",m_pResponseData.errorMsg);
        [[BUShowErrorMsg GetInstance] ShowErrorMessage:m_pResponseData.errorMsg];
    }
    else if (m_pResponseData.stateCode == 1001)
    {
        [[BUShowErrorMsg GetInstance] ShowErrorMessage:m_pResponseData.errorMsg];
        if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(RequestErrorHappened:withErrorMsg:)])
        {
            [self.propDelegate RequestErrorHappened:self withErrorMsg:m_pResponseData.errorMsg];
        }
    }
    else if(m_pResponseData.state_code == 1)
    {
        NSLog(@"%@",m_pResponseData.error_msg);
        
        if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestFailed:)])
        {
            [self.propDelegate RequestFailed:self];
        }
    }
    else if([m_pResponseData class] == [BUBaseResponseData class])
    {
        NSArray* arrData =  [m_pResponseData ParseDataArray:self.propDataClass];
        if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestSucceeded: withResponseData:)])
        {
            [self.propDelegate RequestSucceeded:m_strRequestTag withResponseData:arrData];
        }
    }
    else
    {
        NSArray* arrData = [[NSArray alloc] initWithObjects:m_pResponseData, nil];
        if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestSucceeded: withResponseData:)])
        {
            [self.propDelegate RequestSucceeded:m_strRequestTag withResponseData:arrData];
        }
    }
}

- (void)RequestFailureWithError:(NSError *)error
{
    NSLog(@"%@", error);
    if (error.code == -1009)
    {
        [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"网络异常，请检查网络后重试!"];
    }
    if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestFailed:)])
    {
        [self.propDelegate RequestFailed:self];
    }
}

@end
