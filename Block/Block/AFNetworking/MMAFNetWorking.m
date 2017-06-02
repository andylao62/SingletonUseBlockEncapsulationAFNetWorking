//
//  MMAFNetWorking.m
//  afnetworking
//
//  Created by YangJie on 2017/6/2.
//  Copyright © 2017年 YangJie. All rights reserved.
//

#import "MMAFNetWorking.h"
#import "AFNetworking.h"

@interface MMAFNetWorking()
@property (nonatomic,strong) AFHTTPSessionManager *afHSM;
@end

@implementation MMAFNetWorking

// 用来保存唯一的单例对象
static MMAFNetWorking *_instance;

/**
 allocWithZone方法的重写是为了防止开发者在外面用此方法创建对象，因为alloc方法中会实现allocWithZone 这个方法，如果只重写alloc方法达不到效果。
 */
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{   //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

/**
 dispatch_once
 在整个程序的运行过程中，始终只执行一次
 */
+ (instancetype)sharedMMAFNetWorking
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        _instance.afHSM = [AFHTTPSessionManager manager];
        _instance.afHSM.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return _instance;
}

/**
 copy相当于一个强指针，重写此方法可以防止创建一个新的对象，这样就是一个比较完美的单例模式了
 */
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (NSURLSessionDataTask *_Nullable)POST:(NSString *_Nonnull)URLString
                             parameters:(id _Nullable )parameters
                               progress:(uploadProgress _Nullable )uploadProgress
                                success:(success _Nullable )success
                                failure:(failure _Nullable )failure
{
    return [self.afHSM POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}
- (NSURLSessionDataTask *_Nullable)GET:(NSString *)URLString parameters:(id)parameters progress:(uploadProgress)uploadProgress success:(success)success failure:(failure)failure
{
    return [self.afHSM GET:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}
@end
