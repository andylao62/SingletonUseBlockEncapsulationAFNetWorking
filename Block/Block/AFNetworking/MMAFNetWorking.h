//
//  MMAFNetWorking.h
//  afnetworking
//
//  Created by YangJie on 2017/6/2.
//  Copyright © 2017年 YangJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

/**
 根据AFNetWorking定义三个block.
 */
typedef void(^success) (NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^failure) (NSURLSessionDataTask * _Nonnull task, id  _Nullable error);
typedef void(^uploadProgress) (NSProgress *_Nonnull);

@interface MMAFNetWorking : NSObject

/**
 把block弄成属性.这一步也可以省略.
 */
@property (nonatomic,copy) success _Nullable successBlock;
@property (nonatomic,copy) failure _Nullable failureBlock;

+ (instancetype _Nullable )sharedMMAFNetWorking;

- (NSURLSessionDataTask *_Nullable)POST:(NSString *_Nonnull)URLString
                    parameters:(id _Nullable )parameters
                      progress:(uploadProgress _Nullable )uploadProgress
                       success:(success _Nullable )success
                       failure:(failure _Nullable )failure;

- (NSURLSessionDataTask *_Nullable)GET:(NSString *_Nonnull)URLString
                             parameters:(id _Nullable )parameters
                               progress:(uploadProgress _Nullable )uploadProgress
                                success:(success _Nullable )success
                                failure:(failure _Nullable )failure;
@end
