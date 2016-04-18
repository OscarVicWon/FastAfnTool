//
//  NetWorkingTool.h
//  FastAfnTools
//
//  Created by 王鹤竹 on 16/4/18.
//  Copyright © 2016年 Wanghezhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^SUCCESS_BLOCK)(id responsObject);
typedef void(^FAILURE_BLOCK)(NSError *error);
typedef void(^CACHEFAILURE_BLOCK)(NSError *error, NSString *fileName);

@interface NetWorkingTool : NSObject

+ (void)getWithURL: (NSString *)URLStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;

+ (void)postWithURL: (NSString *)URLStr parameters: (id)parameters cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;

+ (void)postWithURL: (NSString *)URLStr bodyStr: (NSString *)bodyStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;

+ (void)cacheGetWithURL: (NSString *)URLStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;

+ (void)cachePostWithURL: (NSString *)URLStr bodyStr: (NSString *)bodyStr cookie: (NSString *)cookie success: (SUCCESS_BLOCK)successBlock failure: (FAILURE_BLOCK)failureBlock;

@end
