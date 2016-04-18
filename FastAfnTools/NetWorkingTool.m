//
//  NetWorkingTool.m
//  FastAfnTools
//
//  Created by 王鹤竹 on 16/4/18.
//  Copyright © 2016年 Wanghezhu. All rights reserved.
//

#import "NetWorkingTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NetWorkingTool

+ (void)getWithURL: (NSString *)URLStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/x-javascript", nil]];
    if (cookie) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    
    [manager GET:URLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
//    [manager GET:URLStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        successBlock(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failureBlock(error);
//    }];
}


+ (void)postWithURL:(NSString *)URLStr parameters:(id)parameters cookie:(NSString *)cookie success:(SUCCESS_BLOCK)successBlock failure:(FAILURE_BLOCK)failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"application/x-javascript", nil]];
    if (cookie) {
        [manager.requestSerializer setValue:cookie forKey:@"Cookie"];
    }
    
    [manager POST:URLStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
//    [manager POST:URLStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        successBlock(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failureBlock(error);
//    }];
}

+ (NSDictionary *)convertStrToBodyDic: (NSString *)bodyStr {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *paraArray = [bodyStr componentsSeparatedByString:@"&"];
    for (NSString *tempStr in paraArray) {
        NSArray *keyValueArray = [tempStr componentsSeparatedByString:@"="];
        
        [dic setObject:keyValueArray[1] forKey:keyValueArray[0]];
    }
    NSDictionary *bodyDic = [dic copy];
    return bodyDic;
}

+ (void)postWithURL:(NSString *)URLStr bodyStr:(NSString *)bodyStr cookie:(NSString *)cookie success:(SUCCESS_BLOCK)successBlock failure:(FAILURE_BLOCK)failureBlock {
    NSDictionary *bodyDic = [NSDictionary dictionary];
    bodyDic = [self convertStrToBodyDic:bodyStr];
    [self postWithURL:URLStr parameters:bodyDic cookie:cookie success:successBlock failure:failureBlock];
}

+ (NSString *) sha1:(NSString *)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (void)cacheGetWithURL:(NSString *)URLStr cookie:(NSString *)cookie success:(SUCCESS_BLOCK)successBlock failure:(FAILURE_BLOCK)failureBlock {
    // cache文件路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName;
    if (cookie) {
        fileName = [self sha1:[NSString stringWithFormat:@"%@_%@", URLStr, cookie]];
    } else {
        fileName = [self sha1:URLStr];
    }
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:fileName];
    [self getWithURL:URLStr cookie:cookie success:^(id responsObject) {
        NSDictionary *dic = responsObject;
        successBlock(responsObject);
        [dic writeToFile:cacheFilePath atomically:YES];
    } failure:^(NSError *error) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:cacheFilePath];
        if (dic) {
            successBlock(dic);
        } else {
            failureBlock(error);
        }
    }];
}

+ (void)cachePostWithURL:(NSString *)URLStr bodyStr:(NSString *)bodyStr cookie:(NSString *)cookie success:(SUCCESS_BLOCK)successBlock failure:(FAILURE_BLOCK)failureBlock {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSString *fileName;
    if (cookie) {
        fileName = [self sha1:[NSString stringWithFormat:@"%@_%@_%@", URLStr, bodyStr, cookie]];
    } else {
        fileName = [self sha1:[NSString stringWithFormat:@"%@_%@", URLStr, bodyStr]];
    }
    NSString *cacheFilePath = [cachePath stringByAppendingPathComponent:fileName];
    [self postWithURL:URLStr bodyStr:bodyStr cookie:cookie success:^(id responsObject) {
        NSDictionary *dic = responsObject;
        successBlock(responsObject);
        [dic writeToFile:cacheFilePath atomically:YES];
    } failure:^(NSError *error) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:cacheFilePath];
        if (dic) {
            successBlock(dic);
        } else {
            failureBlock(error);
        }
    }];
}


@end
