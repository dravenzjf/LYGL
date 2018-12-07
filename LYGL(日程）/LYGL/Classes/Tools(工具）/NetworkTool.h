//
//  NetworkTool.h
//  SDSY
//
//  Created by 蓝布鲁 on 2017/3/23.
//  Copyright © 2017年 蓝布鲁. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

// 请求类型
typedef enum {
    GETType = 1,
    POSTType = 2
}MethodType;

typedef void (^SuccessBlock)(NSDictionary *respondDictionary);
typedef void (^FailureBlock)(NSError *error);

@interface NetworkTool : AFHTTPSessionManager


// 返回单例对象
+(instancetype)shareInstance;

// 请求HTTP方法
-(void)requireMethodType:(MethodType)type
               URLString:(NSString *)urlString
              parameters:(NSDictionary *)parameters
                 success:(SuccessBlock)success
                 failure:(FailureBlock)failure;

@end
