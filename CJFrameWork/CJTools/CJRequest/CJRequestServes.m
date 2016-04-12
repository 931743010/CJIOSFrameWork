//
//  MC.h
//  MC
//
//  Created by QDong Email: 285275534@qq.com on 13-2-24.
//  Copyright (c) 2013年 ibluecollar. All rights reserved.
//

#import "CJRequestServes.h"

//#import "MLSelectPhotoAssets.h"
//#import "BasePhotoViewController.h"

#define BASEURL(url_api) [NSString stringWithFormat:@"%@api/%@",CJHTTP_URL,url_api]

#define USE_CHECK 1

static CJRequestServes *_afWebServes=nil;





@implementation CJUploadParam
@end






@implementation CJRequestServes

#pragma mark - common
- (id)init{
    self=[super init];
    if (self) {
    }
    return self;
    
}
+ (id)sharedWebServes{
    static dispatch_once_t predWebServes;
    dispatch_once(&predWebServes, ^{
        _afWebServes=[[CJRequestServes alloc] init];
    });
    return _afWebServes;
}
+(id)alloc
{
    NSAssert(_afWebServes == nil, @"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}


#pragma mark - 监听网络变化
- (void)reach:(void (^)(AFNetworkReachabilityStatus status))back
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"%d", status);
        back(status);
    }];
}




#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    //    manager.requestSerializer.timeoutInterval = 5;
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}




#pragma mark -- 上传图片 --
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(CJUploadParam *)uploadParam
                    success:(void (^)())success
                    failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



#pragma mark - 参数转换
//对dic进行排序并拼接成string
- (NSString*)stringSignedFromDictionary:(NSDictionary*)dict
{
    NSArray* keyArray = [[dict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    NSMutableString* signString = [NSMutableString new];
    for (int i=0;i<keyArray.count;i++) {
        NSString* key = keyArray[i];
        if (i != 0) {
            [signString appendString:@"&"];
        }
        [signString appendFormat:@"%@=%@",key,(dict[key]?dict[key]:@"")];
    }
    return signString;
}
@end

